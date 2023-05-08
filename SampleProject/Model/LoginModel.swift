//
//  LoginModel.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 01/02/22.
//

import Foundation

struct UserDataModel:Decodable {
    
    let status:Int?
    let error:String?
    let message:String?
    let data:UserDatas?
}

struct UserDatas:Decodable {
    
    let token:String?
    let user:User?
}

struct User:Decodable {
    
    let id:Int?
    let name:String?
    let email:String?
    let is_premium_user:String?
    let isVerified:String?
   // let email_verified_at:NSNull
    //let last_login_at:NSNull
    let status:String?
    let is_logged_in:Int?
    let otp:String?
    let created_at:String?
    let updated_at:String?
    let socialId:String?
    let accountType:String?
}
