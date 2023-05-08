//
//  FPLoginVC.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 18/01/22.
//

import UIKit
import SwiftUI
import IQKeyboardManagerSwift
import AuthenticationServices
import Kingfisher

class FPLoginVC: UIViewController {

    @IBOutlet weak var buttonForgotPassword: UIButton!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var labelPassword: UILabel!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelLogin: UILabel!
    @IBOutlet weak var labelWelcomeToFP: UILabel!
    @IBOutlet weak var viewContectView: UIView!
    @IBOutlet weak var viewScrollView: UIScrollView!
    @IBOutlet weak var labelLoginAccount: UILabel!
    @IBOutlet weak var viewLeftOrlogin: UIView!
    @IBOutlet weak var labelOrLoginUsing: UILabel!
    @IBOutlet weak var buttonSignUp: UIButton!
    @IBOutlet weak var labelDontHaveAccount: UILabel!
    @IBOutlet weak var buttonFacebook: UIButton!
    @IBOutlet weak var buttonApple: UIButton!
    @IBOutlet weak var labelEmailIsIncorrect: UILabel!
    @IBOutlet weak var labelPasswordIncorrect: UILabel!
    
    var dict = [String:Any]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupApperance()
        if #available(iOS 13.0, *) {
            buttonApple.isHidden = false

        } else {
            // Fallback on earlier versions
            buttonApple.isHidden = true
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.showHidePassword), name: Notification.Name("NotificationIdentifier"), object: nil)
        textFieldEmail.delegate = self
        textFieldPassword.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func setupApperance() {
        
        [textFieldEmail,textFieldPassword].forEach({ view in
            
            view?.layer.cornerRadius = (view?.frame.height ?? 0.0)/13
            
        })
        labelEmailIsIncorrect.isHidden = true
        labelPasswordIncorrect.isHidden = true
        
        [viewLeftOrlogin].forEach({ view in
            
            view?.backgroundColor = Color.appBlack.withAlphaComponent(0.10)
        })
        
        buttonForgotPassword.style(fontType: FontType.GoldplayMedium, fontSize: .size14, textColor: Color.appBlue)
        buttonLogin.style(fontType: FontType.GoldplaySemiBold, fontSize: .size16, textColor: Color.appWhite)
        buttonSignUp.style(fontType: FontType.GoldplaySemiBold, fontSize: .size15, textColor: Color.appBlue)
        labelEmail.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appDarkGray)
        labelPassword.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appDarkGray)
        labelLogin.style(fontType: FontType.GoldplaySemiBold, fontSize: .size32, textColor: Color.appWhite)
        labelWelcomeToFP.style(fontType: FontType.GoldplayRegular, fontSize: .size18, textColor: Color.appWhite)
        labelLoginAccount.style(fontType: FontType.GoldplayRegular, fontSize: .size18, textColor: Color.appWhite)
        labelOrLoginUsing.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appDarkGray,backgroundColor: Color.appWhite)
        labelDontHaveAccount.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appDarkGray)
        textFieldEmail.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appDarkGray, backgroundColor: Color.appLightGray1, placeholderColor: Color.appDarkGray)
        textFieldPassword.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appBlack, backgroundColor: Color.appLightGray1, placeholderColor: Color.appDarkGray)
        //textFieldEmail.setLeftPaddingPoints(20)
        //textFieldPassword.setLeftPaddingPoints(20)
        //*************************************************
       // textFieldEmail.addTarget(self, action: #selector(textFieldEmailEditingChange), for: .editingChanged)
        //textFieldPassword.addTarget(self, action: #selector(textFieldPasswordEditingChange), for: .editingChanged)
        //**************************************************
        //labelEmailIsIncorrect.style(fontType: FontType.segoeUI, fontSize: .size15, textColor: Color.appRed)
        //labelPasswordIncorrect.style(fontType: FontType.segoeUI, fontSize: .size15, textColor: Color.appRed)
        textFieldEmail.setAttributedPlaceholder(placeHolder: "Enter Email", color: Color.appDarkGray.withAlphaComponent(0.6), font: UIFont.systemFont(ofSize: 15))
        textFieldPassword.setAttributedPlaceholder(placeHolder: "Enter Password", color: Color.appDarkGray.withAlphaComponent(0.6), font: UIFont.systemFont(ofSize: 15))
        textFieldPassword.setRightView1(imageName: "eyeicon", tag: 2)
        textFieldPassword.isSecureTextEntry = true
        
        // set underline for text
        
        let FormattedText = NSMutableAttributedString()
        FormattedText
            // .normal("Signup")
            .bold("Sign up")
        buttonSignUp.titleLabel?.attributedText = FormattedText
        
        viewScrollView.layer.cornerRadius = viewScrollView.frame.height/45
        viewScrollView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    @objc func showHidePassword(_ notification:Notification) {
        
        if let userInfo = notification.userInfo as? [String:Any] {
            
            if let tag = userInfo["tag"] as? Int {
                
                if tag == 2 {
                    
                    textFieldPassword.isSecureTextEntry.toggle()
                    if  textFieldPassword.isSecureTextEntry == true{
                        textFieldPassword.setRightView1(imageName: "eyeicon", tag: 2)
                    }
                    else {
                        textFieldPassword.setRightView1(imageName: "eyegreenicon", tag: 2)
                    }
                }
            
            }
        }
    }

}

struct CommonResponse: Decodable {
    let status: Int
    let message: String
}
