//
//  Client.swift
//  prefGrab
//
//  Created by RAVI K GUPTA on 01/09/21.
//

import Alamofire
import PromiseKit
import Foundation

struct MultiPart{
    let data: Data
    let fileNameWithExt: String
    let serverKey: String
    let mimeType: MediaFileType
}
enum MediaFileType: String {
    case image = "image/png"
    case video = "video/mov"
}

enum Result<T> {
    case success(T)
    case failure(Error?)
    case noNetwork(Error)
    case progress(Float)
    case noDataFound(String)
    case pageNotFound
}

final class Client {
    
    let session:  Session!
    let decoder = JSONDecoder()
    init() {
        let logger = Logger()
        session = Session(eventMonitors: [logger])
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
    }
    
    func requestWithParams<T: Decodable>(_ router: Router) -> Promise <T> {
        return Promise { seal in
            session.request(router).validate(statusCode: 200..<500).responseDecodable(of: T.self, decoder: decoder) { (response) in
                switch response.result{
                case .success(let data):
                    print(data)
                    seal.fulfill(data)
                case .failure(let error):
                    seal.reject(self.actualError(error: error, data: response.data, statusCode: response.response?.statusCode))
                }
            }
        }
    }
    
    
    //     func upload<T: Decodable>(_ resource: Resource, onProgress: @escaping (Double)-> (),
    //                               parameters: [String: Any]?) -> Promise <T> {
    //         return Promise { seal in
    //
    //             let method = resource.resource.method
    //             var url = "\(baseURL)\(resource.resource.endPoint)"
    //             if resource.resource.endPoint.contains("http"){
    //                 url = resource.resource.endPoint
    //             }
    //             Console.log("LoaderShow")
    //             session.upload(multipartFormData: { multiPart in
    //
    //
    //                 guard let params = parameters else{
    //                     print("Debug1")
    //                     return
    //                 }
    //                 for (key, value) in params {
    //                     if let allMedia = value as? [MultiPart]{
    //                         let allkeys = allMedia.map({$0.serverKey})
    //                         let unique = Array(Set(allkeys))
    //                         for serverKey in unique{
    //                             let uploadFile = allMedia.filter({$0.serverKey == serverKey})
    //                             if uploadFile.count > 1 {
    //                                 for media in uploadFile{
    //                                     multiPart.append(media.data, withName: "\(media.serverKey)", fileName: media.fileNameWithExt, mimeType: media.mimeType.rawValue)
    //                                 }
    //                             }else{
    //                                 if let media = uploadFile.first{
    //                                     print("Debug2r453")
    //                                     multiPart.append(media.data, withName: media.serverKey, fileName: media.fileNameWithExt, mimeType: media.mimeType.rawValue)
    //                                 } else {
    //                                     print("Debug2")
    //                                 }
    //                             }
    //                         }
    //                     }else if let media = value as? MultiPart{
    //
    //                         print("Debug3rrrr")
    //                         multiPart.append(media.data, withName: media.serverKey, fileName: media.fileNameWithExt, mimeType: media.mimeType.rawValue)
    //                     }else if let data = "\(value)".data(using: .utf8) {
    //                         multiPart.append(data, withName: key)
    //
    //                         print("Debug4rrrr")
    //                     } else {
    //                         print("Debug4")
    //                     }
    //
    //                 }
    //             },to: url, method: method, headers: HTTPHeaders(getHeaderData(resource)))
    //                 .uploadProgress(queue: .main, closure: { progress in
    //                     onProgress(progress.fractionCompleted)
    //                 })
    //                 .responseDecodable(of: T.self) { (response) in
    //                     switch response.result{
    //                     case .success(let data):
    //                         seal.fulfill(data)
    //                     case .failure(let error):
    //                         seal.reject(self.actualError(error: error))
    //                     }
    //                     self.logRequest(response: response, param: parameters)
    //                     self.logResponse(data: response.data)
    //
    //             }
    //         }
    //     }
    
    
    
