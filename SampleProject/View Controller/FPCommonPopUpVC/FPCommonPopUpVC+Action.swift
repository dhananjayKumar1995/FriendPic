//
//  FPCommonPopUpVC+Action.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 21/02/22.
//

import Foundation
import UIKit

extension FPCommonPopUpVC {

@IBAction func buttonConfirmTapped(_ sender: UIButton) {
    
    
    self.dismiss(animated: true) { [self] in
    self.delegate?.handleAction1(action: true,index: selectedIndex)}
}
@IBAction func buttonCancelTapped(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
}

}
