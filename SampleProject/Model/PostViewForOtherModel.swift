//
//  PostViewForOtherModel.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 05/03/22.
//

import Foundation

struct PostViewForOther:Decodable {
    
    let status:Int?
    let message:String?
    let data:PostViewForOtherData?
}

struct PostViewForOtherData:Decodable {
    
    let post:PostViewForOtherPost?
}
struct PostViewForOtherPost:Decodable {
    
    let id:Int?
    let userId:Int?
    let sharedAt:String?
    let completed:Int?
    let upVote:Int?
    let downVote:Int?
    let createdAt:String?
    let updatedAt:String?
    let images:[PostViewForOtherImages]?
    
}

struct PostViewForOtherImages: Decodable {
    
    let id:Int?
    let postId:Int?
    let path:String?
    let createdAt:String?
    let updatedAt:String?
    
}
