//
//  FPForgotPasswordVC.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 21/01/22.
//

import UIKit
import Kingfisher

class FPForgotPasswordVC: UIViewController {

    @IBOutlet weak var labelEnterRegisterdEmail: UILabel!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var buttonVerify: UIButton!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelIncorrectEmail: UILabel!
    @IBOutlet weak var viewScrollView: UIScrollView!
    @IBOutlet weak var buttonBackArrow: UIButton!
    @IBOutlet weak var labelForgotPassword: UILabel!
   
    var passwordTokens = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
        setupApperance()
        textFieldEmail.delegate = self
        labelIncorrectEmail.isHidden = true
       
        // Do any additional setup after loading the view.
    }
    
    
    func setupApperance() {
        
        [textFieldEmail].forEach({ view in
            
            view?.layer.cornerRadius = (view?.frame.height ?? 0.0)/13
        })
        labelForgotPassword.text = "FORGOT\nPASSWORD"

        buttonVerify.style(fontType: FontType.GoldplaySemiBold, fontSize: .size16, textColor: Color.appWhite)
        labelForgotPassword.style(fontType: FontType.GoldplaySemiBold, fontSize: .size32, textColor: Color.appWhite)
        labelEnterRegisterdEmail.style(fontType: FontType.GoldplayMedium, fontSize: .size18, textColor: Color.appWhite)
        labelEmail.style(fontType: FontType.GoldplayMedium, fontSize: .size18, textColor: Color.appDarkGray)
       // labelIncorrectEmail.style(fontType: FontType.segoeUI, fontSize: .size15, textColor: Color.appRed)
       // textFieldEmail.addTarget(self, action: #selector(textFieldEmailEditingChange), for: .editingChanged)
        textFieldEmail.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appDarkGray, backgroundColor: Color.appLightGray1, placeholderColor: Color.appDarkGray)
        textFieldEmail.setAttributedPlaceholder(placeHolder: "Enter Email", color: Color.appDarkGray.withAlphaComponent(0.6), font: UIFont.systemFont(ofSize: 15))
        // labelForgotPassword.numberOfLines = 2
        
        
        viewScrollView.layer.cornerRadius = viewScrollView.frame.height/45
        viewScrollView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
     }

}
