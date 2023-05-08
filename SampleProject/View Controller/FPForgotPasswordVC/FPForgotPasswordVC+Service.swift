//
//  FPForgotPasswordVC+Service.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 01/02/22.
//

import Foundation
import PromiseKit

extension FPForgotPasswordVC {
    
    func forgotPassFunc(params: [String:Any]) {
        
        Loader.show()
        
        firstly {
            service!.ForgotPassword(params:params)
        }.done { (model: ForgotPasswordResponse) in
            self.handleResponse(model: model)
        }.catch {(error) in
            print(error)
            DisplayBanner1.show(title: error.localizedDescription)
        }.finally {
            Loader.hide()
        }
    }
    
    func handleResponse (model: ForgotPasswordResponse) {
        
        if model.status != 202 {
            
            DisplayBanner1.show(title:model.message)
            return
            
        }
        DisplayBanner2.show(title:model.message)
        FPForgotPasswordVC.showOtpPopup(parentVC: self)
//        let goToNextScreen = storyboard?.instantiateViewController(withIdentifier:  "FPResetPasswordVC")as! FPResetPasswordVC
//        goToNextScreen.email = textFieldEmail.text?.trim() ?? ""
//        goToNextScreen.otp = String(model.data?.otp ?? 0 )
//        self.navigationController?.pushViewController(goToNextScreen, animated: true)
        Console.log(model)
    }
}


