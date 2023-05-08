//
//  FPOnboardingVC+CollectionView.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 18/01/22.
//

import Foundation
import UIKit

extension FPOnboardingVC :UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    //MARK:- NUMBER OF ITEMS IN SECTION
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardingImage.count
    }
    
    //MARK:- CELL FOR ITEM AT INDEXPATH
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        
//        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "FPOnboardingCVC", for: indexPath)as! FPOnboardingCVC
//        cell.imageCollectionViewCell.image = UIImage(named: onboardingImage[indexPath.row])
//        cell.labelDescription.text = onboardingLabel[indexPath.row]
         let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "FPOnboardingVCCollectionViewCell", for: indexPath) as! FPOnboardingVCCollectionViewCell
        
        cell.LabelDescription.text = onboardingLabel[indexPath.row]
        cell.imageCollection.image = UIImage(named: onboardingImage[indexPath.row])
        
        if indexPath.row == 0 || indexPath.row == 1 {
            cell.leadingConsImage.constant = 10
        }
        else {
            cell.leadingConsImage.constant = 0
        }
        return cell
    }
    
    //MARK:- SIZE FOR ITEM AT INDEXPATH
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: myCollectionView.frame.size.width, height: myCollectionView.frame.size.height
        )
    }

    //MARK:-willDisplay
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        //buttonBack.isHidden = (indexPath.row == collectionView.numberOfItems(inSection: 0) - 1)
        buttonBack.isHidden = (indexPath.row == 0)
        buttonSkip.isHidden = (indexPath.row == 2)
        if indexPath.row == 2 {
        buttonNext.setTitle("GET STARTED", for: .normal)
            buttonSkip.isHidden = true
        }
        else {
            buttonNext.setTitle("NEXT", for: .normal)
        }
    }
    
   /* func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(floor(self.myCollectionView.contentOffset.x/self.myCollectionView.frame.width))
        buttonBack.isHidden = index == 0 ? true : false
        buttonSkip.isHidden = index == 2 ? true : false
        
        if index == 2 {
            buttonNext.setTitle("GET STARTED", for: .normal)
            buttonSkip.isHidden = true
        }
        else {
            buttonNext.setTitle("NEXT", for: .normal)
        }
        
    }
    */
}

