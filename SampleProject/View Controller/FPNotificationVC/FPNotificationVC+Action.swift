//
//  FPNotificationVC+Action.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 22/02/22.
//

import Foundation
import UIKit

extension FPNotificationVC {
    
    @IBAction func buttonBackTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
