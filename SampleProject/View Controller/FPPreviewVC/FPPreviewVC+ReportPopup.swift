//
//  FPPreviewVC+ReportPopup.swift
//  SampleProject
//
//  Created by MC-MM0012 on 06/06/22.
//

import Foundation
import UIKit

extension FPPreviewVC {
    
    //mark:- SHOW POP UP STATIC METHOD
    static func showReportPopup(parentVC: UIViewController,postId:Int){
        //creating a reference for the dialogView controller
        if let popupVC = UIStoryboard(name: "Registration", bundle: nil).instantiateViewController(withIdentifier: "FPPreviewReportVC") as? FPPreviewReportVC {

          //  popupVC.modalPresentationStyle = .overCurrentContext//.fullScreen
            popupVC.postId = postId
            popupVC.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            popupVC.modalPresentationStyle = .custom
            popupVC.modalTransitionStyle = .crossDissolve
            //presenting the pop up viewController from the parent viewController
            parentVC.present(popupVC, animated: true)
            
            //setting the delegate of the dialog box to the parent viewController
            popupVC.delegate = parentVC as? IsReporedDelegate
            //presenting the pop up viewController from the parent viewController
        }
    }
}
//MARK:- DELEGATE METHOD
extension FPPreviewVC :IsReporedDelegate {
    func isRepored(isReported: Int) {
         otherPostModel?.data?.post?.is_reported = isReported
    }
}
