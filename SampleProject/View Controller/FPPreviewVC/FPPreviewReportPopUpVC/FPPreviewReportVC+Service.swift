//
//  FPPreviewReportVC+Service.swift
//  SampleProject
//
//  Created by MC-MM0012 on 06/06/22.
//

import Foundation
import PromiseKit

extension FPPreviewReportVC{
    
    func postReport(params: [String:Any]) {
        
        Loader.show()
        
        firstly {
            service!.postReport(param: params)
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
        self.dismiss(animated: true) {
            self.delegate?.isRepored(isReported: 1)
        }
        Console.log(model)
        
    }
}
