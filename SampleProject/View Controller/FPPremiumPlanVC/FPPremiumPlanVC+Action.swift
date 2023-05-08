//
//  FPPremiumPlanVC+Action.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 24/02/22.
//

import Foundation
import UIKit

extension FPPremiumPlanVC {
    
    @IBAction func buttonBackTapped(_ sender: Any) {
    
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonActivatePlanTapped(_ sender: UIButton) {
        guard let indexPath = myTableView.indexPathForView(sender) else {
            return
        }
        if kAppDelegate.mySubscription == nil {
            DisplayBanner1.show(title: "Something went wrong.")
        }
        else {
            if kAppDelegate.mySubscription?.data?.subscription == nil {
                IAPManager.shared.purchaseMyProduct(identifier: products[indexPath.row].identifier)
            }
            else if kAppDelegate.mySubscription?.data?.subscription?.isExpired == 0 {
                DisplayBanner1.show(title: "Already purchased")
            }
            else {
                IAPManager.shared.purchaseMyProduct(identifier: products[indexPath.row].identifier)
            }
        }
    }
    
    @IBAction func buttonRestoreTapped(_ sender: Any) {
        
        IAPManager.shared.restorePurchase()
    }
    
    
    @IBAction func buttonTermConditionTapped(_ sender: Any) {
        
        let goToNextScreen = self.storyboard?.instantiateViewController(withIdentifier: "FPTermConditionVC")as! FPTermConditionVC
        goToNextScreen.currentState = .termsAndCondition
        self.navigationController?.pushViewController(goToNextScreen, animated: true)
    }
    
    
    @IBAction func buttonPrivacyPolicyTapped(_ sender: Any) {
        
        let goToNextScreen = self.storyboard?.instantiateViewController(withIdentifier: "FPTermConditionVC")as! FPTermConditionVC
        goToNextScreen.currentState = .privacyPolicy
        self.navigationController?.pushViewController(goToNextScreen, animated: true)
    }
    
   
}
