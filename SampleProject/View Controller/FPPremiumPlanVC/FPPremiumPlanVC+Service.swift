//
//  FPPremiumPlanVC+Service.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 08/03/22.
//

import Foundation
import PromiseKit

extension FPPremiumPlanVC {
    
    //MARK: - PURCHASE SUBSCRIPTION API
    
    func subscribe(params: [String: Any],currentSubscriptionType:SubscriptionType){
        Loader.show()
        firstly{
            service!.subscribe(params: params)
        }.done { (model: SubscriptionDetailModel) in
            self.handleResponse1(model: model)
        }.catch { (error) in
            print(error)
            DisplayBanner1.show(title: error.localizedDescription)
        }.finally {
            Loader.hide()
        }
    }
    
    func handleResponse1(model: SubscriptionDetailModel) {
        
        if model.status != 200 {
            DisplayBanner1.show(title:model.message)
            return
        }
        kAppDelegate.mySubscription = model
        DisplayBanner2.show(title:model.message)
        Console.log(model)
        myTableView.reloadData()
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - CHECK SUBSCRIPTION STATUS API
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
//            DisplayBanner1.show(title:model.message)
//            return
//        }
        kAppDelegate.mySubscription = model
        myTableView.reloadData()
    }
}
