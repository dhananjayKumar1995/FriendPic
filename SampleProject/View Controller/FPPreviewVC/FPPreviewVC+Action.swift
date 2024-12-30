//
//  FPPreviewVC+Action.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 23/02/22.
//

import Foundation
import UIKit

extension FPPreviewVC {
    
    @IBAction func buttonReportFlagTapped(_ sender: UIButton) {
        let isrepored = otherPostModel?.data?.post?.is_reported ?? 0
        if isrepored == 1{
            DisplayBanner1.show(title: "Already reported on this post")

        }else{
        let postId = otherPostModel?.data?.post?.images?[sender.tag].postId ?? 0
        FPPreviewVC.showReportPopup(parentVC: self, postId: postId)
        }
    }
    @IBAction func buttonUserBlockTapped(_ sender: UIButton) {

        FPPreviewVC.showConfirmPopup(parentVC: self)

    }
    @IBAction func buttonBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
  
    @IBAction func buttonLikeTapped(_ sender: UIButton) {
        let url = urlStr.components(separatedBy: "?").first ?? ""
        let token = url.components(separatedBy: "/").last ?? ""
        if let id = otherPostModel?.data?.post?.images?[pageControl.currentPage].id{
            if let sharedId = otherPostModel?.data?.share?.id{
                voting(token: token, index: sender.tag,isLike:true, imageId: "\(id)",shareid: sharedId)
            }
        }
          
    }
    
    @IBAction func buttonDislikeTapped(_ sender: UIButton) {
        let url = urlStr.components(separatedBy: "?").first ?? ""
        let token = url.components(separatedBy: "/").last ?? ""
        if let id = otherPostModel?.data?.post?.images?[pageControl.currentPage].id{
            if let sharedId = otherPostModel?.data?.share?.id{
                voting(token: token, index: sender.tag,isLike:false, imageId: "\(id)", shareid: sharedId)
            }
        }
    }
}
