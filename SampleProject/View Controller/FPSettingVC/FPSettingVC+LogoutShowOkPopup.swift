//
//  FPSettingVC+LogoutShowOkPopup.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 17/02/22.
//

import Foundation
import UIKit
import SwiftUI
extension FPSettingVC {
    
    //mark:- SHOW POP UP STATIC METHOD
    static func showOkPopup(parentVC: UIViewController,type:Types?){
        //creating a reference for the dialogView controller
        if let popupVC = UIStoryboard(name: "Registration", bundle: nil).instantiateViewController(withIdentifier: "FPVerificationSuccessfulVC") as? FPVerificationSuccessfulVC {
            if type == .logout{
                popupVC.types = .logout
            }
            else if type == .delete{
                popupVC.types = .delete
            }
            popupVC.modalPresentationStyle = .custom
            popupVC.modalTransitionStyle = .crossDissolve
            //presenting the pop up viewController from the parent viewController
            parentVC.present(popupVC, animated: true)
            popupVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            popupVC.delegate = parentVC as? PopUpDelegate

        }
    }
}

//MARK:- POP UP DELEGATE to show popup
extension FPSettingVC:PopUpDelegate{
    
    func handleAction1(action: Bool, passwordToken: String) {
        
    }
    
    func handleAction2(action: Bool) {
        switch types{
            
        case .logout:
            logOut()
            
        case .delete:
            deleteAccountApi()
        default:break
        }
        
    }
    
}

