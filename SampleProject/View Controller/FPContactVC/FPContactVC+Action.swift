//
//  FPContactVC+Action.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 18/02/22.
//

import Foundation
import UIKit

extension FPContactVC {
    
    @IBAction func buttonSearchTapped(_ sender: Any) {
        SearchBar()
    }
    @IBAction func buttonSendTapped(_ sender: UIButton) {

       
        let selectedArray = myContact.filter({ $0.isSelected  == true   })
        
        if selectedArray.count > 0 {
            
            var contactList = [[String:Any]]()
            // = ["name":myContact[indexPaths.row].contactName,"mobile":myContact[indexPaths.row].contactNumber]
            
            for item in selectedArray {
                contactList.append(["name":item.contactName ?? "", "mobile":item.contactNumber ?? ""])
            }
            
            print("Request,\(contactList)")
            view.endEditing(true)
            shareImage(params: ["contacts":contactList])
        }
        else {
            DisplayBanner1.show(title: "Select atleast one user!")
        }
    }
    
    @IBAction func buttonBackTapped(_ sender: Any) {
        
        if  buttonSearch.isSelected == true{

            viewSearchBar.isHidden = true
            
            buttonSearch.isSelected = false
            searchArrRes = myContact
            textFieldSearchBar.text = ""
            //textFieldSearchBar.placeholder = 
            myTableview.reloadData()
        }
        else {

            //buttonSearch.isSelected = true
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func buttonTextfieldTapped(_ sender: UIButton) {
//        buttonTextfield.isSelected = true
//        if buttonTextfield.isSelected == true {
//        textFieldSearchBar.text = nil
//        }
        
    }
    
    @IBAction func buttonCheckTapped(_ sender: UIButton) {
        
        guard let indexPaths = myTableview.indexPathForView(sender) else {
            
            return
        }
        
        let selectedCount = myContact.filter({ $0.isSelected  == true   }).count
        if kAppDelegate.mySubscription == nil {
            subscriptionDetail()
            return
        }
        if kAppDelegate.mySubscription?.data?.subscription?.isExpired == 0 {
            if selectedCount == 5 {
                if searchArrRes[indexPaths.row].isSelected {
                    searchArrRes[indexPaths.row].isSelected.toggle()
                    if let index  = myContact.firstIndex(where: {$0.contactNumber == searchArrRes[indexPaths.row].contactNumber }) {
                        myContact[index].isSelected.toggle()
                    }
                }
                else {
                    DisplayBanner1.show(title: "You have a maximum limit of 5 user")
                }
            }
            else {
                searchArrRes[indexPaths.row].isSelected.toggle()
                if let index  = myContact.firstIndex(where: {$0.contactNumber == searchArrRes[indexPaths.row].contactNumber }) {
                    myContact[index].isSelected.toggle()
                }
            }
        }
        else {
            if selectedCount == 3 {
                if searchArrRes[indexPaths.row].isSelected {
                    searchArrRes[indexPaths.row].isSelected.toggle()
                    if let index  = myContact.firstIndex(where: {$0.contactNumber == searchArrRes[indexPaths.row].contactNumber }) {
                        myContact[index].isSelected.toggle()
                    }
                }
                else {
                    
                    FPContactVC.showConfirmPopup(parentVC: self)
                    print("show popup for premium plan")
                }
            }
            else {
                searchArrRes[indexPaths.row].isSelected.toggle()
                if let index  = myContact.firstIndex(where: {$0.contactNumber == searchArrRes[indexPaths.row].contactNumber }) {
                    myContact[index].isSelected.toggle()
                }
            }
        }
        myTableview.reloadData()
        
    }
    
   
}
