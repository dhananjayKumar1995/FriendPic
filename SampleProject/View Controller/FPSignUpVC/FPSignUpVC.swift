//
//  FPSignUpVC.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 19/01/22.
//

import UIKit
import SwiftUI
import IQKeyboardManagerSwift

class FPSignUpVC: UIViewController {

    @IBOutlet weak var termConditionTextView: GrowingTextView!
    @IBOutlet weak var buttonCheck: UIButton!
    @IBOutlet weak var labelCreateYourAccount: UILabel!
    @IBOutlet weak var labelSignUp: UILabel!
    @IBOutlet weak var viewContentView: UIView!
    @IBOutlet weak var viewScrollView: UIScrollView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var labelPassword: UILabel!
    @IBOutlet weak var labelReEnterPassword: UILabel!
    @IBOutlet weak var buttonVerify: UIButton!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var labelAlreadyHaveAccount: UILabel!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var textFieldReEnterPassword: UITextField!
    @IBOutlet weak var labelIncorrectName: UILabel!
    @IBOutlet weak var labelIncorrectEmail: UILabel!
    @IBOutlet weak var labelIncorrectPassword: UILabel!
    @IBOutlet weak var labelIncorrectReEncorrectPassword: UILabel!
    @IBOutlet weak var buttonBackArrow: UIButton!
    
    var isTapped:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupApperance()
        setupTextView()
        buttonCheck.setImage(UIImage(named: "unselected_checkbox"), for: .normal)
        NotificationCenter.default.addObserver(self, selector: #selector(self.showHidePassword), name: Notification.Name("NotificationIdentifier"), object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
          //  NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    
        // Do any additional setup after loading the view.
        textFieldName.delegate = self
        textFieldReEnterPassword.delegate = self
        textFieldEmail.delegate = self
        textFieldPassword.delegate = self
    }
    
   
    @IBAction func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @IBAction func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

   func setupApperance() {
       
       [textFieldName,textFieldEmail,textFieldPassword,textFieldReEnterPassword].forEach({ view in
           
           view?.layer.cornerRadius = (view?.frame.height ?? 0.0)/13
       })
        
//       let text = NSMutableAttributedString()
//       text.append(NSAttributedString(string: "I accept the ", attributes: [NSAttributedString.Key.foregroundColor: Color.appLightBlack,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 13.0)]));
//       text.append(NSAttributedString(string: "Terms and Conditions & Privacy Policy", attributes: [NSAttributedString.Key.foregroundColor: Color.appLightBlack,NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 13.0)]))
//       labelTermAndCondition.attributedText = text
       buttonLogin.style(fontType: FontType.GoldplaySemiBold, fontSize: .size15, textColor: Color.appBlue1)
       buttonVerify.style(fontType: FontType.GoldplaySemiBold, fontSize: .size16, textColor: Color.appWhite)
       labelAlreadyHaveAccount.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appDarkGray)
       labelSignUp.style(fontType: FontType.GoldplaySemiBold, fontSize: .size32, textColor: Color.appWhite)
       labelCreateYourAccount.style(fontType: FontType.GoldplayRegular, fontSize: .size18, textColor: Color.appWhite)
       labelEmail.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appDarkGray)
       labelPassword.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appDarkGray)
       labelName.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appDarkGray)
       labelReEnterPassword.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appDarkGray)
       textFieldEmail.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appDarkGray, backgroundColor: Color.appLightGray1, placeholderColor: Color.appDarkGray)
       textFieldPassword.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appDarkGray, backgroundColor: Color.appLightGray1, placeholderColor: Color.appDarkGray)
       textFieldName.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appDarkGray, backgroundColor: Color.appLightGray1, placeholderColor: Color.appDarkGray)
       textFieldReEnterPassword.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appDarkGray, backgroundColor: Color.appLightGray1, placeholderColor: Color.appDarkGray)
       textFieldName.setAttributedPlaceholder(placeHolder: "Enter Name", color: Color.appDarkGray.withAlphaComponent(0.6), font: UIFont.systemFont(ofSize: 15))
       textFieldEmail.setAttributedPlaceholder(placeHolder: "Enter Email", color: Color.appDarkGray.withAlphaComponent(0.6), font: UIFont.systemFont(ofSize: 15))
       textFieldPassword.setAttributedPlaceholder(placeHolder: "Enter Password", color: Color.appDarkGray.withAlphaComponent(0.6), font: UIFont.systemFont(ofSize: 15))
       textFieldReEnterPassword.setAttributedPlaceholder(placeHolder: "Re-Enter Password", color: Color.appDarkGray.withAlphaComponent(0.6), font: UIFont.systemFont(ofSize: 15))
       textFieldPassword.setRightView1(imageName: "eyeicon", tag: 0)
       textFieldReEnterPassword.setRightView1(imageName: "eyeicon", tag: 1)
      
       
       //**********************************************************
