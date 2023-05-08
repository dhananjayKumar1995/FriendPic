//
//  NotificationModel.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 15/03/22.
//

import Foundation

struct NotificationModel:Decodable {
    
    let status:Int?
    let message:String?
    var data:NotificationData?
}

struct NotificationData:Decodable {
    
    var notifications:Notifications?
    
}
struct Notifications:Decodable {
    
    let currentPage:Int?
    var data:[NotificationInnerData]?
    let firstPageUrl:String?
    let from:Int?
    let lastPage:Int?
    let lastPageUrl:String?
    let links:[NotificationLinks]?
   // let nextPageUrl:null
    let path:String?
    let perPage:Int?
  //  let prevPageUrl:null
    let to:Int?
    let total:Int?
    
}

struct NotificationInnerData:Decodable {
    
    let id:Int?
    let userId:Int?
    let opponentUserId:Int?
    let message:String?
    let isSeen:Int?
    let createdAt:String?
    let updatedAt:String?
    let opponentUser:NotificationInnerDataOpponentUser?
    var isSelected:Bool?
    
    
}

struct NotificationInnerDataOpponentUser :Decodable {
    
    let id:Int?
    let accountType:String?
    var name:String?
    let email:String?
    //let profilePic:null
    //let passwordResetToken:null
    let isPremiumUser:String?
    let isVerified:String?
    let status:String?
    let isLoggedIn:Int?
    let emailVerifiedAt:String?
    let lastLoginAt:String?
    let createdAt:String?
    let updatedAt:String?
    
}

struct NotificationLinks:Decodable {
    
    let url:String?
    let label:String?
    let active:Bool?
}
