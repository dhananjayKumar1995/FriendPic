//
//  FPCommonPopUpVC.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 21/02/22.
//

import UIKit

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
    var fromHomeScreen = false
    var fromMyUploadScreen = false
    override func viewDidLoad() {
        super.viewDidLoad()

        SetUpApperence ()
        FromWhichScreen1 ()
        FromWhichScreen2 ()
       
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
    
    func FromWhichScreen1 () {
        
        if fromHomeScreen == true {
            
            labelGetPremiumPlan.style(fontType: FontType.GoldplayBold, fontSize: .size18, textColor: Color.appDarkGray)
            labelPremiumDiscreption.style(fontType: FontType.GoldplayMedium, fontSize: .size16, textColor: Color.appDarkGray)
            labelGetPremiumPlan.text = "Remove Picture"
            labelPremiumDiscreption.text = "Are you sure you\nwant to remove this picture."
            buttonConfirm.setTitle("YES", for: .normal)
            buttonConfirm.style(fontType: FontType.GoldplaySemiBold, fontSize: .size16, textColor: Color.appWhite)
            buttonCancel.style(fontType: FontType.GoldplaySemiBold, fontSize: .size15, textColor: Color.appBlue1)
        }
    }
    
    func FromWhichScreen2 () {
        
        if fromMyUploadScreen == true {
            
            labelGetPremiumPlan.style(fontType: FontType.GoldplayBold, fontSize: .size18, textColor: Color.appDarkGray)
            labelPremiumDiscreption.style(fontType: FontType.GoldplayMedium, fontSize: .size16, textColor: Color.appDarkGray)
            labelGetPremiumPlan.text = "Delete Picture"
            labelPremiumDiscreption.text = "Are you sure you want to\ndelete picture from my uploads."
            buttonConfirm.setTitle("YES", for: .normal)
            buttonConfirm.style(fontType: FontType.GoldplaySemiBold, fontSize: .size16, textColor: Color.appWhite)
            buttonCancel.style(fontType: FontType.GoldplaySemiBold, fontSize: .size15, textColor: Color.appBlue1)
        }
    }
}