    func actualError(error: AFError, data: Data?, statusCode: Int?) -> Error{
        if statusCode == 401{
            // kAppDelegate.logoutUser()
            kAppDelegate.deleteData()
            kAppDelegate.checkToLoadScreen()
        }
        if let underlyingError = error.underlyingError {
            if let urlError = underlyingError as? URLError {
                switch urlError.code {
                case .notConnectedToInternet:
                    return NSError(domain:"com.prefGrab.error", code:urlError.code.rawValue, userInfo:[ NSLocalizedDescriptionKey: "The Internet connection appears to be offline."])
                case .networkConnectionLost:
                    return NSError(domain:"com.prefGrab.error", code:urlError.code.rawValue, userInfo:[ NSLocalizedDescriptionKey: "The network connection has been lost while trying to reach our server."])
                default:
                    
                    return error
                }
            }
        }
        return error
        
    }
    class func getModel<T: Decodable>(object: Any) -> T?{
        do{
            let data = try JSONSerialization.data(withJSONObject: object, options: .fragmentsAllowed)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return  try decoder.decode(T.self, from: data)
        }catch{
            print("\(error)")
        }
        return nil
    }
    
    class  func getModel<T: Decodable>(data: Data) -> T?{
        do{
            return  try JSONDecoder().decode(T.self, from: data)
        }catch{
            print("\(error)")
        }
        return nil
    }
    
    class func requestMultipartApiServer(methodName:String, parameters: [String:Any]?, methodType: HTTPMethod, showLoader: Bool = true, result: @escaping (Result<Any>) -> () , _ onProgress: @escaping (Double)-> ())  {
        
        let serviceUrlPathString = ServerURL.baseURL+methodName
        print(serviceUrlPathString)
        var headers = [String: String]()
        // headers = ["Accept": "application/json"]
        if let token =  kUserDefaults.string(forKey: "token"){
            headers = [
                "Authorization": "Bearer \(token)",
                "Accept": "application/json"
                //"Bearer-Token": "Bearer \(token)",
                
            ]
            print(token)
        }
        AF.upload(multipartFormData: { multiPart in
            guard let params = parameters else{return}
            for (key, value) in params {
                if let allMedia = value as? [MultiPart]{
                    let allkeys = allMedia.map({$0.serverKey})
                    let unique = Array(Set(allkeys))
                    for serverKey in unique{
                        let uploadFile = allMedia.filter({$0.serverKey == serverKey})
                        if uploadFile.count > 1 {
                            for media in uploadFile{
                                multiPart.append(media.data, withName: "\(media.serverKey)", fileName: media.fileNameWithExt, mimeType: media.mimeType.rawValue)
                            }
                        }else{
                            if let media = uploadFile.first{
                                multiPart.append(media.data, withName: media.serverKey, fileName: media.fileNameWithExt, mimeType: media.mimeType.rawValue)
                            }
                        }
                    }
                }else if let media = value as? MultiPart{
                    multiPart.append(media.data, withName: media.serverKey, fileName: media.fileNameWithExt, mimeType: media.mimeType.rawValue)
                }else if let data = value as? [[String:Any]]{
                    if let arr =  getData(value: data) {
                        multiPart.append(arr, withName: key)
                    }
                    
                }else if let data = value as? [String] {
                    
                    if let arr =  getData(value: data) {
                        multiPart.append(arr, withName: key)
                    }
                }else if let data = "\(value)".data(using: .utf8) {
                    multiPart.append(data, withName: key)
                }
                
            }
        },to: serviceUrlPathString, method: methodType, headers: HTTPHeaders(headers))
            .uploadProgress(queue: .main, closure: { progress in
                onProgress(progress.fractionCompleted)
            })
            .responseJSON(completionHandler:  { (response) in
                switch response.result{
                case .success(let data):
                    result(Result.success(data))
                case .failure(let error):
                    result(Result.failure(error))
                }
                // self.logRequest(response: response, param: parameters)
                // self.logResponse(data: response.data)
                //
                
                if let value = response.value {
                    
                    Console.log(Logger.prettyPrintDict(with:value))
                } else {
                    
                    DisplayBanner1.show(title: "try again.")
                }
            }
            )}
    
    class func getData(value:Any)->Data? {
        
        return try? JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
        
    }
}



