//
//  FPPremiumPlanVC+TableView.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 25/02/22.
//

import Foundation
import UIKit

extension FPPremiumPlanVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = myTableView.dequeueReusableCell(withIdentifier: "FPPremiumPlanVCTableViewCell", for: indexPath) as? FPPremiumPlanVCTableViewCell else {
            
            return UITableViewCell()
        }
        cell.buttonActivatePlan.tag = indexPath.row
        cell.buttonActivatePlan.addTarget(self, action: #selector(buttonActivatePlanTapped), for: .touchUpInside)//USED IN ACTION FILE
        
        let data = products[indexPath.row]
          
        cell.labelDoller.text =  data.priceWithCurrency
               if data.identifier == IAPManager.monthlySubscriptionIdentifier {
                   cell.labelMonth.text = "Monthly"
               }
         
//            else {
//                   cell.lbl1.text = "Yearly"
//               }
        
        if kAppDelegate.mySubscription == nil {
            cell.buttonActivatePlan.setTitle("Something went wrong", for: .normal)
            //cell.buttonActivatePlan.isUserInteractionEnabled = false
        }
        else {
            if kAppDelegate.mySubscription?.data?.subscription == nil {
                cell.buttonActivatePlan.setTitle("ACTIVATE PLAN", for: .normal)
            }
            else if kAppDelegate.mySubscription?.data?.subscription?.isExpired == 0 {
                cell.buttonActivatePlan.setTitle("ACTIVATED", for: .normal)
               // cell.buttonActivatePlan.isUserInteractionEnabled = true
            }
            else{
                cell.buttonActivatePlan.setTitle("ACTIVATE PLAN(Expired)", for: .normal)
               // cell.buttonActivatePlan.isUserInteractionEnabled = true
            }
        }
        return cell
    }
    
    //MARK:-HEIGHT FOR ROW
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let width = UIScreen.main.bounds.size.width - 50
        print(width)
         return width * 1.1
        
    }
    
}
