//
//  FPSettingVC+TableViewCell.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 16/02/22.
//

import Foundation
import UIKit

extension FPSettingVC:UITableViewDelegate,UITableViewDataSource {
    
    //MARK:- numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myAccount[section].accountName?.count ?? 0
    }
    
    //MARK:- cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: "FPSettingVCTableViewCell", for: indexPath)as! FPSettingVCTableViewCell
        
        cell.imageTableCell.image = UIImage(named: myAccount[indexPath.section].accountImage?[indexPath.row] ?? "")
        cell.labelTableCell.text = myAccount[indexPath.section].accountName?[indexPath.row]
        return cell
        
    }
    
    //MARK:- DID SELECT ROW AT INDEXPATH
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let count = myAccount[indexPath.section].accountName?.count ?? 0
        if count > 4 {
            if indexPath.row == 0 {
                let goToNextScreen = self.storyboard?.instantiateViewController(withIdentifier: "FPPremiumPlanVC")as! FPPremiumPlanVC
                goToNextScreen.hidesBottomBarWhenPushed = true
                
                self.navigationController?.pushViewController(goToNextScreen, animated: true)
            }
            else if indexPath.row == 1 {
                let goToNextScreen = self.storyboard?.instantiateViewController(withIdentifier: "FPChangePasswordVC")as! FPChangePasswordVC
                goToNextScreen.hidesBottomBarWhenPushed = true
                
                self.navigationController?.pushViewController(goToNextScreen, animated: true)
            }
            else if indexPath.row == 2 {
                let goToNextScreen = self.storyboard?.instantiateViewController(withIdentifier: "FPTermConditionVC")as! FPTermConditionVC
                goToNextScreen.hidesBottomBarWhenPushed = true
                goToNextScreen.currentState = .termsAndCondition
                self.navigationController?.pushViewController(goToNextScreen, animated: true)
            }
            else if indexPath.row == 3{
                let goToNextScreen = self.storyboard?.instantiateViewController(withIdentifier: "FPTermConditionVC")as! FPTermConditionVC
                goToNextScreen.hidesBottomBarWhenPushed = true
                goToNextScreen.currentState = .privacyPolicy
                self.navigationController?.pushViewController(goToNextScreen, animated: true)
                
            }
            else{
                let goToNextScreen = self.storyboard?.instantiateViewController(withIdentifier: "FPDeleteAccountVC")as! FPDeleteAccountVC
                goToNextScreen.hidesBottomBarWhenPushed = true
                
                self.navigationController?.pushViewController(goToNextScreen, animated: true)
            }
        }
        else {
            if indexPath.row == 0 {
                let goToNextScreen = self.storyboard?.instantiateViewController(withIdentifier: "FPPremiumPlanVC")as! FPPremiumPlanVC
                goToNextScreen.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(goToNextScreen, animated: true)
            }
            else if indexPath.row == 1 {
                let goToNextScreen = self.storyboard?.instantiateViewController(withIdentifier: "FPTermConditionVC")as! FPTermConditionVC
                goToNextScreen.hidesBottomBarWhenPushed = true
                goToNextScreen.currentState = .termsAndCondition
                self.navigationController?.pushViewController(goToNextScreen, animated: true)
            }
            else if indexPath.row == 2{
                let goToNextScreen = self.storyboard?.instantiateViewController(withIdentifier: "FPTermConditionVC")as! FPTermConditionVC
                goToNextScreen.hidesBottomBarWhenPushed = true
                goToNextScreen.currentState = .privacyPolicy
                self.navigationController?.pushViewController(goToNextScreen, animated: true)
                
            }
            else{
                let type = kUserDefaults.string(forKey: UserDefaultKey.account_type)
                if type == "Apple" || type == "Facebook"{
                    
                    FPSettingVC.showOkPopup(parentVC: self, type: .delete)
                }
                else{
                let goToNextScreen = self.storyboard?.instantiateViewController(withIdentifier: "FPDeleteAccountVC")as! FPDeleteAccountVC
                goToNextScreen.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(goToNextScreen, animated: true)
                }
            }
        }
    }
    
    //MARK:-viewForHeaderInSection
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        view.backgroundColor = Color.appWhite
        
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 15, height: 20))
        lbl.style(fontType: FontType.GoldplaySemiBold, fontSize: .size15, textColor: Color.appDarkGray)
        lbl.text = myAccount[section].accountSection//mobileBrand[section].brandName
        view.addSubview(lbl)
        return view
    }
    //    //MARK:-HEIGHT FOR ROW
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return UITableView.automaticDimension
    //    }
    //
    //    //MARK:- ESTIMATED ROW HEIGHT (DYNAMIC HEIGHT)
    //    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    //
    //        return 45.0
    //    }
}
