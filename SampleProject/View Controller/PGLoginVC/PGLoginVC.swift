//
//  PGLoginVC.swift
//  SampleProject
//
//  Created by RAVI K GUPTA on 04/01/22.
//

import UIKit

class PGLoginVC: UIViewController {
    
    @IBOutlet weak var labelLoginToContine: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelPassword: UILabel!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var buttonForgotPassword: UIButton!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var viewBackgroundEmail: UIView!
    @IBOutlet weak var viewBackgroundPassword: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupApperance()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        [viewBackgroundEmail,viewBackgroundPassword,buttonLogin].forEach({ view in
            
            view?.layer.cornerRadius = (view?.frame.height ?? 0.0)/2
        })
        
    }

    func setupApperance() {
        
        [viewBackgroundEmail,viewBackgroundPassword].forEach({ view in
            
            view?.setShadow()
        })
        
        textFieldEmail.setLeftView(imageName: "email")
        textFieldPassword.setLeftView(imageName: "Password")
        textFieldEmail.borderStyle = .none
        textFieldPassword.borderStyle = .none
        textFieldEmail.style(fontType:FontType.GoldplayRegular, fontSize: .size15, textColor: Color.applightBlue, textStyle: .subheadline, placeholderColor: Color.appGray)
        textFieldPassword.style(fontType:FontType.GoldplayRegular, fontSize: .size15, textColor: Color.applightBlue, placeholderColor: Color.appGray)
        labelLoginToContine.style(fontType:FontType.GoldplaySemiBold, fontSize: .size20, textColor: Color.appBlack)
        labelEmail.style(fontType:FontType.GoldplaySemiBold, fontSize: .size16, textColor: Color.appLightBlack)
        labelPassword.style(fontType:FontType.GoldplaySemiBold, fontSize: .size16, textColor: Color.appLightBlack)
        
        buttonForgotPassword.style(fontType:FontType.GoldplaySemiBold, fontSize: .size13, textColor: Color.applightBlue)
        
        buttonLogin.style(fontType: FontType.GoldplaySemiBold, fontSize: .size16, textColor: Color.appWhite, textStyle: .callout, backgroundColor: Color.applightBlue)
        buttonLogin.contentEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        textFieldEmail.keyboardType = .emailAddress
        textFieldPassword.isSecureTextEntry = true

    }
    
    
}
