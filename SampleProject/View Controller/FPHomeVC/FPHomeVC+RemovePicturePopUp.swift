//
//  FPHomeVC+RemovePicturePopUp.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 21/02/22.
//

import Foundation
import UIKit

extension FPHomeVC {
    
    //mark:- SHOW POP UP STATIC METHOD
    static func showRemovePicturePopup(parentVC: UIViewController){

        let popupVC = FPCommonPopUpVC.instantiate(fromAppStoryboard: .registration)
        popupVC.modalTransitionStyle = .crossDissolve
        popupVC.modalPresentationStyle = .custom
        popupVC.delegate = parentVC as? CommonPopUpDelegate
        popupVC.popupType = .fromHomeScreen
        parentVC.present(popupVC, animated: true, completion: nil)
    }
}

//MARK:- DELEGATE METHOD
extension FPHomeVC :CommonPopUpDelegate {
    func handleAction1(action: Bool, index: Int) {
        //removeDashboardImage(userId: userId, index: index)
        if kAppDelegate.showPremiumPopup == true{
            kAppDelegate.showPremiumPopup = false
            
            let vc = FPPremiumPlanVC.instantiate(fromAppStoryboard: .registration)
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            removeDashboardImage()
        }
    }
    
}

//MARK:- DELEGATE METHOD
extension FPHomeVC :SharedAtDelegate {
    func isAlreadyShared(isShared: String) {
        getImageData?.data?.sharedAt = isShared
        
    }
    
    
}
