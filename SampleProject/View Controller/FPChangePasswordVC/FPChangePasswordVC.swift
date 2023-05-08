//
//  FPChangePasswordVC.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 16/02/22.
//

import UIKit

class FPChangePasswordVC: UIViewController {

    @IBOutlet weak var labelNewPassword: UILabel!
    @IBOutlet weak var textFieldCurrentPassword: CustomLeftPaddingTextField!
    @IBOutlet weak var labelConfirmNewPassword: UILabel!
    @IBOutlet weak var textfieldConfirmNewPassword: CustomLeftPaddingTextField!
    @IBOutlet weak var textfieldNewPassword: CustomLeftPaddingTextField!
    @IBOutlet weak var buttonSubmit: UIButton!
    @IBOutlet weak var labelCurrentPassword: UILabel!
    @IBOutlet weak var viewInternal: UIView!
    @IBOutlet weak var viewScrollView: UIScrollView!
    @IBOutlet weak var labelChangePassword: UILabel!
    @IBOutlet weak var buttonBack: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
        setupApperance()
        NotificationCenter.default.addObserver(self, selector: #selector(self.showHidePassword), name: Notification.Name("NotificationIdentifier"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    
    func setupApperance() {
        
        [textFieldCurrentPassword,textfieldNewPassword,textfieldConfirmNewPassword].forEach({ view in
            
            view?.layer.cornerRadius = (view?.frame.height ?? 0.0)/13
        })
       
        buttonSubmit.style(fontType: FontType.GoldplaySemiBold, fontSize: .size16, textColor: Color.appWhite)
        labelNewPassword.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appDarkGray)
        labelCurrentPassword.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appDarkGray)
        labelConfirmNewPassword.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appDarkGray)
        labelChangePassword.style(fontType: FontType.GoldplaySemiBold, fontSize: .size20, textColor: Color.appWhite)
        textFieldCurrentPassword.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appBlack, backgroundColor: Color.appLightGray1, placeholderColor: Color.appDarkGray.withAlphaComponent(0.6))
        textfieldNewPassword.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appBlack, backgroundColor: Color.appLightGray1, placeholderColor: Color.appDarkGray.withAlphaComponent(0.6))
        textfieldConfirmNewPassword.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appBlack, backgroundColor: Color.appLightGray1, placeholderColor: Color.appDarkGray.withAlphaComponent(0.6))
        
        textFieldCurrentPassword.setAttributedPlaceholder(placeHolder: "Enter Password", color: Color.appDarkGray.withAlphaComponent(0.6), font: UIFont.systemFont(ofSize: 15))
        textfieldNewPassword.setAttributedPlaceholder(placeHolder: "Enter Password", color: Color.appDarkGray.withAlphaComponent(0.6), font: UIFont.systemFont(ofSize: 15))
        textfieldConfirmNewPassword.setAttributedPlaceholder(placeHolder: "Enter Password", color: Color.appDarkGray.withAlphaComponent(0.6), font: UIFont.systemFont(ofSize: 15))
        viewScrollView.layer.cornerRadius = viewScrollView.frame.height/45
        viewScrollView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        textFieldCurrentPassword.setRightView1(imageName: "eyeicon", tag: 1)
        textFieldCurrentPassword.isSecureTextEntry = true
        textfieldNewPassword.setRightView1(imageName: "eyeicon", tag: 2)
        textfieldNewPassword.isSecureTextEntry = true
        textfieldConfirmNewPassword.setRightView1(imageName: "eyeicon", tag: 3)
        textfieldConfirmNewPassword.isSecureTextEntry = true
    }
    
    @objc func showHidePassword(_ notification:Notification) {
        
        if let userInfo = notification.userInfo as? [String:Any] {
            
            if let tag = userInfo["tag"] as? Int {
                
                if tag == 1 {
                    
                    textFieldCurrentPassword.isSecureTextEntry.toggle()
                    if  textFieldCurrentPassword.isSecureTextEntry == true{
                        textFieldCurrentPassword.setRightView1(imageName: "eyeicon", tag: 1)
                    }
                    else {
                        textFieldCurrentPassword.setRightView1(imageName: "eyegreenicon", tag: 1)
                    }
                }
                else if tag == 2{
                    
                    textfieldNewPassword.isSecureTextEntry.toggle()
                    if  textfieldNewPassword.isSecureTextEntry == true{
                        textfieldNewPassword.setRightView1(imageName: "eyeicon", tag: 2)
                    }
                    else {
                        textfieldNewPassword.setRightView1(imageName: "eyegreenicon", tag: 2)
                    }
                    
                }
                else {
                    
                    textfieldConfirmNewPassword.isSecureTextEntry.toggle()
                    if  textfieldConfirmNewPassword.isSecureTextEntry == true{
                        textfieldConfirmNewPassword.setRightView1(imageName: "eyeicon", tag: 3)
                    }
                    else {
                        textfieldConfirmNewPassword.setRightView1(imageName: "eyegreenicon", tag: 3)
                    }
                    
                }
            
            }
        }
    }
    
}
