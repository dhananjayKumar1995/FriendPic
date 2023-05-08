//
//  ResendOtpModel.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 11/02/22.
//

import Foundation

struct ResendOtpModel:Decodable {
    
    let status:Int?
    let message:String?
    let data:ResendOtpData?
    
}
struct ResendOtpData:Decodable {
    
    let otp:Int?
    let email:String?
    
}
