//
//  FPLoginVC+UITextFieldDeledate.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 24/01/22.
//

import Foundation
import UIKit

extension FPLoginVC:UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if !EmailFieldValidation() //if textField == textFieldEmail || textField == textFieldPassword
//        {
//
//        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        if EmailFieldValidation() {//textField == textFieldPassword || textField == textFieldPassword {
//            labelEmailIsIncorrect.isHidden = true
//            textFieldEmail.layer.borderWidth = 0
//            labelPasswordIncorrect.isHidden = true
//            textFieldPassword.layer.borderWidth = 0
//}

    }
    
    
    @objc func textFieldEmailEditingChange() {
//
//        if !fieldValidation(){
//
//        }
//
    }
    
    @objc func textFieldPasswordEditingChange() {
//
//        if !PasswordFieldValidation() {
//
//        }
//
        
    }
}
