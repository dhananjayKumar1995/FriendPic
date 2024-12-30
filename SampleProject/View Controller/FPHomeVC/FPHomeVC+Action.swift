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
    
    @IBAction func buttonRefreshPageTapped(_ sender: Any) {
        getImage()
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
            /*
            if let  url = getImageData?.data?.shareable?.first?.linke{//imageURL
                
                shareOnWhatsApp(url: url)
            }
            */
            
            DisplayBanner1.show(title: "Image has already shared!!")
        }
    }
    
    func shareOnWhatsApp(url:String) {
            // Replace "https://yourwebsite.com" with the URL you want to share

        let url = URL(string: url)
        if let appUrl = url,!appUrl.absoluteString.isEmpty{
            let objectsToShare = [appUrl]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
            
        } else {
            // show alert for not available
           // DisplayBanner.show(title: "App Url is not available")
        }
    


  /*
        DispatchQueue.main.async {

            if let url = URL(string: url) {
                let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)

                // Exclude activities that are not available on the current device
                activityViewController.excludedActivityTypes = [
                    .postToFacebook,
                    .postToTwitter,
                    .postToWeibo,
                    .message,
                    .mail,
                    .print,
                    .copyToPasteboard,
                    .assignToContact,
                    .saveToCameraRoll,
                    .addToReadingList,
                    .postToFlickr,
                    .postToVimeo,
                    .postToTencentWeibo,
                    .openInIBooks,
                    .markupAsPDF,
                ]

                // Present the activity view controller
                self.present(activityViewController, animated: true, completion: nil)
            }

        }
        */
    }

    
    @IBAction func buttonCrossTapped(_ sender: UIButton) {
        FPHomeVC.showRemovePicturePopup(parentVC: self)
    }
}


