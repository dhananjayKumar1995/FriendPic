//
//  FPVerificationSucessfulVC+Action.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 25/01/22.
//

import Foundation
import UIKit

extension FPVerificationSuccessfulVC {
    
    
    @IBAction func buttonOkTapped(_ sender: Any) {

        self.dismiss(animated: true) { [self] in
        self.delegate?.handleAction2(action: true)}

        // after enable handle action it will go on home screen screen
    }
    
    @IBAction func buttonCancleTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
