//
//  FPCommonPopUpVC.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 21/02/22.
//

import UIKit
enum PopupType{
    case fromHomeScreen
    case fromMyUploadScreen
    case atEvery3rdLoginAttempt
}
//MARK:- PROTOCOL METHOD
protocol CommonPopUpDelegate {
    func handleAction1(action: Bool,index:Int)
}

class FPCommonPopUpVC: UIViewController {

    @IBOutlet weak var ViewDialogBox: UIView!
    
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var buttonConfirm: UIButton!
    @IBOutlet weak var labelPremiumDiscreption: UILabel!
    @IBOutlet weak var labelGetPremiumPlan: UILabel!
    
    var selectedIndex:Int = 0
    var delegate : CommonPopUpDelegate?
    var popupType:PopupType = .fromHomeScreen
    
  //  var fromHomeScreen = false
   // var fromMyUploadScreen = false
    override func viewDidLoad() {
        super.viewDidLoad()

        SetUpApperence ()
        popupSetup()
        // Do any additional setup after loading the view.
    }

    func SetUpApperence () {
        
        ViewDialogBox.layer.cornerRadius = ViewDialogBox.layer.frame.size.height/20
        labelGetPremiumPlan.style(fontType: FontType.GoldplayBold, fontSize: .size18, textColor: Color.appFPBlue3)
        labelPremiumDiscreption.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appDarkGray)
        labelPremiumDiscreption.text = "If you want to invite more than 3 contact\n you need to \"Continue\"\nfor Premium Plan."
        buttonConfirm.setTitle("CONFIRM", for: .normal)
        buttonConfirm.style(fontType: FontType.GoldplaySemiBold, fontSize: .size16, textColor: Color.appWhite)
        buttonCancel.style(fontType: FontType.GoldplaySemiBold, fontSize: .size18, textColor: Color.appDarkGrayColor)
    }
    
    func popupSetup(){
        labelGetPremiumPlan.style(fontType: FontType.GoldplayBold, fontSize: .size18, textColor: Color.appDarkGray)
        labelPremiumDiscreption.style(fontType: FontType.GoldplayMedium, fontSize: .size16, textColor: Color.appDarkGray)
        buttonCancel.style(fontType: FontType.GoldplaySemiBold, fontSize: .size15, textColor: Color.appBlue1)

        switch popupType{
            
        case .fromHomeScreen:
            
            labelGetPremiumPlan.text = "Remove Picture"
            labelPremiumDiscreption.text = "Are you sure you\nwant to remove this picture."
            buttonConfirm.setTitle("YES", for: .normal)
            
        case .fromMyUploadScreen:
            labelGetPremiumPlan.text = "Delete Picture"
            labelPremiumDiscreption.text = "Are you sure you want to\ndelete picture from my uploads."
            buttonConfirm.setTitle("YES", for: .normal)
            
        case .atEvery3rdLoginAttempt:
            labelGetPremiumPlan.isHidden = true
            labelPremiumDiscreption.text = "Upgrade to Premium for exclusive benefits, adding additional friends."//"Enhance your experience by joining our Premium membership. Enjoy exclusive benefits and features that will take your experience to the next level."
            buttonConfirm.setTitle("Premium Plan", for: .normal)
        }
    }
}
