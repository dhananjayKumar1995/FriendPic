//
//  ChangePasswordModel.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 21/02/22.
//

import Foundation

struct ChangePasswordModel:Decodable {
    
    let status:Int?
    let message:String?
    let data:ChangeData?
}

struct ChangeData:Decodable {
    
}
