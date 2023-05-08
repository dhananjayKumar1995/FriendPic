//
//  FPLoginVC+Service.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 31/01/22.
//

import Foundation
import PromiseKit

extension FPLoginVC{
    
    func loginFun(params: [String: Any]){
        Loader.show()
        firstly{
            service!.Login(params: params)
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
        
        if model.status != 200 && model.status != 202{
            
            DisplayBanner1.show(title:model.message)
            return
        }
        
        else if model.status == 202 || model.status == 200{
            
            let isVerified = model.data?.user?.isVerified ?? ""
            if isVerified == "" {
                DisplayBanner2.show(title:model.message)
                FPLoginVC.showOtpPopup(parentVC: self)
            }
            else {
                kAppDelegate.saveUserData(userData:model)
                kAppDelegate.checkToLoadScreen()
            }
            DisplayBanner2.show(title:model.message)
            Console.log(model)
        }
        
    }
    
  
    
    //*************************************************************
    // Social login service
    func SocialLoginFun(params: [String: Any]){
        Loader.show()
        firstly{
            service!.SocialLogin(params: params)
        }.done { (model: UserDataModel) in
            self.handleResponse1(model: model)
        }.catch { (error) in
            print(error)
            DisplayBanner1.show(title: error.localizedDescription)
        }.finally {
            Loader.hide()
        }
    }
    
    func handleResponse1(model: UserDataModel) {
        
        if model.status != 200{
            
            DisplayBanner1.show(title:model.message)
            return
        }
        
        DisplayBanner2.show(title:model.message)
        kAppDelegate.saveUserData(userData:model)
        kAppDelegate.checkToLoadScreen()
//        let goToNextScreen = storyboard?.instantiateViewController(withIdentifier:  "FPTabBarVC")as! FPTabBarVC
//        self.navigationController?.pushViewController(goToNextScreen, animated: true)
       // Console.log(model)
    }
    
    
}





