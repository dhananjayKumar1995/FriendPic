//
//  FPHomeVC+TableView.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 08/04/22.
//

import Foundation
import UIKit

extension FPHomeVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let imgCount = getImageData?.data?.images.count ?? 0
        if imgCount > 0
        {
            return 1
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = myTableView.dequeueReusableCell(withIdentifier: "FPHomeVCTableViewCell", for: indexPath) as? FPHomeVCTableViewCell else {return UITableViewCell()}
        cell.myCollectionView.tag = indexPath.row
        cell.myCollectionView.delegate = self
        cell.myCollectionView.dataSource = self
        cell.myCollectionView.reloadData()
        
        cell.buttonLike.addTarget(self, action: #selector(buttonLikeTapped), for: .touchUpInside)//USED IN ACTION FILE
        cell.buttonDislike.addTarget(self, action: #selector(buttonDislikeTapped), for: .touchUpInside)//USED IN ACTION FILE
        cell.buttonShare.addTarget(self, action: #selector(buttonShareTapped), for: .touchUpInside)//USED IN ACTION FILE
        
        if ((getImageData?.data?.images.count == 1))
        {
            cell.pageControl.numberOfPages = 0
        }
        else {
            cell.pageControl.numberOfPages = (getImageData?.data?.images.count) ?? 0
            
        }
        cell.labelCountLike.text = "\(getImageData?.data?.images.first?.upVote ?? 0)"
        cell.labelCountDislike.text = "\(getImageData?.data?.images.first?.downVote ?? 0)"
        
        cell.viewShadow.setShadow(radius: 10)
        cell.viewLikeDislike.addshad(shadowColor: Color.appBlack, opacity: 0.1, offSet: CGSize(width: 0.0, height: 0.0), radius: 15.0, scale: true)
        return cell
    }
    
    //MARK:-heightForRowAt indexPath
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableWidth = tableView.frame.size.width
        return tableWidth
    }
}
