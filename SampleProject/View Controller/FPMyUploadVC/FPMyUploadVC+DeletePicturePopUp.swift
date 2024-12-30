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
        let popupVC = FPCommonPopUpVC.instantiate(fromAppStoryboard: .registration)
        popupVC.modalTransitionStyle = .crossDissolve
        popupVC.modalPresentationStyle = .custom
        popupVC.selectedIndex = index
        popupVC.delegate = parentVC as? CommonPopUpDelegate
        popupVC.popupType = .fromMyUploadScreen
        parentVC.present(popupVC, animated: true, completion: nil)
    }
}

extension FPMyUploadVC :CommonPopUpDelegate {

    func handleAction1(action: Bool,index: Int) {
        let postId = getImageData1?.data?.posts?.data[index].id ?? 0
       
        deletePostFromUpload(postId: postId, index: index)
    }
}
