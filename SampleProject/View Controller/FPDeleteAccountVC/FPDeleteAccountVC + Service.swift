//
//  FPDeleteAccountVC + Service.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 22/07/22.
//

import Foundation
import UIKit
import PromiseKit

extension FPDeleteAccountVC {
    
    func deleteAccountApi(params: [String:Any]) {
        
        Loader.show()
        
        firstly {
            service!.deleteAccount(param: params)
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
