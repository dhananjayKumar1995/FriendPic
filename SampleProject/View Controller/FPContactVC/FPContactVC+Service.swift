//
//  FPContactVC+Service.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 18/02/22.
//

import Foundation
import PromiseKit

extension FPContactVC {
    
    func shareImage(params: [String:Any]) {
        
        Loader.show()
        
        firstly {
            service!.shareImage(params:params)
        }.done { (model: ShareImageModel) in
            self.handleResponse(model: model)
        }.catch {(error) in
            print(error)
            DisplayBanner1.show(title: error.localizedDescription)
        }.finally {
            Loader.hide()
        }
    }
    
    func handleResponse (model: ShareImageModel) {
        
        if model.status != 200{
            
            DisplayBanner1.show(title:model.message)
            return
            
        }
        NotificationCenter.default.post(name: .shareImageURL, object: nil,userInfo: ["shareImageURL":model.data?.shareable?.first?.link ?? ""])
        
        DisplayBanner2.show(title:model.message)
        NotificationCenter.default.post(name: .sharedAt, object: nil, userInfo: nil)
        //NotificationCenter.default.post(name: .sharedAt, object: nil, userInfo: ["sharedAt":model.data?.sharedAt ?? ""])
        self.delegate?.isAlreadyShared(isShared: "shared")
        self.navigationController?.popViewController(animated: true)
        Console.log(model)
        
    }
    
    func subscriptionDetail() {

        Loader.show()

        firstly {
            service!.subscriptionDetail(params: [:])
        }.done { (model: SubscriptionDetailModel) in
            self.handleResponse(model: model)
        }.catch {(error) in
            print(error)
            DisplayBanner2.show(title: error.localizedDescription)
        }.finally {
            Loader.hide()
        }
    }

    func handleResponse (model: SubscriptionDetailModel) {
//        if model.status != 200{
//           // DisplayBanner1.show(title:model.message)
//            return
//        }
        kAppDelegate.mySubscription = model
    }
}


// MARK: - Welcome
struct ShareContactModel: Codable {
    let status: Int
    let message: String
    let data: ShareContactData?
}

// MARK: - DataClass
struct ShareContactData: Codable {
    let sharedAt: String?
    let shareable: [Shareable]?

}

// MARK: - Shareable
struct Shareable: Codable {
    let name, mobile: String?
    let link: String?
}
