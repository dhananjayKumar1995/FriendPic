//
//  FPHomeVC+RemovePicturePopUp.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 21/02/22.
//

import Foundation
import UIKit

extension FPHomeVC {
    
    //mark:- SHOW POP UP STATIC METHOD
    static func showRemovePicturePopup(parentVC: UIViewController){
        //creating a reference for the dialogView controller
        if let popupVC = UIStoryboard(name: "Registration", bundle: nil).instantiateViewController(withIdentifier: "FPCommonPopUpVC") as? FPCommonPopUpVC {
            // popupVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            popupVC.modalPresentationStyle = .custom
            popupVC.modalTransitionStyle = .crossDissolve
            popupVC.fromHomeScreen = true
            //presenting the pop up viewController from the parent viewController
            parentVC.present(popupVC, animated: true)

            //setting the delegate of the dialog box to the parent viewController
            popupVC.delegate = parentVC as? CommonPopUpDelegate
            //presenting the pop up viewController from the parent viewController

        }
    }
}

//MARK:- DELEGATE METHOD
extension FPHomeVC :CommonPopUpDelegate {
    func handleAction1(action: Bool, index: Int) {
        //removeDashboardImage(userId: userId, index: index)
        removeDashboardImage()
    }
    
}

//MARK:- DELEGATE METHOD
extension FPHomeVC :SharedAtDelegate {
    func isAlreadyShared(isShared: String) {
        getImageData?.data?.sharedAt = isShared
        
    }
    
    
}
