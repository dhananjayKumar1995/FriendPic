//
//  FPResetPasswordVC.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 25/01/22.
//

import UIKit
import Kingfisher
import SVPinView
class FPResetPasswordVC: UIViewController {
    @IBOutlet weak var labelResetPassword: UILabel!
    @IBOutlet weak var labelIncorrectPassword: UILabel!
    @IBOutlet weak var labelReEnterPassword: UILabel!
    @IBOutlet weak var textfieldPassword: UITextField!
    @IBOutlet weak var textfieldReEnterPassword: UITextField!
    @IBOutlet weak var buttonSubmit: UIButton!
    @IBOutlet weak var labelIncorrectReEnterPassword: UILabel!
    @IBOutlet weak var stackViewOTP: UIStackView!
    @IBOutlet weak var labelPassword: UILabel!
    @IBOutlet weak var viewScrollView: UIScrollView!
    @IBOutlet weak var labelEnterRegisEmail: UILabel!
    @IBOutlet weak var buttonBackArrow: UIButton!
    @IBOutlet weak var textfieldOtp: CustomLeftPaddingTextField!
    @IBOutlet weak var labelOtp: UILabel!
    
    
    var email = ""
    var otp = ""
    var passwordToken = ""
  
    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
        setupApperance()
        labelEnterRegisEmail.isHidden = true
        stackViewOTP.isHidden = true
        textfieldPassword.delegate = self
        textfieldReEnterPassword.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.showHidePassword), name: Notification.Name("NotificationIdentifier"), object: nil)
        
        // Do any additional setup after loading the view.
    }
  
   
    func setupApperance() {
        
        [textfieldOtp,textfieldPassword,textfieldReEnterPassword].forEach({ view in
            
            view?.layer.cornerRadius = (view?.frame.height ?? 0.0)/13
        })
        labelIncorrectPassword.isHidden = true
        labelIncorrectReEnterPassword.isHidden = true
        labelResetPassword.text = "RESET\nPASSWORD"
        
        buttonSubmit.style(fontType: FontType.GoldplaySemiBold, fontSize: .size16, textColor: Color.appWhite)
        labelOtp.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appDarkGray)
        labelPassword.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appDarkGray)
        labelIncorrectPassword.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appDarkGray)
        labelReEnterPassword.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appDarkGray)
        labelIncorrectReEnterPassword.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appDarkGray)
        labelResetPassword.style(fontType: FontType.GoldplaySemiBold, fontSize: .size32, textColor: Color.appWhite)
        labelEnterRegisEmail.style(fontType: FontType.GoldplayMedium, fontSize: .size18, textColor: Color.appWhite)
        textfieldOtp.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appDarkGray, backgroundColor: Color.appLightGray1, placeholderColor: Color.appDarkGray)
        textfieldPassword.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appDarkGray, backgroundColor: Color.appLightGray1, placeholderColor: Color.appDarkGray)
        textfieldReEnterPassword.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appDarkGray, backgroundColor: Color.appLightGray1, placeholderColor: Color.appDarkGray)
       // labelIncorrectPassword.style(fontType: FontType.segoeUI, fontSize: .size15, textColor: Color.appRed)
       // labelIncorrectReEnterPassword.style(fontType: FontType.segoeUI, fontSize: .size15, textColor: Color.appRed)
       //textfieldPassword.addTarget(self, action: #selector(textFieldPasswordEditingChange), for: .editingChanged)
       // textfieldReEnterPassword.addTarget(self, action: #selector(textFieldReEnterPasswordEditingChange), for: .editingChanged)
        textfieldOtp.setAttributedPlaceholder(placeHolder: "Enter Otp", color: Color.appDarkGray.withAlphaComponent(0.6), font: UIFont.systemFont(ofSize: 15))
        textfieldPassword.setAttributedPlaceholder(placeHolder: "Enter Password", color: Color.appDarkGray.withAlphaComponent(0.6), font: UIFont.systemFont(ofSize: 15))
        textfieldReEnterPassword.setAttributedPlaceholder(placeHolder: "Re-Enter Password", color: Color.appDarkGray.withAlphaComponent(0.6), font: UIFont.systemFont(ofSize: 15))
        viewScrollView.layer.cornerRadius = viewScrollView.frame.height/45
        viewScrollView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        textfieldPassword.setRightView1(imageName: "eyeicon", tag: 3)
        textfieldPassword.isSecureTextEntry = true
        textfieldReEnterPassword.setRightView1(imageName: "eyeicon", tag: 4)
        textfieldReEnterPassword.isSecureTextEntry = true
    }
    
    @objc func showHidePassword(_ notification:Notification) {
        
        if let userInfo = notification.userInfo as? [String:Any] {
            
            if let tag = userInfo["tag"] as? Int {
                
                if tag == 3 {
                    
                    textfieldPassword.isSecureTextEntry.toggle()
                    if  textfieldPassword.isSecureTextEntry == true{
                        textfieldPassword.setRightView1(imageName: "eyeicon", tag: 3)
                    }
                    else {
                        textfieldPassword.setRightView1(imageName: "eyegreenicon", tag: 3)
                    }
                }
                else {
                    
                    textfieldReEnterPassword.isSecureTextEntry.toggle()
                    if  textfieldReEnterPassword.isSecureTextEntry == true{
                        textfieldReEnterPassword.setRightView1(imageName: "eyeicon", tag: 4)
                    }
                    else {
                        textfieldReEnterPassword.setRightView1(imageName: "eyegreenicon", tag: 4)
                    }
                    
                }
            
            }
        }
    }
}
