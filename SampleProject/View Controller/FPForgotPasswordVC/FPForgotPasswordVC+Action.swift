//
//  FPForgotPasswordVC+Action.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 21/01/22.
//

import Foundation
import UIKit
extension FPForgotPasswordVC {
      
    func EmailFieldValidation() -> Bool {
        
        guard let email = textFieldEmail.text?.trim(), !email.isEmpty else {
            DisplayBanners.show(message: NSLocalizedString("Please fill Email." , comment: ""))
            
//            labelIncorrectEmail.isHidden = false
//            labelIncorrectEmail.text = "Please enter email."
//            textFieldEmail.layer.borderWidth = 1
//            textFieldEmail.layer.borderColor = Color.appRed.cgColor
            return false
        }
//        labelIncorrectEmail.isHidden = true
//        textFieldEmail.layer.borderWidth = 0
        if  !email.isValidEmail() {
             DisplayBanners.show(message: NSLocalizedString("Email is Incorrect.", comment: ""))
//            labelIncorrectEmail.isHidden = false
//            labelIncorrectEmail.text = "Please enter valid email."
//            textFieldEmail.layer.borderWidth = 1
//            textFieldEmail.layer.borderColor = Color.appRed.cgColor
            
            return false
        }
        
        //        if !password.isValidPassword() {
        //            DisplayBanners.show(message: "Password must be at least 8 characters long must contain a number, an uppercase letter and one special character.".localized())
        //            return false
        //        }
        
        return true
    }
    
    @IBAction func buttonBackArrowTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonVerifyTapped(_ sender: Any) {
        
        if EmailFieldValidation() {
            
            let emailData = textFieldEmail.text?.trim()
            let param = ["email": emailData] as [String:Any]
            print(param)
            view.endEditing(true)
            forgotPassFunc(params: param)
        }
    }
}
