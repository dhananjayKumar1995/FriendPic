//
//  FPSignUpVC+ShowOtpPop.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 31/01/22.
//

import Foundation
import UIKit

extension FPSignUpVC{
    
    //mark:- SHOW POP UP STATIC METHOD
    static func showOtpPopup(parentVC: UIViewController){
        //creating a reference for the dialogView controller
        if let popupVC = UIStoryboard(name: "Registration", bundle: nil).instantiateViewController(withIdentifier: "FPEmailVerifyVC") as? FPEmailVerifyVC {
           // popupVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            popupVC.modalPresentationStyle = .custom
            popupVC.modalTransitionStyle = .crossDissolve
            popupVC.email = (parentVC as? FPSignUpVC)?.textFieldEmail.text ?? ""
            //presenting the pop up viewController from the parent viewController
            parentVC.present(popupVC, animated: true)
            
            //setting the delegate of the dialog box to the parent viewController
            popupVC.delegate = parentVC as? PopUpDelegate
            //presenting the pop up viewController from the parent viewController
        }
    }
    
}

