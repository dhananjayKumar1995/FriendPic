//
//  FPNotificationVC+Service.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 15/03/22.
//

import Foundation
import PromiseKit

extension FPNotificationVC {
    
    func getNotification(showLoader:Bool,param:[String:Any]) {

    isLoading = true
    Loader.show()

    firstly {
        service!.notifications(params:param)
    }.done { (model: NotificationModel) in
        self.handleResponse(model: model)
    }.catch {(error) in
        print(error)
        DisplayBanner2.show(title: error.localizedDescription)
    }.finally {
        Loader.hide()
    }
}

    /*
func handleResponse (model: NotificationModel) {

    if model.status != 200{

        DisplayBanner1.show(title:model.message)
        return

    }

    else {
        notification = model
        myTableView.reloadData()
       // Console.log(model)
    }
}
     */
    
    func handleResponse(model: NotificationModel?) {
        currentPageNo += 1
        switch currentLoadingState {
        case .refresh:
            self.notification = model
        case .nextPage:
            setData(model: model)
            break
        }
        myTableView.reloadData()
        let isEmpty = notification?.data?.notifications?.data?.isEmpty ?? false
        if isEmpty {
            myTableView.setEmptyMessage("No notifications found")
        }
        else {
            myTableView.backgroundView = nil
        }
        isLoading = false
        
        if let docs = notification?.data?.notifications?.data {
            for (index, _) in docs.enumerated() {
                notification?.data?.notifications?.data?[index].isSelected = false
            }
        }
    }
    
    func setData(model: NotificationModel?){
        
        if let list = model?.data?.notifications?.data {
            self.notification?.data?.notifications?.data?.append(contentsOf: list)
            
        }
    }

}

