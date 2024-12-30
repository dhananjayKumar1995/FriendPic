//
//  GetImageModel.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 09/02/22.
//

import Foundation

struct GetDashboardImageModel:Decodable {
    
    let status:Int?
    let message:String?
    var data:ImageData?
}

struct ImageData:Decodable {
    
    var sharedAt:String?
//    let upVote:Int?
//    let downVote:Int?
    var images:[ImageObject]
    var newNotificationCount:Int?
    var shareable:[ImageDataShareable]?
}

struct ImageDataShareable:Decodable {
    var name:String?
    var mobile:String?
    var linke:String?
}
struct ImageObject:Decodable {
    let upVote:Int?
    let downVote:Int?
    let id:Int?
    let post_id:Int?
    let userId:Int?
    let path: String?
    let completed:Int?
    let created_at: String?
    let updated_at: String?
}
