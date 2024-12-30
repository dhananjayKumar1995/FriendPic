//
//  FPLoginVC+Action.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 19/01/22.
//

import Foundation
import UIKit
import SwiftUI
import AuthenticationServices
extension FPLoginVC {
    
    func fieldValidation() -> Bool {
        
        if (textFieldEmail.text?.isEmpty == true) && (textFieldPassword.text?.isEmpty == true) {
            
            DisplayBanners.show(message: NSLocalizedString("Please fill Email and Password." , comment: ""))
            return false
        }
        guard let email = textFieldEmail.text?.trim(), !email.isEmpty else {
            DisplayBanners.show(message: NSLocalizedString("Please fill Email." , comment: ""))
            
//            labelEmailIsIncorrect.isHidden = false
//            labelEmailIsIncorrect.text = "Please enter email."
//            textFieldEmail.layer.borderWidth = 1
//            textFieldEmail.layer.borderColor = Color.appRed.cgColor
            return false
        }
       // labelEmailIsIncorrect.isHidden = true
       // textFieldEmail.layer.borderWidth = 0
        if  !email.isValidEmail() {
             DisplayBanners.show(message: NSLocalizedString("Email is Incorrect.", comment: ""))
//            labelEmailIsIncorrect.isHidden = false
//            labelEmailIsIncorrect.text = "Please enter valid email."
//            textFieldEmail.layer.borderWidth = 1
//            textFieldEmail.layer.borderColor = Color.appRed.cgColor
            
            return false
        }
        
        guard let password = textFieldPassword.text?.trim(), !password.isEmpty else {
            DisplayBanners.show(message: NSLocalizedString("Please fill Password.", comment: ""))
            return false
        }
        
        if !password.isLengthValid(minLength: 6, maxLength: 50) {
            DisplayBanners.show(message: "Password should be 6 characters long..".localized() )
            return false
        }
        if !password.isValidPassword() {
            DisplayBanners.show(message: "Password is Incorrect.".localized() )
            return false
        }
        return true
    }
    
//    func PasswordFieldValidation() -> Bool {
//
//        guard let password = textFieldPassword.text?.trim(), !password.isEmpty else {
//            //DisplayBanners.show(message: NSLocalizedString("Please enter password.", comment: ""))
//            labelPasswordIncorrect.text = "Please enter password."
//            textFieldPassword.layer.borderWidth = 1
//            textFieldPassword.layer.borderColor = Color.appRed.cgColor
//            labelPasswordIncorrect.isHidden = false
//            return false
//        }
//        labelPasswordIncorrect.isHidden = true
//        textFieldPassword.layer.borderWidth = 0
//
//        if !password.isLengthValid(minLength: 6, maxLength: 50) {
//            //DisplayBanners.show(message: "The password needs to be at least 8 characters.".localized() )
//            labelPasswordIncorrect.text = "Password should be 6 characters long."
//            textFieldPassword.layer.borderWidth = 1
//            textFieldPassword.layer.borderColor = Color.appRed.cgColor
//            labelPasswordIncorrect.isHidden = false
//            return false
//        }
//        if !password.isValidPassword() {
//            labelPasswordIncorrect.text = "Please enter valid password."
//            textFieldPassword.layer.borderWidth = 1
//            textFieldPassword.layer.borderColor = Color.appRed.cgColor
//            labelPasswordIncorrect.isHidden = false
//            return false
//        }
//
//        return true
//    }
    
    @IBAction func buttonLoginTapped(_ sender: Any) {
        
//        if  fieldValidation() && PasswordFieldValidation(){
//
//        }
        if  fieldValidation(){
            let emailData = textFieldEmail.text?.trim() ?? ""
            let passwordData = textFieldPassword.text?.trim() ?? ""
            let param = ["email":emailData, "password":passwordData] as [String : Any]
            print(param)
            view.endEditing(true)
            loginFun(params: param)
        }
    }
    @IBAction func buttonForgotPassTapped(_ sender: Any) {
        let goToNextScreen = storyboard?.instantiateViewController(withIdentifier:  "FPForgotPasswordVC")as! FPForgotPasswordVC
        self.navigationController?.pushViewController(goToNextScreen, animated: true)
    }
    @IBAction func buttonSignUpTapped(_ sender: Any) {
        let goToNextScreen = storyboard?.instantiateViewController(withIdentifier:  "FPSignUpVC")as! FPSignUpVC
        self.navigationController?.pushViewController(goToNextScreen, animated: true)
    }
  
    @IBAction func buttonFacebookTapped(_ sender: Any) {
        
        facebookLoginAction()
        
    }

    
    @IBAction func buttonAppleIdTapped(_ sender: Any) {
        
        //MARK:- Apple sign in method
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email,]
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.performRequests()
        } else {
            // Fallback on earlier versions
        }


    }
    
    @IBAction func buttonRememberMeTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
     
        guard let emailText = textFieldEmail.text?.trim(),!emailText.isEmpty else {
            return
        }

        guard let passwordText = textFieldPassword.text?.trim(),!passwordText.isEmpty else {
            return
        }
    }
}
