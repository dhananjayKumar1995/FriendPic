//
//  PGLoginVC+Action.swift
//  SampleProject
//
//  Created by RAVI K GUPTA on 04/01/22.
//

import Foundation
import UIKit

extension PGLoginVC {

    func fieldValidation() -> Bool {
    
        guard let email = textFieldEmail.text?.trim(), !email.isEmpty else {
            DisplayBanners.show(message: NSLocalizedString("Please enter email." , comment: ""))
            return false
        }
        
        if  !email.isValidEmail() {
            DisplayBanners.show(message: NSLocalizedString("Please enter valid email.", comment: ""))
            return false
        }
        guard let password = textFieldPassword.text?.trim(), !password.isEmpty else {
            DisplayBanners.show(message: NSLocalizedString("Please enter password.", comment: ""))
            return false
        }
        if !password.isLengthValid(minLength: 8, maxLength: 50) {
            DisplayBanners.show(message: "The password needs to be at least 8 characters.".localized() )
            return false
        }
        
//        if !password.isValidPassword() {
//            DisplayBanners.show(message: "Password must be at least 8 characters long must contain a number, an uppercase letter and one special character.".localized())
//            return false
//        }

        let param = ["email":email,"password":password] as [String : Any]
        print(param)
        view.endEditing(true)
        login(params: param)

        return true
    }
    
    @IBAction func buttonLoginTapped(_ sender: UIButton) {
        
        if  fieldValidation() {
            
        }
    }
}
