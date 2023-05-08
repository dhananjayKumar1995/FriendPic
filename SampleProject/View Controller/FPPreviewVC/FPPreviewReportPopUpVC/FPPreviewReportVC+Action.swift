//
//  FPPreviewReportVC+Action.swift
//  SampleProject
//
//  Created by MC-MM0012 on 06/06/22.
//

import Foundation
import UIKit

extension FPPreviewReportVC{
    
    @IBAction func buttonSubmitTapped(_ sender: UIButton) {

        print("api call")
        let param = ["report_reason":reportTextView.text,"post_id":postId] as [String:Any]
        postReport(params: param)
    }
    
    @IBAction func buttonCencelTapped(_ sender: Any) {
        self.dismiss(animated: true) {
        }
    }
}
