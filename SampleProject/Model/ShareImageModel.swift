//
//  ShareImageModel.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 21/02/22.
//

import Foundation

struct ShareImageModel:Decodable {
    
    let status:Int?
    let message:String?
    var data:ShareImageData?
}
struct ShareImageData:Decodable {
    
    var sharedAt:String?
  //  var shareable:[]
}
