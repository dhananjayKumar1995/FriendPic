//
//  FPSettingVC.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 16/02/22.
//

import UIKit
enum Types{
    case logout
    case delete
    case defaults
}
class Profile {
    var accountSection: String?
    var accountName: [String]?
    var accountImage: [String]?
    
    init(accountSection: String, accountName: [String],accountImage:[String]) {
        self.accountSection = accountSection
        self.accountName = accountName
        self.accountImage = accountImage
    }
}

//********************************

class FPSettingVC: UIViewController {
    @IBOutlet weak var labelSetting: UILabel!
    @IBOutlet weak var myTableViewConstraintHeight: NSLayoutConstraint!
    @IBOutlet weak var buttonLogout: UIButton!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var viewInternal: UIView!
    @IBOutlet weak var buttonNotification: UIButton!
    @IBOutlet weak var viewRoot: UIView!
    @IBOutlet weak var viewScrollView: UIScrollView!
    
    var userNameEmail:UserDataModel?
    var myAccount = [Profile]()
    var typImage = [String]()
    var typeName = [String]()
    var types:Types = .logout
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelName.text = kUserDefaults.object(forKey: UserDefaultKey.name) as? String
        labelEmail.text = kUserDefaults.object(forKey: UserDefaultKey.email) as? String
        
        let type = kUserDefaults.string(forKey: UserDefaultKey.account_type)
//        if type == "Apple" || type == "Facebook" {
//            typImage = ["Premiumplans","termCondition","privacyPolocy"]
//            typeName = ["Premium Plan","Terms and Conditions","Privacy Policy"]
//
//        }
//        else {
//            typImage = ["Premiumplans","change-password","termCondition","privacyPolocy"]
//            typeName = ["Premium Plan","Change Password","Terms and Conditions","Privacy Policy"]
//        }
        
        // Do any additional setup after loading the view.
        setupApperance()
        if type == "Apple" || type == "Facebook" {
            myAccount.append(Profile.init(accountSection: "My Account", accountName: ["Premium Plan","Terms and Conditions","Privacy Policy","Delete Account"], accountImage: ["Premiumplans","termCondition","privacyPolocy","accountDelete"]))
        }
        else {
            myAccount.append(Profile.init(accountSection: "My Account", accountName: ["Premium Plan","Change Password","Terms and Conditions","Privacy Policy","Delete Account"], accountImage: ["Premiumplans","change-password","termCondition","privacyPolocy","accountDelete"]))
        }
        
        
        //MARK:-REGISTER TABLE VIEW CELL
        myTableView.register(UINib(nibName: "FPSettingVCTableViewCell", bundle: nil), forCellReuseIdentifier: "FPSettingVCTableViewCell")
        myTableView.rowHeight = UITableView.automaticDimension
        myTableView.estimatedRowHeight = 48
    }

//    //MARK:- VIEW WILL APPER

    
    func setupApperance() {
        
        labelName.style(fontType:FontType.GoldplayBold, fontSize: .size20, textColor: Color.appDarkGray)
        labelEmail.style(fontType:FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appDarkGray)
        labelSetting.style(fontType:FontType.GoldplaySemiBold, fontSize: .size20, textColor: Color.appWhite)
        buttonLogout.style(fontType:FontType.GoldplaySemiBold, fontSize: .size20, textColor: Color.appWhite)
        
        //viewInternal.layer.cornerRadius = viewInternal.frame.height/25
       // viewInternal.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewRoot.layer.cornerRadius = viewRoot.frame.height/45
        viewRoot.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        
    }
    
}