//       labelIncorrectName.style(fontType: FontType.segoeUI, fontSize: .size15, textColor: Color.appRed)
//       labelIncorrectEmail.style(fontType: FontType.segoeUI, fontSize: .size15, textColor: Color.appRed)
//       labelIncorrectPassword.style(fontType: FontType.segoeUI, fontSize: .size15, textColor: Color.appRed)
//       labelIncorrectReEncorrectPassword.style(fontType: FontType.segoeUI, fontSize: .size15, textColor: Color.appRed)
//
//       textFieldName.addTarget(self, action: #selector(textFieldNameEditingChange), for: .editingChanged)
//       textFieldEmail.addTarget(self, action: #selector(textFieldEmailEditingChange), for: .editingChanged)
//       textFieldPassword.addTarget(self, action: #selector(textFieldPasswordEditingChange), for: .editingChanged)
//       textFieldReEnterPassword.addTarget(self, action: #selector(textFieldReEnterPasswordEditingChange), for: .editingChanged)
       //**********************************************************
       
       textFieldPassword.isSecureTextEntry = true
       textFieldReEnterPassword.isSecureTextEntry = true
       labelIncorrectName.isHidden = true
       labelIncorrectEmail.isHidden = true
       labelIncorrectPassword.isHidden = true
       labelIncorrectReEncorrectPassword.isHidden = true
       

       // set underline for text
       let FormattedText = NSMutableAttributedString()
       FormattedText
           // .normal("Signup")
           .bold("Log in")
       
       buttonLogin.titleLabel?.attributedText = FormattedText
       
       viewScrollView.layer.cornerRadius = viewScrollView.frame.height/45
       viewScrollView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
   
    @objc func showHidePassword(_ notification:Notification) {
        if let userInfo = notification.userInfo as? [String:Any] {
            
            if let tag = userInfo["tag"] as? Int {
                
                if tag == 0 {
                    textFieldPassword.isSecureTextEntry.toggle()
                    if  textFieldPassword.isSecureTextEntry == true{
                        textFieldPassword.setRightView1(imageName: "eyeicon", tag: 0)
                    }
                    else {
                        textFieldPassword.setRightView1(imageName: "eyegreenicon", tag: 0)
                    }
                }
                else {
                    
                     textFieldReEnterPassword.isSecureTextEntry.toggle()
              
                    if  textFieldReEnterPassword.isSecureTextEntry == true{
                        textFieldReEnterPassword.setRightView1(imageName: "eyeicon", tag: 1)
                    }
                    else {
                        textFieldReEnterPassword.setRightView1(imageName: "eyegreenicon", tag: 1)
                    }
                }
            }
        }
    }
}
//MARK:- POP UP DELEGATE to show popup
extension FPSignUpVC:PopUpDelegate{

    
    func handleAction1(action: Bool,passwordToken: String) {
        FPSignUpVC.showOkPopup(parentVC: self)
    }
    
    func handleAction2(action: Bool) {
        if action{
           // kAppDelegate.checkToLoadScreen()
            let goToNextScreen = storyboard?.instantiateViewController(withIdentifier: "FPTabBarVC")as! FPTabBarVC

            self.navigationController?.pushViewController(goToNextScreen, animated: true)
        }
    }
    
    //MARK:- TO SET TERM CONDITION and PRIVACY POLICY CALLING FROM VIEW DID LOAD
    func setupTextView(){
        termConditionTextView.text = "I accept the Terms and Conditions & Privacy Policy."
           let text = termConditionTextView.text ?? ""
           let termText = "Terms and Conditions"
           let policyText = "Privacy Policy."
        let attributedString = NSMutableAttributedString(string: text)
        //REGULAR TEXT
           attributedString.addAttributes([NSAttributedString.Key.font: DynamicFont.font(type: FontType.GoldplayRegular, size: .size13, textStyle: .subheadline), NSAttributedString.Key.foregroundColor: Color.appBlack], range: NSString(string: text).range(of: text))
        
        //ATTRIBUTED TEXT
           attributedString.addAttributes([NSAttributedString.Key.font: DynamicFont.font(type: FontType.GoldplaySemiBold, size: .size14, textStyle: .subheadline), NSAttributedString.Key.foregroundColor: Color.appBlack], range: NSString(string: text).range(of: termText))
        
        //ATTRIBUTED TEXT
           attributedString.addAttributes([NSAttributedString.Key.font: DynamicFont.font(type: FontType.GoldplaySemiBold, size: .size14, textStyle: .subheadline), NSAttributedString.Key.foregroundColor: Color.appBlack], range: NSString(string: text).range(of: policyText))
        
           attributedString.addAttributes([.link: "http://35.154.184.209/terms-and-conditions"], range: NSString(string: text).range(of: termText))
           attributedString.addAttributes([.link: "http://35.154.184.209/privacy-policy"], range: NSString(string: text).range(of: policyText))
           attributedString.addAttributes([NSAttributedString.Key.underlineStyle: 0, NSAttributedString.Key.underlineColor: Color.appBlack], range: NSString(string: text).range(of: termText))
           attributedString.addAttributes([NSAttributedString.Key.underlineStyle: 0, NSAttributedString.Key.underlineColor: Color.appBlack], range: NSString(string: text).range(of: policyText))

        termConditionTextView.attributedText = attributedString
        termConditionTextView.isUserInteractionEnabled = true
        termConditionTextView.isEditable = false
        termConditionTextView.adjustsFontForContentSizeCategory = true
        termConditionTextView.linkTextAttributes = [NSAttributedString.Key.foregroundColor: Color.appBlack]
        termConditionTextView.dataDetectorTypes = UIDataDetectorTypes.link
        termConditionTextView.isSelectable = true
        //termConditionTextView.isScrollEnabled = false
        termConditionTextView.delegate = self
           
       }
}

//MARK: - TEXTVIEW DELEGATE
extension FPSignUpVC:UITextViewDelegate{
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {

       return true
   }
  
       func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
           
           let vc = FPTermConditionVC.instantiate(fromAppStoryboard: .registration)
           
           if URL.absoluteString == urlType.termsCondition {
               
               vc.currentState = .termsAndCondition
              
           }else if URL.absoluteString == urlType.privacyPolicy {
               
               vc.currentState = .privacyPolicy
           }
           
           navigationController?.pushViewController(vc, animated: true)
           return false
       }
}
