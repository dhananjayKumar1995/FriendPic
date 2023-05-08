//
//  SubscriptionDetailModel.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 08/03/22.
//

import Foundation

struct SubscriptionDetailModel:Decodable {
    
    let status:Int?
    let message:String?
    let data:SubscriptionDetailData?
}

struct SubscriptionDetailData:Decodable {
    
    let subscription:SubscriptionDetailSubscription?
    
}

struct SubscriptionDetailSubscription:Decodable {
    
    let id:Int?
    let userId:Int?
    let planId:Int?
    let iosSubscriptionId:String?
    let isExpired:Int?
    let isPurchased:Int?

    let expiredAt:String?
    let createdAt:String?
    let updatedAt:String?
    let plan:SubscriptionDetailPlan?
}

struct SubscriptionDetailPlan:Decodable {
    
    let id:Int?
    let name:String?
    let price:Double?
    let validityInMonth:Int?
    let active:Int?
    let createdAt:String?
    let updatedAt:String?
    
    
}
