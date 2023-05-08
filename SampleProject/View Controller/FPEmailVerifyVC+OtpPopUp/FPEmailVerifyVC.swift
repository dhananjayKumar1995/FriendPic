//
//  FPEmailVerifyVC.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 27/01/22.
//

import UIKit
import SVPinView
//import IQKeyboardManagerSwift

class FPEmailVerifyVC: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var labelIncorrectOTP: UILabel!
    @IBOutlet weak var labelDidNotReceiveCode: UILabel!
    @IBOutlet weak var buttonResend: UIButton!
    
    @IBOutlet weak var buttonCross: UIButton!
    @IBOutlet weak var ViewOTP: SVPinView!
    @IBOutlet weak var buttonConfirm: UIButton!
    @IBOutlet weak var labelEnterFourDigitCodeToVerifyEmail: UILabel!
    @IBOutlet weak var labelEmailVerification: UILabel!
    @IBOutlet weak var viewPopupDialogBox: UIView!
    
    //MARK:- VARIABLES
    var fromForgotPassword = false
    var email = ""
    var enterOtp = ""
    var delegate : PopUpDelegate?
    var countDown = 30
    var timer:Timer?
    //mark:- viewdid load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        otpFieldSetUp()
        setupApperence()
        otpField()
        hideKeyboardWhenTappedAround()
        labelIncorrectOTP.isHidden = true
        
        labelDidNotReceiveCode.text = "Resend OTP in "
        buttonResend.setTitle("00:\(countDown)", for: .normal)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
        
    }

    @objc func update() {
        
        if countDown == 0 {
            buttonResend.isUserInteractionEnabled = true
            let FormattedText = NSMutableAttributedString()
            FormattedText
            // .normal("Signup")
                .bold("Resend")
            buttonResend.titleLabel?.attributedText = FormattedText
        }
        else {
            buttonResend.isUserInteractionEnabled = false
        }
        
        if countDown == 0 {
            buttonResend.isUserInteractionEnabled = true
            buttonResend.setTitle("Resend", for: .normal)
            labelDidNotReceiveCode.text = "Didn't receive code? "
            timer?.invalidate()
            timer = nil
            return
        }
        countDown -= 1
        labelDidNotReceiveCode.text = "Resend OTP in "
        if countDown < 10 {
            
            buttonResend.setTitle("00:0\(countDown)", for: .normal)
        }
        else {
            buttonResend.setTitle("00:\(countDown)", for: .normal)
        }
    }
    
    //MARK:- OTPFIELD SET UP
    func otpFieldSetUp() {
        ViewOTP.style = .box
        ViewOTP.fieldBackgroundColor = Color.appLightGray1
        ViewOTP.activeFieldBackgroundColor = Color.appLightGray1
        // ViewOTP.borderLineColor = UIColor.darkGray
        // ViewOTP.activeBorderLineColor = UIColor.green
        ViewOTP.fieldCornerRadius = 5
        ViewOTP.activeFieldCornerRadius = 5
        ViewOTP.activeBorderLineThickness = 1
        ViewOTP.borderLineThickness = 0
        ViewOTP.activeBorderLineThickness = 0
        ViewOTP.interSpace = 12
        ViewOTP.keyboardType = .numberPad
        //ViewOTP = FontType.segoeUISemibold
        // ViewOTP.font = FontSize.size18
        ViewOTP.becomeFirstResponderAtIndex = 0
        ViewOTP.font = UIFont.boldSystemFont(ofSize: 20)
        
    }
    
    func setupApperence() {
        
        buttonConfirm.style(fontType: FontType.GoldplaySemiBold, fontSize: .size16, textColor: Color.appWhite)
        buttonResend.style(fontType: FontType.GoldplaySemiBold, fontSize: .size15, textColor: Color.appBlue1)
        labelEmailVerification.style(fontType: FontType.GoldplayBold, fontSize: .size18, textColor: Color.appDarkGray)
        labelEnterFourDigitCodeToVerifyEmail.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appDarkGray)
        labelDidNotReceiveCode.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appDarkGray)
        viewPopupDialogBox.layer.cornerRadius = viewPopupDialogBox.layer.frame.size.height/20
        
        //NSATTRIBUTED STRING
        let yourAttributes = [NSAttributedString.Key.foregroundColor: Color.appDarkGray, NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15)]
        //UIFont.systemFont(ofSize: 18)
        let yourOtherAttributes = [NSAttributedString.Key.foregroundColor: Color.appDarkGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]

        let partOne = NSMutableAttributedString(string: "Enter four digit code to verify your email\n address sent to ", attributes: yourAttributes)
        let partTwo = NSMutableAttributedString(string: email, attributes: yourOtherAttributes)

        partOne.append(partTwo)
        labelEnterFourDigitCodeToVerifyEmail.attributedText = partOne
       
    }
    
    // MARK:- OTP WORKING METHOD
    func otpField() {
        ViewOTP.didFinishCallback = { [weak self] pin in
            print("The pin entered is: \(pin)")
            self!.enterOtp = pin
        }
        ViewOTP.didChangeCallback = { [weak self] pin in
            self!.enterOtp = pin
        }
    }
    
    //MARK:- TextField Should Return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        ViewOTP.resignFirstResponder()
        return true
        
    }
}
