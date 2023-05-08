//
//  FPMyUploadVC+Action.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 16/02/22.
//

import Foundation
import UIKit
import Kingfisher


extension FPMyUploadVC {
    
    //THIS ACTION BUTTON IS OF FPMyUploadVCTableViewCell BUT I AM USING FROM CELLFORROW AT NDEXPATH IN TABLE VIEW CELL AS A ADDTARGET
    @IBAction func buttonDeleteTapped(_ sender: UIButton) {
        
        /* written below code for general knowledge
         
         let indexPath = IndexPath(row: 0, section: 0)
         let cell = myTableView.cellForRow(at: indexPath)
         */
        
        if let indexPath = myTableView.indexPathForView(sender) {
            FPMyUploadVC.showDeletePicturePopup(parentVC: self,index:indexPath.row)
        }
    }
    
    @IBAction func buttonUploadToInstaTapped(_ sender: UIButton) {
        currentState = .uploadToInsta
        if let indexPath = myTableView.indexPathForView(sender) {
            let token = kUserDefaults.string(forKey: AppKeys.token) ?? ""
            let modifier = AnyModifier { request in
                var r = request
                // replace "Access-Token" with the field name you need, it's just an example
                r.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                
                return r
            }
            if let cell = myTableView.cellForRow(at: indexPath) as? FPMyUploadVCTableViewCell {
                let url = getImageData1?.data?.posts?.data[indexPath.row].images[cell.pageControl.currentPage].path ?? ""
                let indexPat = IndexPath(item: cell.pageControl.currentPage, section: 0)
                if let cell = cell.myCollectionView.cellForItem(at: indexPat) as? FPHomeVCCollectionViewCell {
                    cell.images.kf.setImage(with: URL(string: url),placeholder: UIImage(named: "placeholder"), options: [.requestModifier(modifier)]) { (image, error, type, url) in
                        if error == nil && image != nil {
                            DispatchQueue.main.async {
                                if let imag = image {
                                    self.saveimageType = .instagramUpload
//                                    if self.uploadInstatype == 0 {
//                                        self.shareImageUsingActivity(image: imag)
//                                        self.uploadInstatype = self.uploadInstatype + 1
//                                    }
//                                    else {
//                                        self.saveImageIntoPhotoLibrary(image: imag, type: self.saveimageType)
//                                        self.indexPath = indexPath
//                                    }
//                                    guard let instagramUrl = URL(string: "instagram://app") else {return}
//                                    if UIApplication.shared.canOpenURL(instagramUrl) {
//                                        UIApplication.shared.open(instagramUrl)
//                                        //let instaUrlStr = instagramUrl.path
//                                    }
//                                    else {
//                                        DisplayBanner1.show(title: "Instagram app is not installed in your phone. please install the app first.")
//                                        return
//                                    }
                                    
                                    
                                    self.saveImageIntoPhotoLibrary(image: imag, type: self.saveimageType)
                                    self.indexPath = indexPath
                                }
                            }
                        }
                        else {
                            //cell.images.image  =  UIImage(named: "placeholder")
                            // handle the failure
                            print(error)
                        }
                    }
                }
            }
        }
    }
    
//    func postToInstagram(image:UIImage,index:Int) {
//        if uploadInstatype == 1 {
//            guard let instagramUrl = URL(string: "instagram://app") else {return}
//            if UIApplication.shared.canOpenURL(instagramUrl) {
//                UIApplication.shared.open(instagramUrl)
//                //let instaUrlStr = instagramUrl.path
//            }
//            uploadInstatype = uploadInstatype + 1
//
//        }
//        else {
//            guard let instagramUrl = URL(string: "instagram://app") else {return}
//            if UIApplication.shared.canOpenURL(instagramUrl) {
//                UIApplication.shared.open(instagramUrl)
//                InstagramManager.sharedManager.postImageToInstagram(imageInstagram: image, index: index, currentIndex: index, view: self.view)
//                //let instaUrlStr = instagramUrl.path
//            }
//            uploadInstatype = 0
//        }
//
//    }
    
    func shareImageUsingActivity(image:UIImage) {
        // set up activity view controller
        let imageToShare = [ image]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func buttonDownloadTapped(_ sender: UIButton) {
        currentState = .download

        if let indexPath = myTableView.indexPathForView(sender) {
            if let cell = myTableView.cellForRow(at: indexPath) as? FPMyUploadVCTableViewCell {
                
                let currentindex = cell.pageControl.currentPage
                downloadImage(index: indexPath.row,currentIndex:currentindex)
            }
        }
        
    }
}


//**************************************************************************************

extension FPMyUploadVCTableViewCell {
    
    @IBAction func buttonDislikeTapped(_ sender: Any) {
    }
    
    @IBAction func buttonLikeTapped(_ sender: Any) {
    }
    
    
}

