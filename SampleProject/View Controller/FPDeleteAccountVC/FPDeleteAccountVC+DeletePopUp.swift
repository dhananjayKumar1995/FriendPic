//
//  FPDeleteAccountVC+DeletePopUp.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 22/07/22.
//

import Foundation
import UIKit
import SwiftUI
extension FPDeleteAccountVC {
    
    //mark:- SHOW POP UP STATIC METHOD
    static func showOkPopup(parentVC: UIViewController){
        //creating a reference for the dialogView controller
        if let popupVC = UIStoryboard(name: "Registration", bundle: nil).instantiateViewController(withIdentifier: "FPVerificationSuccessfulVC") as? FPVerificationSuccessfulVC {
            
            popupVC.modalPresentationStyle = .custom
            popupVC.modalTransitionStyle = .crossDissolve
            popupVC.types = .delete
            //presenting the pop up viewController from the parent viewController
            parentVC.present(popupVC, animated: true)
            popupVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            popupVC.delegate = parentVC as? PopUpDelegate

        }
    }
}
//MARK:- POP UP DELEGATE to show popup
extension FPDeleteAccountVC:PopUpDelegate{
    
    func handleAction1(action: Bool, passwordToken: String) {
        
    }
    
    func handleAction2(action: Bool) {
        
        let param = ["password":textFieldPassword.text]
        deleteAccountApi(params: param as [String : Any])
        print("Request,\(param)")
        view.endEditing(true)

    }
    
}
