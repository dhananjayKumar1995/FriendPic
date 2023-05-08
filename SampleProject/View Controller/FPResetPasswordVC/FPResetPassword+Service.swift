//
//  FPResetPassword+Service.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 01/02/22.
//

import Foundation
import PromiseKit

extension FPResetPasswordVC {
    
    func resetPasswordFunc(params: [String:Any]) {
        
        Loader.show()
        
        firstly {
            service!.ResetPassword(params:params)
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


