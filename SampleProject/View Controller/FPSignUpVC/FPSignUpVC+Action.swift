//
//  FPSignUpVC+Action.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 19/01/22.
//

import Foundation
import UIKit
import SwiftUI

extension FPSignUpVC {
    
    func fieldValidation() -> Bool {
        
        if (textFieldName.text?.isEmpty == true && textFieldEmail.text?.isEmpty == true && textFieldPassword.text?.isEmpty == true && textFieldReEnterPassword.text?.isEmpty == true ) {
            
            DisplayBanners.show(message: NSLocalizedString("Please fill all mandatory fields." , comment: ""))
            return false

        }
        guard let name = textFieldName.text?.trim(), !name.isEmpty else {
            DisplayBanners.show(message: NSLocalizedString("Please fill name." , comment: ""))
            return false
        }
        if !name.isNameValid() {
            DisplayBanners.show(message: NSLocalizedString("Name must consist of minimum 3 characters and maximum 50 characters.", comment: ""))
            return false
            
        }
        
        guard let email = textFieldEmail.text?.trim(), !email.isEmpty else {
            DisplayBanners.show(message: NSLocalizedString("Please fill Email." , comment: ""))
            
            return false
        }
        
        if  !email.isValidEmail() {
            DisplayBanners.show(message: NSLocalizedString("Email is incorrect. please try one with text and numbers only.", comment: ""))
            
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
        
//        if !password.isValidPassword() {
//            DisplayBanners.show(message: "Password must be consist of minimum 6 characters and should contain atleast 1Special character,1Numeric,1Uppercase or 1Lowercase.".localized() )
//
//            return false
//        }
        
        guard let confirmPassword = textFieldReEnterPassword.text?.trim(), !confirmPassword.isEmpty else {
            DisplayBanners.show(message: NSLocalizedString("Please fill re-enter Password.", comment: ""))
            
            return false
        }
        
        if textFieldPassword.text != textFieldReEnterPassword.text {
            
            DisplayBanners.show(message: NSLocalizedString("Password does not matched.", comment: ""))
            return false
        }

        return true
    }
    
    func checkTextSufficientComplexity(var text : String) -> Bool{


        let capitalLetterRegEx  = ".*[A-Z]+.*"
        var texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        var capitalresult = texttest.evaluate(with: text)
        print("\(capitalresult)")
        
        let smallLetterRegEx  = ".*[a-z]+.*"
        var texttest1 = NSPredicate(format:"SELF MATCHES %@", smallLetterRegEx)
        var smallresult = texttest1.evaluate(with: text)
        print("\(smallresult)")



        let numberRegEx  = ".*[0-9]+.*"
        var texttest2 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        var numberresult = texttest2.evaluate(with: text)
        print("\(numberresult)")


        let specialCharacterRegEx  = ".*[!&^%$#@()/]+.*"
        var texttest3 = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)

        var specialresult = texttest3.evaluate(with: text)
        print("\(specialresult)")

        return capitalresult || numberresult || specialresult || smallresult

    }
    
    //    func NameFieldValidation() -> Bool {
    //
    //        guard let name = textFieldName.text?.trim(), !name.isEmpty else {
    //            //DisplayBanners.show(message: NSLocalizedString("Please enter name." , comment: ""))
    //            labelIncorrectName.isHidden = false
    //            labelIncorrectName.text = "Please enter name."
    //            textFieldName.layer.borderWidth = 1
    //            textFieldName.layer.borderColor = Color.appRed.cgColor
    //            return false
    //        }
    //        labelIncorrectName.isHidden = true
    //        textFieldName.layer.borderWidth = 0
    //        if !name.isNameValid() {
    //            //DisplayBanners.show(message: NSLocalizedString("Minimum length should be 3 and Maximum 18.", comment: ""))
    //            labelIncorrectName.isHidden = false
    //            labelIncorrectName.text = "Minimum length should be 3 and Maximum 18."
    //            textFieldName.layer.borderWidth = 1
    //            textFieldName.layer.borderColor = Color.appRed.cgColor
    //            return false
    //
    //        }
    //        return true
    //    }
    //
    
    //************
    
    //    func EmailFieldValidation() -> Bool {
    //        guard let email = textFieldEmail.text?.trim(), !email.isEmpty else {
    //            //DisplayBanners.show(message: NSLocalizedString("Please enter email." , comment: ""))
    //            labelIncorrectEmail.isHidden = false
    //            labelIncorrectEmail.text = "Please enter email."
    //            textFieldEmail.layer.borderWidth = 1
    //            textFieldEmail.layer.borderColor = Color.appRed.cgColor
    //            return false
    //        }
    //        labelIncorrectEmail.isHidden = true
    //        textFieldEmail.layer.borderWidth = 0
    //        if  !email.isValidEmail() {
    //           // DisplayBanners.show(message: NSLocalizedString("Please enter valid email.", comment: ""))
    //            labelIncorrectEmail.isHidden = false
    //            labelIncorrectEmail.text = "Please enter valid email."
    //            textFieldEmail.layer.borderWidth = 1
    //            textFieldEmail.layer.borderColor = Color.appRed.cgColor
    //            return false
    //        }
    //        return true
    //    }
    
