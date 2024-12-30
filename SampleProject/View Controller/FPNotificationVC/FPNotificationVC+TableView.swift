//
//  FPNotificationVC+TableView.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 22/02/22.
//

import Foundation
import UIKit

extension FPNotificationVC :UITableViewDelegate,UITableViewDataSource {
    
    //MARK:-NUMBER OF SECTION
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notification?.data?.notifications?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowData = notification?.data?.notifications?.data?[indexPath.row]
      
        guard let cell = myTableView.dequeueReusableCell(withIdentifier: "FPNotificationVCTableViewCell", for: indexPath) as? FPNotificationVCTableViewCell else {
            
            return UITableViewCell()
        }
        cell.labelName.text = rowData?.message
        cell.imageProfile.image = UIImage(named: "settingProfile")
        //cell.labelDateTime.text = rowData?.opponentUser?.createdAt
        if rowData?.isSelected ?? false {

            cell.viewInternal.backgroundColor = Color.appLightSkyBlue.withAlphaComponent(0.12)

        }
        else {

            cell.viewInternal.backgroundColor = Color.appLightGray1

        }
        
        let createdDateTimeString = notification?.data?.notifications?.data?[indexPath.row].createdAt ?? ""
        cell.labelDateTime.text = createdDateTimeString.toDateStringFromUTC(inputDateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", ouputDateFormat: "MMM d yyyy, h:mm a")
        return cell
       /* if dataObject?.isSelectedOfVC == false {
            
            let cell = myTableView.dequeueReusableCell(withIdentifier: "FPNotificationVCTableViewCell", for: indexPath) as! FPNotificationVCTableViewCell
           
            cell.labelName.text = notification?.data?.notifications?.data?[indexPath.row].opponentUser?.name
            cell.labelDateTime.text = notification?.data?.notifications?.data?[indexPath.row].opponentUser?.createdAt
            return cell
        }
        else {

            dataObject?.isSelectedOfVC = true
            let cell = myTableView.dequeueReusableCell(withIdentifier: "FPNotificationVCTableViewCell", for: indexPath) as! FPNotificationVCTableViewCell
            cell.labelName.text = notification?.data?.notifications?.data?[indexPath.row].opponentUser?.name
            cell.labelDateTime.text = notification?.data?.notifications?.data?[indexPath.row].opponentUser?.createdAt


            if dataObject?.isSelectedOfVC == true {
                cell.viewInternal.backgroundColor = Color.appLightSkyBlue.withAlphaComponent(0.12)
            }
            else {
                cell.viewInternal.backgroundColor = Color.appRed
            }
            return cell
        }*/
       
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           
        guard let itemsCount = notification?.data?.notifications?.data?.count,let count = notification?.data?.notifications?.total else {
               
               return
           }
        
        if indexPath.row == (itemsCount) - 1 && currentPageNo <= notification?.data?.notifications?.lastPage ?? 1{
            getAllNotification(pageNo: currentPageNo, loadingState: .nextPage)
        }
        
/*
           if isLoading && ((itemsCount - 1) != indexPath.row){
               Console.log("FPNotificationVC not last index or isLoading")
               return
           }
           
           if itemsCount >= count {
               Console.log("FPNotificationVC all data loaded itemsCount \(itemsCount) and count \(count)")
               return
           }
        getAllNotification(pageNo: currentPageNo + 1, loadingState: .nextPage)
        */
           
       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension//100.0
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//        var sectionName:String?
//            sectionName = "Recent"
//        return sectionName
//    }
    
    //MARK:-viewForHeaderInSection
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 5))
        view.backgroundColor = .clear
        return view
    }
//
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
//
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    //MARK:-viewForHeaderInSection
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//           let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0))
//
//        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 15, height: 20))
//        lbl.style(fontType: FontType.GoldplayMedium, fontSize: .size14, textColor: Color.appLightgray)
//        lbl.text = allNotification[section].notificationSection
//
//           view.addSubview(lbl)
//           return view
//         }
    
    
    //MARK:- DID SELECT ROW AT INDEXPATH
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        notification?.data?.notifications?.data?[indexPath.row].isSelected?.toggle()
        myTableView.reloadData()
    }

    //MARK:- DID DSELECT METHOD *********************************************************************
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {

        let cell = myTableView.cellForRow(at: indexPath) as? FPNotificationVCTableViewCell
            cell?.viewInternal.backgroundColor = Color.appLightGray1
    }
    
}

extension String {
    
    //MARK:-
        func toDateTimeStringFromUTC( inputDateFormat : String,  ouputDateFormat: String ) -> String
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
