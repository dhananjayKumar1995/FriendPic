//
//  FPDeleteAccountVC  + Action.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 22/07/22.
//

import Foundation
import UIKit

extension FPDeleteAccountVC{
    
    func fieldValidation() -> Bool {
        
        guard let currentPassword = textFieldPassword.text?.trim(), !currentPassword.isEmpty else {
            DisplayBanners.show(message: NSLocalizedString("Please fill Password.", comment: ""))
            return false
        }
        
        if !currentPassword.isValidPassword() {
            DisplayBanners.show(message: "Password must be consist of minimum 6 characters and should contain atleast 1Special character,1Numeric,1Uppercase or 1Lowercase.".localized() )
            return false
        }
        
        return true
    }
    
    @IBAction func buttobDeleteTapped(_ sender: Any) {

        if fieldValidation() {
            
//            let goToNextScreen = storyboard?.instantiateViewController(withIdentifier:  "FPLoginVC")as! FPLoginVC
//            self.navigationController?.pushViewController(goToNextScreen, animated: true)
            FPDeleteAccountVC.showOkPopup(parentVC: self)
            print("show popup")
        }
    }
    
    @IBAction func buttonBackTapped(_ sender: Any) {
        self.popViewController()
    }
}
