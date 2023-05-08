//
//  FPOnboardingVC+Action.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 18/01/22.
//

import Foundation
import UIKit

extension FPOnboardingVC {
    
    
    @IBAction func buttonBackTapped(_ sender: Any) {
        let visibleItems: NSArray = self.myCollectionView.indexPathsForVisibleItems as NSArray
            let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
            let nextItem: IndexPath = IndexPath(item: currentItem.item - 1, section: 0)
            if nextItem.row < onboardingImage.count && nextItem.row >= 0{
                self.myCollectionView.scrollToItem(at: nextItem, at: .right, animated: true)
    }
    }
    
    @IBAction func buttonSkipTapped(_ sender: Any) {
        kUserDefaults.set(true, forKey: "userFirstTime")
        let goToNextScreen = storyboard?.instantiateViewController(withIdentifier:  "FPLoginVC")as! FPLoginVC
        self.navigationController?.pushViewController(goToNextScreen, animated: true)
        
    }
    
    @IBAction func buttonNextTapped(_ sender: Any) {

        let visibleItems: NSArray = self.myCollectionView.indexPathsForVisibleItems as NSArray
            let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
            let nextItem: IndexPath = IndexPath(item: currentItem.item + 1, section: 0)
                   if nextItem.row < onboardingImage.count {
                self.myCollectionView.scrollToItem(at: nextItem, at: .left, animated: true)
       
            }
        if nextItem.row == 3 {
            
            kUserDefaults.set(true, forKey: "userFirstTime")
            let goToNextScreen = storyboard?.instantiateViewController(withIdentifier:  "FPLoginVC")as! FPLoginVC
                   self.navigationController?.pushViewController(goToNextScreen, animated: true)
        }
    }
    
}
