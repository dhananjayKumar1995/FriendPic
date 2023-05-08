//
//  MyUploadPostModel.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 17/02/22.
//

import Foundation

struct GetAllPostModel: Decodable {
    
    let status:Int?
    let message:String?
    var data:MyPost?
}

struct MyPost:Decodable {
    var posts:Data2?
}
struct Data2:Decodable {
    
    let currentPage:Int?
    var data:[AllData]
    let firstPageUrl:String?
    let from:Int?
    let lastPage:Int?
    let lastPageUrl:String?
    let links:[AllLinks]
    //let nextPageUrl:NSNull
    let path:String?
    let perPage:Int
   // let prevPageUrl:NSNull
    let to:Int?
    var total:Int?
}

struct AllData:Decodable {
    
    let id:Int?
    let user_id:Int?
    let sharedAt:String?
    let completed:Int?
//    let upVote:Int?
//    let downVote:Int?
    let createdAt:String?
    let updatedAt:String
    let images:[AllImage]
}

struct AllImage:Decodable {
    
    let id:Int?
    let postId:Int?
    let path:String?
    let createdAt:String?
    let updatedAt:String?
    let upVote:Int?
    let downVote:Int?
    
}

struct AllLinks:Decodable {
    
    let url:String?//CFNull
    let label:String?
    let active:Bool?
}

