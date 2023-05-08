//
//  ForgotPasswordModel.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 01/02/22.
//

import Foundation

struct ForgotPasswordResponse:Decodable{
    
    let status:Int?
    let message:String?
    let data:OtpData?
    
}

struct OtpData:Decodable {
    
    let otp:Int?
    let email:String?
}
