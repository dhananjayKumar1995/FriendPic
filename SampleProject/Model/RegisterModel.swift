//
//  RegisterModel.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 02/02/22.
//

import Foundation

struct RegisterDataModel:Decodable {
    let status:Int?
    let message:String?
    let data:UserData?
}

struct UserData:Decodable {
    
    let name:String?
    let email:String?
    let is_premium_user:String?
    let is_verified:String?
    let email_verified_at:String?
    let last_login_at:String?
    let status:String?
    let is_logged_in:Int?
    let otp:Int?
    let created_at:String?
    let updated_at:String?
}
