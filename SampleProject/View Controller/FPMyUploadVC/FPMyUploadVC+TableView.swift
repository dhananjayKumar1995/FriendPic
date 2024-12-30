//
//  FPMyUploadVC+TableView.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 16/02/22.
//

import Foundation
import UIKit
import Kingfisher

extension FPMyUploadVC:UITableViewDelegate,UITableViewDataSource {
    
    
    //MARK:- numberOfRowsInSection section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getImageData1?.data?.posts?.data.count ?? 0
    }
    
    //MARK:- CELL FOR ROW AT INDEXPATH
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: "FPMyUploadVCTableViewCell", for: indexPath) as! FPMyUploadVCTableViewCell
        
        cell.myCollectionView.tag = indexPath.row
        cell.myCollectionView.delegate = self
        cell.myCollectionView.dataSource = self
        cell.myCollectionView.reloadData()
        cell.pageControl.currentPage = 0
        cell.buttonDelete.addTarget(self, action: #selector(buttonDeleteTapped), for: .touchUpInside)//USED IN ACTION FILE
        cell.buttonUploadToInata.addTarget(self, action: #selector(buttonUploadToInstaTapped), for: .touchUpInside)//USED IN ACTION FILE
        cell.buttonDownload.addTarget(self, action: #selector(buttonDownloadTapped), for: .touchUpInside)//USED IN ACTION FILE
        if ((getImageData1?.data?.posts?.data[cell.myCollectionView.tag].images.count) == 1)
               {
            cell.pageControl.numberOfPages = 0
               }
               else {
                   cell.pageControl.numberOfPages = (getImageData1?.data?.posts?.data[cell.myCollectionView.tag].images.count) ?? 0
                   
               }
        let upVote = getImageData1?.data?.posts?.data[indexPath.row].images.first?.upVote
        cell.labelLikeCount.text =  String(upVote ?? 0)
        
        let downVote = getImageData1?.data?.posts?.data[indexPath.row].images.first?.downVote
        cell.labelDislikeCount.text =  String(downVote ?? 0)
        
        
        
        //******** DATE FORMAT FROM SRTING TO PARTICULAR FORMAT

//        let date = Date()
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = .current
//        dateFormatter.locale = .current
//        //dateFormatter.dateStyle = .medium
//        dateFormatter.dateFormat = "d MMM, yyyy"
//        dateFormatter.timeStyle = .short
//        cell.labelDateTime.text = dateFormatter.string(from: date)
  
        
        let createdDateString = getImageData1?.data?.posts?.data[indexPath.row].createdAt ?? ""//"20/12/2020"
        cell.labelDateTime.text = createdDateString.toDateStringFromUTC(inputDateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", ouputDateFormat: "d MMM, yyyy")
        
        
        // Configure the cell

        cell.viewShadow.addshad(shadowColor: Color.appBlack, opacity: 0.5, offSet: CGSize(width: 0.0, height: 0.0), radius: 10.0, scale: true)
        cell.viewShadow.layer.shadowPath = UIBezierPath(rect: cell.viewShadow.bounds).cgPath
        cell.viewShadow.layer.shouldRasterize = true
        cell.viewShadow.layer.rasterizationScale = UIScreen.main.scale
        cell.myCollectionView.layoutIfNeeded()
        cell.myCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: false)

        return cell
    }
   
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell =  FPSettingVC.instantiate(fromAppStoryboard: .registration)
//        self.navigationController?.pushViewController(cell, animated: true)
//    }
    
    
    //MARK:-heightForRowAt indexPath
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let width = UIScreen.main.bounds.size.width - 40
         return width * 1.31
        
        }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           
        guard let itemsCount = getImageData1?.data?.posts?.data.count,let count = getImageData1?.data?.posts?.total else {
               
               return
           }
//           if isLoading && ((itemsCount - 1) != indexPath.row){
//               Console.log("FPMyUploadVC not last index or isLoading")
//               return
//           }
//
//           if itemsCount >= count {
//               Console.log("FPMyUploadVC all data loaded itemsCount \(itemsCount) and count \(count)")
//               return
//           }
//        getAllPostPagination(pageNo: currentPageNo + 1, loadingState: .nextPage)
           
        
        guard let itemsCount = getImageData1?.data?.posts?.data.count,let totalPage = getImageData1?.data?.posts?.lastPage else {
               
               return
           }
        
        if indexPath.row == itemsCount - 1 && currentPageNo <= totalPage{
            getAllPostPagination(pageNo: currentPageNo, loadingState: .nextPage)

        }
        
       }
}

extension String {
    
    
    //MARK:-
        func toDateStringFromUTC( inputDateFormat : String,  ouputDateFormat: String ) -> String
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = inputDateFormat
            dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
            let date = dateFormatter.date(from: self) // create   date from string
            
            // change to a readable time format and change to local time zone
            dateFormatter.dateFormat = ouputDateFormat
            dateFormatter.timeZone = NSTimeZone.local
            if date != nil {
                return dateFormatter.string(from: date!)
            }
            else{
                return ""
            }
            
        }
}
