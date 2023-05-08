//
//  FPPreviewVC+CollectionView.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 23/02/22.
//

import Foundation
import UIKit
import Kingfisher

extension FPPreviewVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return otherPostModel?.data?.post?.images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "FPHomeVCCollectionViewCell", for: indexPath) as! FPHomeVCCollectionViewCell
        let image = otherPostModel?.data?.post?.images?[indexPath.item]
        if let urlStr = image?.path , let url = URL(string: urlStr) {
            cell.images.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        }
        else {
            cell.images.image = UIImage(named: "placeholder")
        }
        return cell
    }
    
    //MARK:- SIZE FOR ITEM AT INDEXPATH
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: myCollectionView.frame.size.width, height: myCollectionView.frame.size.height
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            guard let images =  otherPostModel?.data?.post?.images else {
                return
            }
            let photosStr = images.map({$0.path!})
            let vc = FPImagePreviewVC.instantiate(fromAppStoryboard: .registration)
            vc.currentSelectedIndexPath = indexPath
            vc.photos = photosStr
            let nav = UINavigationController(rootViewController: vc)
            nav.isNavigationBarHidden = true
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        }
}
