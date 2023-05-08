//
//  FPMyUploadVC+CollectionView.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 17/02/22.
//

import Foundation
import Lightbox
import Kingfisher


extension FPMyUploadVC: UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        collectionView.reloadData()
        return getImageData1?.data?.posts?.data[collectionView.tag].images.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FPHomeVCCollectionViewCell", for: indexPath)as! FPHomeVCCollectionViewCell
        // cell.images.image = UIImage(named: imgCollection[indexPath.row])
        
        
        let data = getImageData1?.data?.posts?.data[collectionView.tag].images[indexPath.item]
        let token = kUserDefaults.string(forKey: "token") ?? ""
        let modifier = AnyModifier { request in
            var r = request
            // replace "Access-Token" with the field name you need, it's just an example
            r.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            return r
        }
        
        cell.images.kf.setImage(with: URL(string: data?.path ?? "placeholder"),placeholder: UIImage(named: "placeholder"), options: [.requestModifier(modifier)]) { (image, error, type, url) in
            if error == nil && image != nil {
                // here the downloaded image is cached, now you need to set it to the imageView
                DispatchQueue.main.async {
                    cell.images.image = image
                }
            } else {
                // handle the failure
                print(error)
            }
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let images =  getImageData1?.data?.posts?.data[collectionView.tag].images else {
            return
        }
        let photosStr = images.map({$0.path!})
        let vc = FPImagePreviewVC.instantiate(fromAppStoryboard: .registration)
        vc.currentSelectedIndexPath = indexPath
        vc.photos = photosStr
        vc.modalPresentationStyle = .fullScreen
        //vc.presen
        self.navigationController?.present(vc, animated: true)
    }
    
    
    //MARK:- SIZE FOR ITEM AT INDEXPATH
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height
                      
        )
    }
}

extension FPMyUploadVC:UIScrollViewDelegate {
    
    //MARK:- SCROLL VIEW DID END DECELERATING / ROUND FOR CONTENT OFF SET
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if let indexPath = myTableView.indexPathForView(scrollView) {
            if let cell = myTableView.cellForRow(at: indexPath) as? FPMyUploadVCTableViewCell {
                
                let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
                
                cell.pageControl.currentPage = Int(pageNumber)
                let index = Int(pageNumber)
                let info = getImageData1?.data?.posts?.data[indexPath.row].images[index]
                cell.labelLikeCount.text =  String(info?.upVote ?? 0)
                cell.labelDislikeCount.text =  String(info?.downVote ?? 0)
                
            }
        }
        
    }
}
