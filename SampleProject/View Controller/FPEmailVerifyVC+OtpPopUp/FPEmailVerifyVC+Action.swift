//
//  FPEmailVerifyVC+Action.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 27/01/22.
//

import Foundation
import UIKit

extension FPEmailVerifyVC {
    
    
    func fieldValidation() -> Bool {
        
        if enterOtp.count == 0 {
            DisplayBanners.show(message: NSLocalizedString("Please enter otp.", comment: ""))
           return false
        }
        else if enterOtp.count == 4 {
          return true
            
        }
        else {
            DisplayBanners.show(message: NSLocalizedString("invalid otp.", comment: ""))
           return false
        }
       
    }
    
    
    @IBAction func buttonCrossTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func buttonConfirmTapped(_ sender: Any) {
        
        if fieldValidation() {
            let param = ["email":email,"otp":enterOtp] as [String : Any]
        print(param)
        view.endEditing(true)
            if fromForgotPassword == true {
                forgotOtpVerifyFun(params: param)
            }
            else {
        otpVerifyFun(params: param)
            }
    }
//        self.dismiss(animated: true) { [self] in
//        self.delegate?.handleAction(action: true)}
    }
        
    @IBAction func buttonResendTapped(_ sender: Any) {
        countDown = 30
        buttonResend.titleLabel?.attributedText = .none
        buttonResend.setTitle("00:\(countDown)", for: .normal)
        labelDidNotReceiveCode.text = "Resend OTP in "
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        
            let param = ["email":email] as [String : Any]
            print(param)
            view.endEditing(true)
            resendOtp(params: param)
    }
}