    //************
    
    //    func PasswordFieldValidation() -> Bool {
    //        guard let password = textFieldPassword.text?.trim(), !password.isEmpty else {
    //            //DisplayBanners.show(message: NSLocalizedString("Please enter password.", comment: ""))
    //            labelIncorrectPassword.isHidden = false
    //            labelIncorrectPassword.text = "Please enter password."
    //            textFieldPassword.layer.borderWidth = 1
    //            textFieldPassword.layer.borderColor = Color.appRed.cgColor
    //            return false
    //        }
    //        labelIncorrectPassword.isHidden = true
    //        textFieldPassword.layer.borderWidth = 0
    //        if !password.isLengthValid(minLength: 6, maxLength: 50) {
    //            //DisplayBanners.show(message: "The password needs to be at least 8 characters.".localized() )
    //            labelIncorrectPassword.isHidden = false
    //            labelIncorrectPassword.text = "Password should be 6 characters long."
    //            textFieldPassword.layer.borderWidth = 1
    //            textFieldPassword.layer.borderColor = Color.appRed.cgColor
    //            return false
    //
    //        }
    //
    //        if !password.isValidPassword() {
    //            labelIncorrectPassword.text = "Please enter valid password."
    //            textFieldPassword.layer.borderWidth = 1
    //            textFieldPassword.layer.borderColor = Color.appRed.cgColor
    //            labelIncorrectPassword.isHidden = false
    //            return false
    //        }
    //
    //        return true
    //    }
    
    //************
    
    //    func ReEnterPasswordFieldValidation() -> Bool {
    //        guard let confirmPassword = textFieldReEnterPassword.text?.trim(), !confirmPassword.isEmpty else {
    //            //DisplayBanners.show(message: NSLocalizedString("Please enter re-enter password.", comment: ""))
    //            labelIncorrectReEncorrectPassword.isHidden = false
    //            labelIncorrectReEncorrectPassword.text = "Please enter re-enter password."
    //            textFieldReEnterPassword.layer.borderWidth = 1
    //            textFieldReEnterPassword.layer.borderColor = Color.appRed.cgColor
    //            return false
    //        }
    //        labelIncorrectReEncorrectPassword.isHidden = true
    //        textFieldReEnterPassword.layer.borderWidth = 0
    //        if textFieldPassword.text != textFieldReEnterPassword.text {
    //            labelIncorrectReEncorrectPassword.isHidden = false
    //            labelIncorrectReEncorrectPassword.text = "Both Entered password mis-matched."
    //            textFieldReEnterPassword.layer.borderWidth = 1
    //            textFieldReEnterPassword.layer.borderColor = Color.appRed.cgColor
    //            return false
    //        }
    //        return true
    //
    //    }
    
    
    @IBAction func buttonCheckTapped(_ sender: Any) {
        isTapped.toggle()

       // buttonCheck.backgroundColor = isTapped == true ? Color.appBlack : Color.appGray
        if isTapped == true{
            buttonCheck.setImage(UIImage(named: "selected_checkbox"), for: .normal)
        }
        else{
            buttonCheck.setImage(UIImage(named: "unselected_checkbox"), for: .normal)

        }
    }
    @IBAction func buttonLoginTapped(_ sender: Any) {
        
        popViewController()
    }
    @IBAction func buttonBackArrowTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func buttonVerifyTapped(_ sender: Any) {
//        if NameFieldValidation() && EmailFieldValidation() && PasswordFieldValidation() && ReEnterPasswordFieldValidation(){
//
//            FPEmailVerifyVC.showPopup(parentVC: self)
//        }
        
        if fieldValidation(){
            let nameData = textFieldName.text?.trim()
            let emailData = textFieldEmail.text?.trim()
            let passwordData = textFieldPassword.text?.trim()
            let param = ["name": nameData, "email": emailData, "password": passwordData] as [String : Any]
            print(param)
            view.endEditing(true)
            if isTapped == true {
            signupFun(params: param)
            }
            else{
                DisplayBanner1.show(title:"Please accept Terms and Condition & Privacy Policy")
            }
//            FPSignUpVC.showOtpPopup(parentVC: self)
        }
    }
}
