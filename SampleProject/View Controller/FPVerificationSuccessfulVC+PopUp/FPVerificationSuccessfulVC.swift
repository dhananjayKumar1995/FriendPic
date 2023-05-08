//
//  FPVerificationSuccessfulVC.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 25/01/22.
//

import UIKit
//MARK:- PROTOCOL METHOD
protocol PopUpDelegate {
    func handleAction1(action: Bool,passwordToken:String)
    func handleAction2(action: Bool)
}

class FPVerificationSuccessfulVC: UIViewController {
    @IBOutlet weak var labelEmailSucessfulVerify: UILabel!
    @IBOutlet weak var buttonOk: UIButton!
    @IBOutlet weak var labelVerificationSucessful: UILabel!
    @IBOutlet weak var imageOkTick: UIImageView!
    @IBOutlet weak var viewPopupBox: UIView!
    @IBOutlet weak var buttonCancel: UIButton!
    
    //MARK:- VARIABLE
    var delegate : PopUpDelegate?
    var fromSettingScreen = false
    var fromDeleteAcScreen = false
    var types:Types = .defaults
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // setupApperence()
       // fromSettingScreens()
       // fromDeleteScreens()
        types(types:types)
        viewPopupBox.layer.cornerRadius = viewPopupBox.layer.frame.size.height/20
        // Do any additional setup after loading the view.
    }
    func types(types:Types){
    switch types {
    case .logout:
        buttonOk.setTitle("Yes", for: .normal)
        imageOkTick.image = UIImage(named: "logout")
        labelVerificationSucessful.text = "Are you sure"
        labelEmailSucessfulVerify.text = "you want to logout?"
        buttonOk.style(fontType: FontType.GoldplaySemiBold, fontSize: FontSize.size16, textColor: Color.appWhite)
        buttonCancel.style(fontType: FontType.GoldplaySemiBold, fontSize: .size15, textColor: Color.appBlue1)
        labelVerificationSucessful.style(fontType: FontType.GoldplayMedium, fontSize: .size17, textColor: Color.appDarkGray)
        labelEmailSucessfulVerify.style(fontType: FontType.GoldplayMedium, fontSize: .size17, textColor: Color.appDarkGray)
        
    case .delete:
        buttonOk.setTitle("YES", for: .normal)
        buttonCancel.setTitle("NO", for: .normal)
        imageOkTick.image = UIImage(named: "account-deletePopUp")
        labelVerificationSucessful.text = "Are you sure you want to delete the \nAccount? This action can not\n be undone."
        labelEmailSucessfulVerify.isHidden = true
        buttonOk.style(fontType: FontType.GoldplaySemiBold, fontSize: FontSize.size16, textColor: Color.appWhite)
        buttonCancel.style(fontType: FontType.GoldplaySemiBold, fontSize: .size18, textColor: Color.appDarkGrayColor)
        labelVerificationSucessful.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appLightBlacks)
        
    case .defaults:
        labelEmailSucessfulVerify.text = "Email successfully\nverified."
        labelVerificationSucessful.style(fontType: FontType.GoldplayBold, fontSize: .size18, textColor: Color.appDarkGray)
        labelEmailSucessfulVerify.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appDarkGray)
        buttonOk.style(fontType: FontType.GoldplaySemiBold, fontSize: FontSize.size16, textColor: Color.appWhite)
    }
    }
}

