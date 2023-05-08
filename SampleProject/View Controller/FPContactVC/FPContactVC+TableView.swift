//
//  FPContactVC+TableView.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 18/02/22.
//

import Foundation
import UIKit
import Contacts
import SwiftyContacts

extension FPContactVC:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //showHideView()
        return searchArrRes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = myTableview.dequeueReusableCell(withIdentifier: "FPContactVCTableViewCell", for: indexPath) as? FPContactVCTableViewCell else {
            
            return UITableViewCell()
        }
        let myArray = searchArrRes[indexPath.row]
        cell.labelName.text = myArray.contactName
        cell.labelMobileNo.text = myArray.contactNumber
        cell.labelProfile.text = myArray.contactProfileName
        if myArray.isSelected == true {
            
            cell.buttonCheck.setImage(UIImage(named: "okTick1"), for: .normal)
            
        }
        else {
            
            cell.buttonCheck.setImage(UIImage(named: "emptyOkTick"), for: .normal)
            
        }
        cell.buttonCheck.addTarget(self, action: #selector(buttonCheckTapped), for: .touchUpInside)
        return cell
    }
    
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//        var sectionName:String?
//        if  buttonSearch.isSelected == true{
//
//
//            sectionName = "Searches Contact"
//            // buttonSearch.isSelected = false
//        }
//        else {
//
//            //buttonSearch.isSelected = true
//            sectionName = "Contact"
//        }
//        return sectionName
//    }
    
    //MARK: -viewForHeaderInSection
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        view.backgroundColor = .white
        let lbl = UILabel(frame: CGRect(x: 20, y: 0, width: view.frame.width - 20, height: 40))
        // lbl.style(fontType: FontType.segoeUI, fontSize: .size16, textColor: Color.appLightBlack)
        if  buttonSearch.isSelected == true{
            lbl.text = "Search Contacts"
            // buttonSearch.isSelected = false
        }
        else {
            //buttonSearch.isSelected = true
            lbl.text = "Contacts"
        }
        lbl.style(fontType: .GoldplayMedium, fontSize: .size13, textColor: UIColor.init(hexString: "8A8A8A"))
        // lbl.text =  contactSection[section].sectionName//mobileBrand[section].brandName
        view.addSubview(lbl)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    //MARK: -HEIGHT FOR ROW
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldSearchBar.resignFirstResponder()
        return true
    }
    
    //MARK: - SEARCH CONTACT WITH NAME ON SEARCH BAR
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        //input text
        
        let searchText =  (textField.text! as NSString).replacingCharacters(in: range, with: string)
        //add matching text to arrya
        print(searchText)
        if searchText.isEmpty == true {
            searchArrRes = myContact
            self.myTableview.reloadData()
            return true
        }
        var existData = [ContactList]()
        for data in myContact {
            if (data.contactName ?? "").lowercased().contains(searchText.lowercased()){
                existData.append(data)
            }
        }
        if existData.isEmpty {
            viewEmptyContact.isHidden = false
        }
        else {
            viewEmptyContact.isHidden = true
        }
        searchArrRes = existData

        self.myTableview.reloadData()
        
        return true
    }
    
    
    
    //MARK: - FETCH CONTACT LIST FROM DEVICE
    
    func fetchContactData() {
        
        let contactStore = CNContactStore()
        contactStore.requestAccess(for: .contacts) { (granted, err) in
            
            if let err = err {
                print("faild to request access permision",err)
                return
            }
            
            if granted{
                
                print("access granted permission",granted)
                
                
                let keys = [CNContactGivenNameKey,CNContactFamilyNameKey,CNContactPhoneNumbersKey]
                
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                
                do {
                    
                    request.sortOrder = CNContactSortOrder.userDefault
                    
                    try contactStore.enumerateContacts(with:request, usingBlock: {(contact,stopPointerIfYouWantToStopEnumerating) in
                        
                        let phone_Number = contact.phoneNumbers.first?.value.stringValue ?? ""
                        
                        //  if phone_Number != ""{
                        
                        //let full_Name = contact.givenName + " " + contact.familyName + " "
                        let full_Name = String.join(strings: [contact.givenName,contact.familyName], separator: " ")
                        let Contact_Profile = full_Name.first?.description ?? ""//full_Name.components(separatedBy: "
                        //")[0]// String(full_Name.characters.prefix(1))
                        if !phone_Number.isEmpty {
                            let contact_Model = ContactList(contactNumber:phone_Number, contactName:full_Name,contactProfileName: Contact_Profile)
                            self.myContact.append(contact_Model)
                        }
                        
                        
                        // }
                        
                    })
                    DispatchQueue.main.async {
                        self.searchArrRes = self.myContact
                        self.showHideView()
                        self.myTableview.reloadData()
                    }
                    
                }catch let err{
                    print("faild to enumarate contact",err)
                    return
                }
                
            }
            else {
                print("Access denied")
            }
        }
        
    }
    
    
    //MARK:- TO SHOW HOME SCREEN IF IMAGE IS AVAILABLE OR HIDE HOME SCREEN WITH BLANK SCREEN IF THERE IS NO IMAGES
    func showHideView() {
        
        if myContact.isEmpty == true//getImageDta?.data?.images.isEmpty == true
        {
            
            viewEmptyContact.isHidden = false
        }
        else {
            viewEmptyContact.isHidden = true
        }
    }
}
