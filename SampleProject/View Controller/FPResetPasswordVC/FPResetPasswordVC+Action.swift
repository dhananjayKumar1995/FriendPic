//
//  FPResetPasswordVC+Action.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 25/01/22.
//

import Foundation
import UIKit

extension FPResetPasswordVC {
    
    
    func fieldValidation() -> Bool {
        
//        guard let otp = textfieldOtp.text?.trim(), !otp.isEmpty else {
//            DisplayBanners.show(message: NSLocalizedString("Please enter otp.", comment: ""))
//           return false
//        }
        
        guard let password = textfieldPassword.text?.trim(), !password.isEmpty else {
            DisplayBanners.show(message: NSLocalizedString("Please fill Password.", comment: ""))
            return false
        }
        
        if !password.isLengthValid(minLength: 6, maxLength: 50) {
            DisplayBanners.show(message: "Password should be 6 characters long..".localized() )
            return false
        }
        
//        if !password.isValidPassword() {
//            DisplayBanners.show(message: "Password must be consist of minimum 6 characters and should contain atleast 1Special character,1Numeric,1Uppercase or 1Lowercase.".localized() )
//            return false
//        }
        guard let confirmPassword = textfieldReEnterPassword.text?.trim(), !confirmPassword.isEmpty else {
            DisplayBanners.show(message: NSLocalizedString("Please fill re-enter Password.", comment: ""))
            return false
        }
        if textfieldPassword.text != textfieldReEnterPassword.text {
            DisplayBanners.show(message: NSLocalizedString("Password does not matched.", comment: ""))
            return false
        }
        return true
    }
    
//    func PasswordFieldValidation() -> Bool {
//
//        guard let password = textfieldPassword.text?.trim(), !password.isEmpty else {
//            //DisplayBanners.show(message: NSLocalizedString("Please enter password.", comment: ""))
//            labelIncorrectPassword.text = "Please enter password."
//            textfieldPassword.layer.borderWidth = 1
//            textfieldPassword.layer.borderColor = Color.appRed.cgColor
//            labelIncorrectPassword.isHidden = false
//            return false
//        }
//        labelIncorrectPassword.isHidden = true
//        textfieldPassword.layer.borderWidth = 0
//
//        if !password.isLengthValid(minLength: 6, maxLength: 50) {
//            //DisplayBanners.show(message: "The password needs to be at least 8 characters.".localized() )
//            labelIncorrectPassword.text = "Password should be 6 characters long."
//            textfieldPassword.layer.borderWidth = 1
//            textfieldPassword.layer.borderColor = Color.appRed.cgColor
//            labelIncorrectPassword.isHidden = false
//            return false
//        }
//
//        if !password.isValidPassword() {
//            labelIncorrectPassword.text = "Please enter valid password."
//            textfieldPassword.layer.borderWidth = 1
//            textfieldPassword.layer.borderColor = Color.appRed.cgColor
//            labelIncorrectPassword.isHidden = false
//            return false
//        }
//        return true
//    }
//
//    func ReEnterPasswordFieldValidation() -> Bool {
//        guard let confirmPassword = textfieldReEnterPassword.text?.trim(), !confirmPassword.isEmpty else {
//            //DisplayBanners.show(message: NSLocalizedString("Please enter re-enter password.", comment: ""))
//            labelIncorrectReEnterPassword.isHidden = false
//            labelIncorrectReEnterPassword.text = "Please enter re-enter password."
//            textfieldReEnterPassword.layer.borderWidth = 1
//            textfieldReEnterPassword.layer.borderColor = Color.appRed.cgColor
//            return false
//        }
//        labelIncorrectReEnterPassword.isHidden = true
//        textfieldReEnterPassword.layer.borderWidth = 0
//        if textfieldPassword.text != textfieldReEnterPassword.text {
//            labelIncorrectReEnterPassword.isHidden = false
//            labelIncorrectReEnterPassword.text = "Both Entered password mis-matched."
//            textfieldReEnterPassword.layer.borderWidth = 1
//            textfieldReEnterPassword.layer.borderColor = Color.appRed.cgColor
//            return false
//        }
//        return true
//    }
    
    @IBAction func buttonBackArrowTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonSubmitTapped(_ sender: Any) {
        
//        if fieldValidation() && ReEnterPasswordFieldValidation(){
//
//        }
        
        if fieldValidation() {
            
            let passwordData = textfieldPassword.text?.trim()
            //let otpData = textfieldOtp.text?.trim()
           
            let param = ["password_reset_token":passwordToken,"password":passwordData] as [String:Any]
            print(param)
            view.endEditing(true)
            resetPasswordFunc(params: param)
        }
    }
}
