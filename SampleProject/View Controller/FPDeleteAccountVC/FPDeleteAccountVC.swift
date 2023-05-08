//
//  FPDeleteAccountVC.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 22/07/22.
//

import UIKit
import SwiftUI

class FPDeleteAccountVC: UIViewController {

    @IBOutlet weak var buttonDeleteAc: UIButton!
    @IBOutlet weak var textFieldPassword: CustomLeftPaddingTextField!
    @IBOutlet weak var labelPasswordTop: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelConfirmUrAc: UILabel!
    @IBOutlet weak var viewInternal: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var labelDeleteAccount: UILabel!
    @IBAction func buttonBack(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupapperence()

        NotificationCenter.default.addObserver(self, selector: #selector(self.showHidePassword), name: Notification.Name("NotificationIdentifier"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    func setupapperence(){
        textFieldPassword.layer.cornerRadius = textFieldPassword.layer.frame.height/12
        labelDeleteAccount.style(fontType: .GoldplaySemiBold, fontSize: .size20, textColor: Color.appWhite)
        labelConfirmUrAc.style(fontType: .GoldplayBold, fontSize: .size18, textColor: Color.appLightBlacks)
        labelDescription.style(fontType: .GoldplayMedium, fontSize: .size15, textColor: Color.appLightBlacks)
        labelPasswordTop.style(fontType: .GoldplayMedium, fontSize: .size15, textColor: Color.appLightBlacks)
        textFieldPassword.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appBlack, backgroundColor: Color.appLightGray1, placeholderColor: Color.appDarkGray.withAlphaComponent(0.6))
        textFieldPassword.setAttributedPlaceholder(placeHolder: "Enter Password", color: Color.appDarkGray.withAlphaComponent(0.6), font: UIFont.systemFont(ofSize: 15))
        buttonDeleteAc.style(fontType: .GoldplaySemiBold, fontSize: .size16, textColor: Color.appWhite)
        textFieldPassword.setRightView1(imageName: "eyeicon", tag: 1)
        textFieldPassword.isSecureTextEntry = true
        scrollView.layer.cornerRadius = scrollView.frame.height/45
        scrollView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        labelConfirmUrAc.text = "Confirm that this is your Account"
        labelDescription.text = "Before you permanently delete your Account,\nplease enter your password."

    }
    
    @objc func showHidePassword(_ notification:Notification) {
        
        if let userInfo = notification.userInfo as? [String:Any] {
            
            if let tag = userInfo["tag"] as? Int {
                
                if tag == 1 {
                    
                    textFieldPassword.isSecureTextEntry.toggle()
                    if  textFieldPassword.isSecureTextEntry == true{
                        textFieldPassword.setRightView1(imageName: "eyeicon", tag: 1)
                    }
                    else {
                        textFieldPassword.setRightView1(imageName: "eyegreenicon", tag: 1)
                    }
                }
            }
        }
    }
}

