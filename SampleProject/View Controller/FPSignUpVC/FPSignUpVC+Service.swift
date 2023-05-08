//
//  FPSignUpVC+Service.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 31/01/22.
//

import Foundation
import PromiseKit
extension FPSignUpVC{
    
    func signupFun(params: [String: Any]){
        Loader.show()
        firstly{
            service!.Signup(params: params)
        }.done { (model: RegisterDataModel) in
            self.handleResponse(model: model)
        }.catch { (error) in
            print(error)
            DisplayBanner1.show(title: error.localizedDescription)
        }.finally {
            Loader.hide()
        }
    }
   
    func handleResponse(model: RegisterDataModel) {
        
        if model.status != 202{
                
            DisplayBanner1.show(title:model.message)
            return
        }
        
        else if model.status == 202{
            let isVerified = model.data?.is_verified ?? ""//model.data?.user?.isVerified ?? ""
        if isVerified == "1" {
    
            DisplayBanner2.show(title:model.message)
            
        }
        else{
            FPSignUpVC.showOtpPopup(parentVC: self)
        }
        DisplayBanner2.show(title:model.message)
        Console.log(model)
       
        }
    }
    
}
