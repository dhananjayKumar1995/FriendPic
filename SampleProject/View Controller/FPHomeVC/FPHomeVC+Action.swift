//
//  FPHomeVC+Action.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 03/02/22.
//

import Foundation
import UIKit
import Photos
import AVFoundation
import AVKit
extension FPHomeVC {
    @IBAction func buttonNotificationTapped(_ sender: Any) {
        let goToNextScreen = storyboard?.instantiateViewController(withIdentifier: "FPNotificationVC") as! FPNotificationVC
        goToNextScreen.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(goToNextScreen, animated: true)
    }
    
    @IBAction func buttonLikeTapped(_ sender: Any) {
    }
    @IBAction func buttonDislikeTapped(_ sender: Any) {
    }
    @IBAction func buttonShareTapped(_ sender: UIButton) {
        
        if getImageData?.data?.sharedAt == nil{
            
            guard let goToNextScreen = storyboard?.instantiateViewController(withIdentifier:  "FPContactVC") as? FPContactVC else {return}
            goToNextScreen.hidesBottomBarWhenPushed = true
            goToNextScreen.delegate = self
            self.navigationController?.pushViewController(goToNextScreen, animated: true)
        }
        else{
            DisplayBanner1.show(title: "Image has already shared!!")
        }
    }

    
    @IBAction func buttonCrossTapped(_ sender: UIButton) {
        FPHomeVC.showRemovePicturePopup(parentVC: self)
        
        
    }
}


