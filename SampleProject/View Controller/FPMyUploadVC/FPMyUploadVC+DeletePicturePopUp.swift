//
//  FPMyUploadVC+DeletePicture.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 21/02/22.
//

import Foundation
import UIKit

extension FPMyUploadVC {
    
    //mark:- SHOW POP UP STATIC METHOD
    static func showDeletePicturePopup(parentVC: UIViewController,index:Int){
        //creating a reference for the dialogView controller
        if let popupVC = UIStoryboard(name: "Registration", bundle: nil).instantiateViewController(withIdentifier: "FPCommonPopUpVC") as? FPCommonPopUpVC {
            // popupVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            popupVC.modalPresentationStyle = .custom
            popupVC.modalTransitionStyle = .crossDissolve
            popupVC.fromMyUploadScreen = true
            popupVC.selectedIndex = index
            //presenting the pop up viewController from the parent viewController
            parentVC.present(popupVC, animated: true)

            //setting the delegate of the dialog box to the parent viewController
            popupVC.delegate = parentVC as? CommonPopUpDelegate
            //presenting the pop up viewController from the parent viewController

        }
    }
}

extension FPMyUploadVC :CommonPopUpDelegate {

    func handleAction1(action: Bool,index: Int) {
        let postId = getImageData1?.data?.posts?.data[index].id ?? 0
       
        deletePostFromUpload(postId: postId, index: index)
    }
}
