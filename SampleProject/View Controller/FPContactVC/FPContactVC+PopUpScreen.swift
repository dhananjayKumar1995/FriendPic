//
//  FPContactVC+PopUpScreen.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 21/02/22.
//

import Foundation
import UIKit

extension FPContactVC {
    
    //mark:- SHOW POP UP STATIC METHOD
    static func showConfirmPopup(parentVC: UIViewController){
        //creating a reference for the dialogView controller
        if let popupVC = UIStoryboard(name: "Registration", bundle: nil).instantiateViewController(withIdentifier: "FPCommonPopUpVC") as? FPCommonPopUpVC {
            // popupVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            popupVC.modalPresentationStyle = .custom
            popupVC.modalTransitionStyle = .crossDissolve
            //presenting the pop up viewController from the parent viewController
            parentVC.present(popupVC, animated: true)

            //setting the delegate of the dialog box to the parent viewController
            popupVC.delegate = parentVC as? CommonPopUpDelegate
            //presenting the pop up viewController from the parent viewController

        }
    }
}

extension FPContactVC:CommonPopUpDelegate {
    
    func handleAction1(action: Bool, index: Int) {
        let goToNextScreen = storyboard?.instantiateViewController(withIdentifier: "FPPremiumPlanVC") as! FPPremiumPlanVC
        goToNextScreen.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(goToNextScreen, animated: true)
    }
}
