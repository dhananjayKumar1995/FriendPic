//
//  FPSettingVC+Action.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 16/02/22.
//

import Foundation
import UIKit

extension FPSettingVC {
    
    @IBAction func buttonNotificationTapped(_ sender: Any) {
        let goToNextScreen = storyboard?.instantiateViewController(withIdentifier: "FPNotificationVC") as! FPNotificationVC
        goToNextScreen.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(goToNextScreen, animated: true)
    }
    
    @IBAction func buttonLogoutTapped(_ sender: Any) {
        FPSettingVC.showOkPopup(parentVC: self, type: .logout)
    }
}
