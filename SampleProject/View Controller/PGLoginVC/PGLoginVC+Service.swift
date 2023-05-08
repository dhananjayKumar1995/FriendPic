//
//  PGLoginVC+Service.swift
//  SampleProject
//
//  Created by RAVI K GUPTA on 04/01/22.
//


import PromiseKit

extension PGLoginVC{
    
    func login(params: [String: Any]){
        Loader.show()
        firstly{
            service!.Login(params: params)
        }.done { (model: CommonResponse) in
            self.handleResponse(model: model)
        }.catch { (error) in
            print(error)
            DisplayBanner1.show(title: error.localizedDescription)
        }.finally {
            Loader.hide()
        }
    }
   
    func handleResponse(model: CommonResponse) {
        
        if model.status == 200  || model.status == 201 {
                
            DisplayBanner1.show(title:model.message)
            
        } else {
            
            DisplayBanner1.show(title: model.message)
        }
        Console.log(model)
    
    }
    
}


// Login Model



//struct CommonResponse: Decodable {
//    let status: Int
//    let message: String
//}



