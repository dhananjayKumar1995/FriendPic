//
//  FPEmailOtpVerify+Service.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 31/01/22.
//

import Foundation
import PromiseKit

extension FPEmailVerifyVC{
    
    //MARK:- OTP VERIFY API
    func otpVerifyFun(params: [String: Any]){
        Loader.show()
        firstly{
            service!.Otpverify(params: params)
        }.done { (model: UserDataModel) in
            self.handleResponse(model: model)
        }.catch { (error) in
            print(error)
            DisplayBanner1.show(title: error.localizedDescription)
        }.finally {
            Loader.hide()
        }
    }
   
    func handleResponse(model: UserDataModel) {
        
        if model.status != 200 {
                
            DisplayBanner1.show(title:model.message)
            return
            
        }
        
       
        self.dismiss(animated: true) { [self] in
            kAppDelegate.saveUserData(userData:model)
            self.delegate?.handleAction1(action: true, passwordToken: "")}
        Console.log(model)
    
    }
    
    
    //*****************************
    //MARK:- FORGOT PASSWORD API
    
    func forgotOtpVerifyFun(params: [String: Any]){
        Loader.show()
        firstly{
            service!.forgotOtpVerify(params: params)
        }.done { (model: ForgotPassOtpVerifyModel) in
            self.handleResponse2(model: model)
        }.catch { (error) in
            print(error)
            DisplayBanner1.show(title: error.localizedDescription)
        }.finally {
            Loader.hide()
        }
    }
   
    func handleResponse2(model: ForgotPassOtpVerifyModel) {
        
        if model.status != 200 {
                
            DisplayBanner1.show(title:model.message)
            return
            
        }
        
       
        self.dismiss(animated: true) { [self] in
            self.delegate?.handleAction1(action: true, passwordToken: model.data?.passwordResetToken ?? "")
            
        }
        Console.log(model)
    
    }
    
    
    //*******************************************************
    //MARK:  RESEND OTP
    
    func resendOtp(params: [String: Any]){
        Loader.show()
        firstly{
            service!.ResendOtp(params: params)
        }.done { (model: ResendOtpModel) in
            self.handleResponse1(model: model)
        }.catch { (error) in
            print(error)
            DisplayBanner1.show(title: error.localizedDescription)
        }.finally {
            Loader.hide()
        }
    }
   
    func handleResponse1(model: ResendOtpModel) {
        
        if model.status != 202{
                
            DisplayBanner1.show(title:model.message)
            return
        }
        DisplayBanner2.show(title:model.message)
        Console.log(model)
       
    }
    
    
}

