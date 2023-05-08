//
//  FPChangePassword+Service.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 21/02/22.
//

import Foundation
import UIKit
import PromiseKit

extension FPChangePasswordVC {
    
    func changePassword(params: [String:Any]) {
        
        Loader.show()
        
        firstly {
            service!.changePassword(params:params)
        }.done { (model: ChangePasswordModel) in
            self.handleResponse(model: model)
        }.catch {(error) in
            print(error)
            DisplayBanner1.show(title: error.localizedDescription)
        }.finally {
            Loader.hide()
        }
    }
    
    func handleResponse (model: ChangePasswordModel) {
        
        if model.status != 200{
            
            DisplayBanner1.show(title:model.message)
            return
            
        }
        DisplayBanner2.show(title:model.message)
        self.navigationController?.popViewController(animated: true)
//        let goToNextScreen = storyboard?.instantiateViewController(withIdentifier:  "FPLoginVC")as! FPLoginVC
//        self.navigationController?.pushViewController(goToNextScreen, animated: true)
        Console.log(model)
        
    }
    
}
