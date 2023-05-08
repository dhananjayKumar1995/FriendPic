//
//  SCPreviewVC+CollectionView.swift
//  Shift
//
//  Created by Mobilecoderz1 on 07/08/19.
//  Copyright © 2019 Mobilecoderz. All rights reserved.
//

import UIKit
import Kingfisher

extension FPImagePreviewVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(FPPreviewPhotoCollectionCell.self, for: indexPath)
        let photo = photos[indexPath.row]
        let placeholder = UIImage(named: "placeholder")
        let token = kUserDefaults.string(forKey: "token") ?? ""
        let modifier = AnyModifier { request in
            var r = request
            r.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            return r
        }
        cell.imageViewPhoto.backgroundColor = .clear
        cell.scrollView.backgroundColor = .clear
        cell.imageViewPhoto.contentMode = .scaleAspectFit
        //cell.imageViewPhoto.isHidden  = true
        cell.imageViewBckgrounImage.contentMode = .scaleAspectFill
        cell.imageViewPhoto.kf.setImage(with: URL(string: photo),placeholder: placeholder, options: [.requestModifier(modifier)]) { (image, error, type, url) in
            if error == nil && image != nil {
                DispatchQueue.main.async {
                    cell.imageViewPhoto.image = image
                    cell.imageViewBckgrounImage.image = image
                }
            }
            else {
                cell.imageViewPhoto.image  =  placeholder
                cell.imageViewBckgrounImage.image = placeholder
                print("error: \(error?.localizedDescription ?? "")")
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as? FPPreviewPhotoCollectionCell
        cell?.scrollView.zoomScale = 1.0
    }
    
}

extension FPImagePreviewVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width
        let height = collectionView.frame.size.height
        return CGSize(width: width, height: height)
    }
}
