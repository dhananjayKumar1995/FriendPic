//
//  FPHomeVC+CollectionViewCell.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 03/02/22.
//

import Foundation
import UIKit
import Kingfisher
import Lightbox

//MARK:- EXTENSION:- COLLECTION VIEW

extension FPHomeVC:
    
    
    UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return getImageData?.data?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(FPHomeVCCollectionViewCell.self, for: indexPath)
           let data = getImageData?.data?.images[indexPath.item]
           let token = kUserDefaults.string(forKey: "token") ?? ""
           cell.images.image  =  UIImage(named: "placeholder")
           let modifier = AnyModifier { request in
               var r = request
               r.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
               return r
           }
           cell.images.kf.setImage(with: URL(string: data?.path ?? ""),placeholder: UIImage(named: "placeholder"), options: [.requestModifier(modifier)]) { (image, error, type, url) in
               if error == nil && image != nil {
                   DispatchQueue.main.async {
                       cell.images.image = image
                   }
               }
               else {
                   cell.images.image  =  UIImage(named: "placeholder")
                   print("error: \(error?.localizedDescription ?? "")")
               }
           }
           return cell
       }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let images =  getImageData?.data?.images else {
            return
        }
        let photosStr = images.map({$0.path!})
        let vc = FPImagePreviewVC.instantiate(fromAppStoryboard: .registration)
        vc.currentSelectedIndexPath = indexPath
        vc.photos = photosStr
        vc.modalPresentationStyle = .fullScreen
        //vc.presen
        self.navigationController?.present(vc, animated: true)
//        let token = kUserDefaults.string(forKey: "token") ?? ""
//
//        let modifier = AnyModifier { request in
//            var r = request
//            // replace "Access-Token" with the field name you need, it's just an example
//            r.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//
//            return r
//        }
//        Loader.show()
//        let resource = ImageResource(downloadURL: imgURLString, cacheKey: "\(imgURLString.absoluteString)")
//        KingfisherManager.shared.retrieveImage(with: resource,options: [.requestModifier(modifier)]) { result in
//            Loader.hide()
//            switch result {
//            case .success(let value):
//                let images = [LightboxImage(image: value.image)]
//                let controller = LightboxController(images: images)
//                // controller.modalPresentationStyle = .fullScreen
//                controller.footerView.isHidden = true
//                controller.dynamicBackground = true
//                self.present(controller, animated: true, completion: nil)
//            case .failure(let error):
//                DisplayBanner1.show(title: "\(error.localizedDescription)")
//                print("Error: \(error.localizedDescription)")
//            }
//        }
    }
    
    //MARK:- SIZE FOR ITEM AT INDEXPATH
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height
        )
    }
}
extension FPHomeVC:UIScrollViewDelegate {
    
    //MARK:- SCROLL VIEW DID END DECELERATING / ROUND FOR CONTENT OFF SET
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if let indexPath = myTableView.indexPathForView(scrollView) {
            if let cell = myTableView.cellForRow(at: indexPath) as? FPHomeVCTableViewCell {
                
                let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
                
                cell.pageControl.currentPage = Int(pageNumber)
                let index = Int(pageNumber)
                let info = getImageData?.data?.images[index]
                cell.labelCountLike.text = "\(info?.upVote ?? 0)"
                cell.labelCountDislike.text = "\(info?.downVote ?? 0)"
                
            }
        }
        
    }
}
