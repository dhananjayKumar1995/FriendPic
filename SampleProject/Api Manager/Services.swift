//
//  Services.swift
//  prefGrab
//
//  Created by RAVI K GUPTA on 01/09/21.
//


import PromiseKit
var service: ApiInterface?

struct Console{
    static func log(_ message: Any?){
        print(message ?? "Nothing to log")
        
    }
}
protocol ApiInterface {
    
    func Login<T: Decodable>(params: [String: Any]) -> Promise<T>
    func Signup<T: Decodable>(params: [String: Any]) -> Promise<T>
    func Otpverify<T: Decodable>(params:[String: Any]) -> Promise<T>
    func ForgotPassword<T: Decodable>(params:[String:Any]) -> Promise<T>
    func ResetPassword<T: Decodable>(params:[String:Any]) -> Promise<T>
    func SocialLogin<T: Decodable>(params:[String:Any]) -> Promise<T>
    func GetImage<T: Decodable>(params:[String:Any]) -> Promise<T>
    func ResendOtp<T: Decodable>(params:[String:Any]) -> Promise<T>
    func Logout<T: Decodable>(params:[String:Any]) -> Promise<T>
    func forgotOtpVerify<T: Decodable>(params:[String:Any]) -> Promise<T>
    func myUploadPost<T: Decodable>(params:[String:Any]) -> Promise<T>
    func changePassword<T: Decodable>(params:[String:Any]) -> Promise<T>
    func shareImage<T: Decodable>(params:[String:Any]) -> Promise<T>
    func removeDashboardImage<T: Decodable>(params:[String:Any]) -> Promise<T>
    func notifications<T: Decodable>(params:[String:Any]) -> Promise<T>
    func subscribe<T: Decodable>(params:[String:Any]) -> Promise<T>
    func subscriptionDetail<T: Decodable>(params:[String:Any]) -> Promise<T>
    func deletePostFromUpload<T: Decodable>(postId:Int) -> Promise<T>
    func voting<T: Decodable>(token:String,param:[String:Any] ) -> Promise<T>
    func postViewForOther<T: Decodable>(token:String,param:[String:Any]) -> Promise<T>
    func setDeviceToken<T: Decodable>(param:[String:Any]) -> Promise<T>
    func postReport<T: Decodable>(param:[String:Any]) -> Promise<T>
    func blockUser<T: Decodable>(param:[String:Any]) -> Promise<T>
    func deleteAccount<T: Decodable>(param:[String:Any]) -> Promise<T>


    
    //    func getCountryList<T: Decodable>() -> Promise<T>
    //    func getStateList<T: Decodable>(countryCode:String) -> Promise<T>
    //    func getCityList<T: Decodable>(countryCode:String,stateCode:String) -> Promise<T>
    
}


final class Services: NSObject, ApiInterface {
   
    
   
    
    
    //    func getStateList<T>(countryCode: String) -> Promise<T> where T : Decodable {
    //        client.requestWithParams(.getStateList(countryCode: countryCode))
    //    }
    //
    //    func getCityList<T>(countryCode: String, stateCode: String) -> Promise<T> where T : Decodable {
    //        client.requestWithParams(.getCityList(countryCode:countryCode, stateCode: stateCode))
    //    }
    
    func Login<T>(params: [String : Any]) -> Promise<T> where T : Decodable {
        client.requestWithParams(.login(params: params))
    }
    
    func Signup<T>(params: [String : Any]) -> Promise<T> where T : Decodable {
        client.requestWithParams(.signup(params: params))
    }
    
    func Otpverify<T>(params: [String : Any]) -> Promise<T> where T : Decodable {
        client.requestWithParams(.otpVerify(params: params))
    }
    
    func ForgotPassword<T>(params: [String : Any]) -> Promise<T> where T : Decodable {
        client.requestWithParams(.forgotPassword(params: params))
    }
    
    func ResetPassword<T>(params: [String : Any]) -> Promise<T> where T : Decodable {
        client.requestWithParams(.resetPassword(params: params))
    }
    
    func SocialLogin<T>(params: [String : Any]) -> Promise<T> where T : Decodable {
        client.requestWithParams(.socialLogin(params: params))
    }
    
    func GetImage<T>(params: [String : Any]) -> Promise<T> where T : Decodable {
        client.requestWithParams(.getImage(params: params))
    }
    
    func ResendOtp<T>(params: [String : Any]) -> Promise<T> where T : Decodable {
        client.requestWithParams(.resendOtp(params: params))
    }
    
    func Logout<T>(params: [String : Any]) -> Promise<T> where T : Decodable {
        client.requestWithParams(.logout(params: params))
    }
    
    func forgotOtpVerify<T>(params: [String : Any]) -> Promise<T> where T : Decodable {
        client.requestWithParams(.forgotOtpVerify(params: params))
    }
    
    func myUploadPost<T>(params: [String : Any]) -> Promise<T> where T : Decodable {
        client.requestWithParams(.myUploadPost(params: params))
    }
    
    func changePassword<T>(params: [String : Any]) -> Promise<T> where T : Decodable {
        client.requestWithParams(.changePassword(params: params))
    }
    
    func shareImage<T>(params: [String : Any]) -> Promise<T> where T : Decodable {
        client.requestWithParams(.shareImage(params: params))
    }
    
    func removeDashboardImage<T>(params: [String : Any]) -> Promise<T> where T : Decodable {
        client.requestWithParams(.removeDashboardImage(params: params))
    }
    
    func notifications<T>(params: [String : Any]) -> Promise<T> where T : Decodable {
        client.requestWithParams(.notifications(params: params))
    }
    
    func subscribe<T>(params: [String : Any]) -> Promise<T> where T : Decodable {
        client.requestWithParams(.subscribe(params: params))
    }
    
    func subscriptionDetail<T>(params: [String : Any]) -> Promise<T> where T : Decodable {
        client.requestWithParams(.subscriptionDetail(params: params))
    }
    
    func deletePostFromUpload<T>(postId: Int) -> Promise<T> where T : Decodable {
        client.requestWithParams(.deletePostFromUpload(postId: postId))
    }
    
    func voting<T>(token: String, param:[String:Any]) -> Promise<T> where T : Decodable {
        client.requestWithParams(.voting(token: token, param: param))
    }
    func postViewForOther<T>(token: String,param:[String:Any]) -> Promise<T> where T : Decodable {
        client.requestWithParams(.postViewForOther(token: token,param: param))
    }
    
    func setDeviceToken<T>(param:[String:Any]) -> Promise<T> where T : Decodable {
        client.requestWithParams(.setDeviceToken(params: param))
    }
    
    func postReport<T>(param: [String : Any]) -> Promise<T> where T : Decodable {
        client.requestWithParams(.postReport(params: param))
    }
    
    func blockUser<T>(param: [String : Any]) -> Promise<T> where T : Decodable {
        client.requestWithParams(.blockUser(params: param))

    }
    
    func deleteAccount<T>(param: [String : Any]) -> Promise<T> where T : Decodable {
        client.requestWithParams(.deleteAccount(params: param))

    }
    //    func getCountryList<T>() -> Promise<T> where T : Decodable {
    //        client.requestWithParams(.getCountryList)
    //    }
    private let client = Client()
    
    
}

