//
//  FPSignUpVC+ShowOkPopUp.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 31/01/22.
//

import Foundation
import UIKit
extension FPSignUpVC {

    //mark:- SHOW POP UP STATIC METHOD
    static func showOkPopup(parentVC: UIViewController){
        //creating a reference for the dialogView controller
        if let popupVC = UIStoryboard(name: "Registration", bundle: nil).instantiateViewController(withIdentifier: "FPVerificationSuccessfulVC") as? FPVerificationSuccessfulVC {
            // popupVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            popupVC.modalPresentationStyle = .custom
            popupVC.modalTransitionStyle = .crossDissolve
            //presenting the pop up viewController from the parent viewController
            parentVC.present(popupVC, animated: true)

            //setting the delegate of the dialog box to the parent viewController
            popupVC.delegate = parentVC as? PopUpDelegate
            popupVC.buttonCancel.isHidden = true
            //presenting the pop up viewController from the parent viewController

        }
    }

}
