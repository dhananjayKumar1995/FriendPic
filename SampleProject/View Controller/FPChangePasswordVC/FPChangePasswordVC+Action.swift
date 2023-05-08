//
//  FPChangePasswordVC+Action.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 16/02/22.
//

import Foundation
import UIKit

extension FPChangePasswordVC {
    
    func fieldValidation() -> Bool {
        
        guard let currentPassword = textFieldCurrentPassword.text?.trim(), !currentPassword.isEmpty else {
            DisplayBanners.show(message: NSLocalizedString("Please fill Current Password.", comment: ""))
            return false
        }
        
                if !currentPassword.isValidPassword() {
                    DisplayBanners.show(message: "Password must be consist of minimum 6 characters and should contain atleast 1Special character,1Numeric,1Uppercase or 1Lowercase.".localized() )
                    return false
                }
        guard let NewPassword = textfieldNewPassword.text?.trim(), !NewPassword.isEmpty else {
            DisplayBanners.show(message: NSLocalizedString("Please fill New Password.", comment: ""))
            return false
        }
        
        if !NewPassword.isValidPassword() {
            DisplayBanners.show(message: "Password must be consist of minimum 6 characters and should contain atleast 1Special character,1Numeric,1Uppercase or 1Lowercase.".localized() )
            return false
        }
        
        guard let ConfirmNewPassword = textfieldConfirmNewPassword.text?.trim(), !ConfirmNewPassword.isEmpty else {
            DisplayBanners.show(message: NSLocalizedString("Please fill Confirm-New Password.", comment: ""))
            return false
        }
        
        if textfieldNewPassword.text != textfieldConfirmNewPassword.text {
            DisplayBanners.show(message: NSLocalizedString("Password does not matched.", comment: ""))
            return false
        }
        return true
    }
    
    @IBAction func buttonSubmitTapped(_ sender: Any) {
        
        if fieldValidation() {
            
            let oldPassword = textFieldCurrentPassword.text?.trim()
            let newPassword = textfieldNewPassword.text?.trim()
            
            let param = ["old_password":oldPassword, "new_password":newPassword]
            print("Request,\(param)")
            view.endEditing(true)
            changePassword(params: param)
        }
    }
    
    @IBAction func buttonBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
