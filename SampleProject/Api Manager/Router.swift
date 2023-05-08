//
//  Router.swift
//  prefGrab
//
//  Created by RAVI K GUPTA on 01/09/21.
//

import Alamofire
import UIKit
import SwiftUI

public enum Router {
    public typealias Params = [String: Any]
    
    case login(params: Params)
    case signup(params: Params)
    case otpVerify(params: Params)
    case forgotPassword(params:Params)
    case resetPassword(params:Params)
    case socialLogin(params:Params)
    case getImage(params:Params)
    case resendOtp(params:Params)
    case logout(params:Params)
    case forgotOtpVerify(params:Params)
    case myUploadPost(params:Params)
    case changePassword(params:Params)
    case shareImage(params:Params)
    case removeDashboardImage(params:Params)
    case notifications(params:Params)
    case subscribe(params:Params)
    case subscriptionDetail(params:Params)
    case deletePostFromUpload(postId:Int)
    case voting(token:String,param:Params)
    case postViewForOther(token:String,param:Params)
    case setDeviceToken(params:Params)
    case postReport(params: Params)
    case blockUser(params: Params)
    case deleteAccount(params: Params)


    //    case getCountryList
    //    case getStateList(countryCode: String)
    //    case getCityList(countryCode:String,stateCode:String)
    
}
extension Router:  Alamofire.URLRequestConvertible {
    
    public func asURLRequest () throws -> URLRequest {
        var config = self.requestConfig
        var baseURL: URL {
            switch self {
                //            case .getCountryList,.getStateList,.getCityList:
                //                return URL(string: ServerURL.baseURLForRegion)!
                
            default:
                //if config.endPoint.contains("post")
                return URL(string: ServerURL.baseURL)!
            }
        }
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(config.endPoint))
        urlRequest.httpMethod = config.method.rawValue
        
        //        if let token =  kUserDefaults.value(forKey: AppKeys.token) as? String{
        //            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        //        }
        
        switch self {
            //        case .getCountryList,.getStateList,.getCityList:
            //            urlRequest.setValue("Wkl2dXNUT3BBUjU0R1NoTWVUeHZKaWpmandLRTZWUVoyTGgwS3psaA==", forHTTPHeaderField: "X-CSCAPI-KEY")
        default:
            if let token = kUserDefaults.string(forKey:AppKeys.token) {
                
                let token = token
                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
            }
        }
        
        
        
        if let params = config.params, params.count > 0 {
            switch config.method {
            case .get:
                var urlComponents = URLComponents(url: urlRequest.url!, resolvingAgainstBaseURL: false)!
                urlComponents.queryItems = params.map { URLQueryItem(name: $0, value: "\($1)")}
                urlRequest.url = urlComponents.url!
                return urlRequest
            default:
                return try JSONEncoding.default.encode(urlRequest, with: params)
            }
        } else {
            return try JSONEncoding.default.encode(urlRequest)
        }
    }
    
}

extension Router {
    var requestConfig: (endPoint: String, params: Params?, method: Alamofire.HTTPMethod) {
        switch self {
            
        case .login(let params):
            return ("auth/login", params, .post)
            
        case .signup(let params):
            return ("auth/register", params, .post)
            
        case .otpVerify(let params):
            return ("auth/verify-otp", params, .post)
            
        case .forgotPassword(let params):
            return ("auth/forget-password", params, .post)
            
        case .resetPassword(let params):
            return ("auth/reset-password", params, .post)
            
        case .socialLogin(params: let params):
            return ("auth/social-login", params, .post)
            
        case .getImage(params: let params):
            return ("image/get-dashboard-images", params, .get)
            
        case .resendOtp(params: let params):
            return ("auth/resend-otp",params, .post)
            
        case .logout(params: let params):
            return ("auth/logout",params, .post)
            
        case .forgotOtpVerify(params: let params):
            return ("auth/forget-password-verify-otp",params, .post)
            
        case .myUploadPost(params: let params):
            return ("image/get-all-posts",params, .get)
            
        case .changePassword(params: let params):
            return ("auth/change-password",params, .post)
            
        case .shareImage(params: let params):
            return ("/image/share",params, .post)
            
        case .removeDashboardImage(params: let params):
            return ("/image/remove",params,.delete)
            
        case .notifications(params: let params):
            return ("/notification/get-all",params, .get)
            
        case .subscribe(params: let params):
            return ("/subscription/subscribe",params, .post)
            
        case .subscriptionDetail(params: let params):
            return ("/subscription/details", params, .get)
            
        case .deletePostFromUpload(let postId):
            return ("/image/delete/\(postId)", nil, .delete)
            
        case .voting(token: let token, param: let param):
            return ("/vote/\(token)", param, .post)
            
        case .postViewForOther(token: let token,param: let param):
            return ("/post/\(token)", nil, .get)
            
        case .setDeviceToken(params: let param):
            return ("auth/set-device-token", param, .post)
        
        case .postReport(params: let params):
            return("/image/report-post",params,.post)
            
        case .blockUser(params: let params):
            return("/block",params,.post)

        case .deleteAccount(params: let params):
            return("/auth/delete-account",params,.post)

        }
    }
}

struct ServerURL {
    static let baseURL = "http://35.154.184.209/api"
    static let baseURL1 = "http://35.154.184.209"
}

// http://3.215.231.136:3000/api/app/
// http://3.215.231.136:3000/api/app/contact/check-contact
//http://3.215.231.136:3000/api/app/post/get-user-post/akshay/1
// {{server}}/app/post/get-user-post?search_text=akshay&page=1

struct  SocketEvents {
    
    //  static let socketBaseURL = "http://3.215.231.136:3000?token=\(kUserDefaults.string(forKey:AppKeys.token))"
    
    
    static let socketBaseURL = "http://3.215.231.136:3000/"
    
    
    
    // Comment On Post
    static let initialize = "init"
    
    //Chat
    static let chatParticipantsList = "chatParticipantsList"
    static let sendMessage = "sendMessage"
    static let receiveMessage = "receiveMessage"
    static let unreadMessages = "unreadMessages"
    static let userBlock = "userBlock"
    static let block = "block"
    static let userOffline = "userOffline"
    static let userOnline = "userOnline"
    static let getOnlineStatus = "getOnlineStatus"
    //Group Chat
    static let joinGroupRoomEvent = "joinGroupRoom"
    static let joinCommentRoomEvent = "joinCommentBox"
    
    // Comment
    
    static let sendComment = "sendComment"
    static let replyOnComment = "replyOnComment"
    
    // Read Receipt
    
    static let messageDelivered = "messageDelivered"
    static let messageRead = "messageRead"
    
    // Message Delivered
    
    static let msgDelivered = "msgDelivered"
    
}
