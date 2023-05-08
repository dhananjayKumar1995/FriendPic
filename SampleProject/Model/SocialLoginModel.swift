//
//  SocialLoginModel.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 07/02/22.
//

import Foundation

struct SocialLoginModel: Decodable {
    
    let status:Int?
    let message:String?
    let data:SocialData?
}
struct SocialData: Decodable {
    
   
    let token:String?
    let user:SocialUser?
    
}
struct SocialUser:Decodable {
    
    let name:String?
    let email:String?
    let accountType:String?
    let socialId:String?
    let prifilePic:String?
    let otp:Int?
    let updatedAt:String?
    let createdAt:String?
    let id:Int?
    
}
