//
//  FPPreviewVC+BlockUserPopUp.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 10/06/22.
//

//

import Foundation
import UIKit

extension FPPreviewVC{
    
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
            popupVC.buttonConfirm.setTitle("Ok", for: .normal)
            popupVC.labelGetPremiumPlan.text = "Block User"
            popupVC.labelGetPremiumPlan.textColor = Color.appBlack
            popupVC.labelPremiumDiscreption.text = "Are you sure you want to block this user\nAfter blocking you will not be able to get post from this user"
        }
    }
    
}
extension FPPreviewVC:CommonPopUpDelegate {
    
    func handleAction1(action: Bool, index: Int) {
        let token = urlStr.components(separatedBy: "=").first ?? ""
        let url = token + "=" + phoneNumber
        let param = ["link":url]
        blockUser(params: param)
      }
    }
