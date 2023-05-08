//
//  FPSettingVC+Service.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 17/02/22.
//

import Foundation
import PromiseKit

extension FPSettingVC {
    
    func logOut(){
        Loader.show()
        firstly{
            service!.Logout(params: [:])
        }.done { (model: UserDataModel) in
            self.handleResponse2(model: model)
        }.catch { (error) in
            print(error)
            DisplayBanner1.show(title: error.localizedDescription)
        }.finally {
            Loader.hide()
        }
    }
   
    func handleResponse2(model: UserDataModel) {
        
        if model.status != 200{
                
            DisplayBanner1.show(title:model.message)
            return
        }
       // kAppDelegate.saveUserData(userData:model)
    
        kAppDelegate.deleteData()
        kAppDelegate.isDeviceTokenUpdate = false
        kAppDelegate.isLoadingUpdateTokenApi = false
        kAppDelegate.checkToLoadScreen()
        Console.log(model)
       
    }
    
    func deleteAccountApi() {
        
        Loader.show()
        
        firstly {
            service!.deleteAccount(param: [:])
        }.done { (model: CommonResponse) in
            self.handleResponse(model: model)
        }.catch {(error) in
            print(error)
            DisplayBanner1.show(title: error.localizedDescription)
        }.finally {
            Loader.hide()
        }
    }
    
    func handleResponse (model: CommonResponse) {
        
        if model.status != 200{
            
            DisplayBanner1.show(title:model.message)
            return
            
        }
        DisplayBanner2.show(title:model.message)
        let goToNextScreen = storyboard?.instantiateViewController(withIdentifier:  "FPLoginVC")as! FPLoginVC
        self.navigationController?.pushViewController(goToNextScreen, animated: true)
        Console.log(model)
        
    }
}
