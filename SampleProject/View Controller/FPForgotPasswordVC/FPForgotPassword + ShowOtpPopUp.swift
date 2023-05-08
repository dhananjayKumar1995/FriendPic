//
//  FPForgotPassword + ShowOtpPopUp.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 14/02/22.
//

import Foundation
import UIKit

extension FPForgotPasswordVC{
    
    //mark:- SHOW POP UP STATIC METHOD
    static func showOtpPopup(parentVC: UIViewController){
        //creating a reference for the dialogView controller
        if let popupVC = UIStoryboard(name: "Registration", bundle: nil).instantiateViewController(withIdentifier: "FPEmailVerifyVC") as? FPEmailVerifyVC {
           // popupVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            popupVC.modalPresentationStyle = .custom
            popupVC.modalTransitionStyle = .crossDissolve
            popupVC.fromForgotPassword = true
            popupVC.email = (parentVC as? FPForgotPasswordVC)?.textFieldEmail.text ?? ""
           // popupVC.delegate = self as? PopUpDelegate
            //presenting the pop up viewController from the parent viewController
            parentVC.present(popupVC, animated: true)
            
            //setting the delegate of the dialog box to the parent viewController
            popupVC.delegate = parentVC as? PopUpDelegate
            //presenting the pop up viewController from the parent viewController
        }
    }
    
}
extension FPForgotPasswordVC :PopUpDelegate {

    func handleAction1(action: Bool,passwordToken: String) {
        self.passwordTokens = passwordToken
        FPForgotPasswordVC.showOkPopup(parentVC: self)
    }
    
    func handleAction2(action: Bool) {
        let goToNextScreen = storyboard?.instantiateViewController(withIdentifier:  "FPResetPasswordVC")as! FPResetPasswordVC
        goToNextScreen.passwordToken = passwordTokens
        self.navigationController?.pushViewController(goToNextScreen, animated: true)
    }
    
    
}

extension FPForgotPasswordVC {
    
    //mark:- SHOW POP UP STATIC METHOD
    static func showOkPopup(parentVC: UIViewController){
        //creating a reference for the dialogView controller
        if let popupVC = UIStoryboard(name: "Registration", bundle: nil).instantiateViewController(withIdentifier: "FPVerificationSuccessfulVC") as? FPVerificationSuccessfulVC {
            popupVC.modalPresentationStyle = .custom
            popupVC.modalTransitionStyle = .crossDissolve
            //presenting the pop up viewController from the parent viewController
           // popupVC.delegate = self as? PopUpDelegate
            parentVC.present(popupVC, animated: true)
           
            //setting the delegate of the dialog box to the parent viewController
            popupVC.delegate = parentVC as? PopUpDelegate
            
            popupVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            
        }
    }
    
}

struct ForgotPassOtpVerifyModel:Decodable {
    
    let status:Int?
    let message:String?
    let data:PasswordClassToken?
}

struct PasswordClassToken:Decodable {
    
    let passwordResetToken:String?
}
