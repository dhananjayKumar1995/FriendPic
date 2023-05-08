//
//  UITextField+Extension.swift
//  prefGrab
//
//  Created by RAVI K GUPTA on 01/09/21.
//


import UIKit


extension UITextField {
    

    func setBottomBorder(height: CGFloat, color: UIColor) {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    func applyPadding(padding: Int){
        let paddingView = UIView.init(frame: CGRect(x: 0,y:0,width: padding,height: Int(self.frame.size.height)))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightView(imageName: String){
        let image = UIImage.init(named: imageName)
        let view = UIView.init(frame: CGRect(x:0,y:0,width: 55,height: 40))
        let imageView = UIImageView.init(frame: CGRect(x: 0,y:0,width: Int(self.frame.size.height / 2),height: Int(self.frame.size.height/2)))
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
        view.addSubview(imageView)
        view.isUserInteractionEnabled = false
        imageView.center = view.center
        imageView.image = image
        rightView = view
        //rightView?.backgroundColor = .green
        //imageView.backgroundColor = .red
        imageView.contentMode = .center
        rightViewMode = .always
    }
    
    func setRightView1(imageName: String,tag:Int){
        let image = UIImage.init(named: imageName)
        let view = UIView.init(frame: CGRect(x:0,y:0,width: 55,height: 40))
        let imageView = UIImageView.init(frame: CGRect(x: 0,y:0,width: Int(self.frame.size.height / 2),height: Int(self.frame.size.height/2)))
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
        imageView.tag = tag
        imageView.isUserInteractionEnabled = true
        view.addSubview(imageView)
        view.isUserInteractionEnabled = true
        imageView.center = view.center
        imageView.image = image
        rightView = view
        //rightView?.backgroundColor = .green
        //imageView.backgroundColor = .red
        imageView.contentMode = .center
        rightViewMode = .always
    }
    
//    func setRightView(imageName: String,complitionHendler: @escaping () -> ()){
//
//        let image = UIImage.init(named: imageName)
//        let view = UIView.init(frame: CGRect(x:0,y:0,width: 40,height: 40))
//        let imageView = UIImageView.init(frame: CGRect(x: 0,y:0,width: Int(self.frame.size.height / 2),height: Int(self.frame.size.height/2)))
//        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
//        view.addSubview(imageView)
//        view.isUserInteractionEnabled = false
//        imageView.center = view.center
//        imageView.image = image
//        rightView = view
//        //rightView?.backgroundColor = .green
//        //imageView.backgroundColor = .red
//        imageView.contentMode = .center
//        rightViewMode = .always
//    }

    @objc func imageTapped(_ gestureView:UITapGestureRecognizer) {
        let imageView = gestureView.view as? UIImageView
        if let imageView = imageView {
            
            NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil, userInfo: ["tag":imageView.tag])
        }
        
    }
    
    func setRightButtonWithImage(active: String, inactive: String){
        let view = UIView.init(frame: CGRect(x: 0,y:0,width: 40,height: 40))
        let button = UIButton.init(frame: CGRect(x: 0,y:0,width: Int(self.frame.size.height / 2),height: Int(self.frame.size.height/2)))
        button.setImage(UIImage(named: active), for: .selected)
        button.setImage(UIImage(named: inactive), for: .normal)
        view.addSubview(button)
        button.center = view.center
        rightView = view
        //rightView?.backgroundColor = .green
        //imageView.backgroundColor = .red
        rightViewMode = .always
        button.addTarget(self, action: #selector(buttonEyeTapped(_:)), for: .touchUpInside)
    }
    @objc func buttonEyeTapped(_ sender: UIButton){
        if sender.isSelected {
            isSecureTextEntry = true
        }else{
            isSecureTextEntry = false

        }
        sender.isSelected.toggle()
    }
    func setLeftView(imageName: String){
        let image = UIImage.init(named: imageName)
        let view = UIView.init(frame: CGRect(x: 30,y:0,width: 40,height: 40))
        let imageView = UIImageView.init(frame: CGRect(x: 0,y:0,width:20,height: 20))
        view.addSubview(imageView)
        view.isUserInteractionEnabled = false
        imageView.center = view.center
        imageView.image = image
        leftView = view
       // view.backgroundColor = .green
         //imageView.backgroundColor = .red
         imageView.contentMode = .scaleAspectFit
        leftViewMode = .always
    }
    func setLeftLabel(text: String){
        let view = UIView.init(frame: CGRect(x: 0,y:0,width: 40,height: 40))
        let label = UILabel.init(frame: CGRect(x: 0,y:0,width: Int(self.frame.size.height / 2),height: Int(self.frame.size.height/2)))
        view.addSubview(label)
        view.isUserInteractionEnabled = false
        label.center = view.center
        leftView = view
        label.text = text
       // label.style(fontType: .regular, fontSize: .size14, textColor: Color.appDarkBlue)
        //view.backgroundColor = .green#imageLiteral(resourceName: "simulator_screenshot_35CD207B-25A5-4B71-893A-EFEC5621842E.png")
        //imageView.backgroundColor = .red
        leftViewMode = .always
    }
    func setAttributedPlaceholder(placeHolder: String, color: UIColor , font: UIFont?) {
        if let font = font{
            let attributesDictionary = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font]
            self.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: attributesDictionary)
        }else{
            let attributesDictionary = [NSAttributedString.Key.foregroundColor: color]
            self.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: attributesDictionary)
        }
        
        
    }
    
    func setLeftViewForSearchBar(imageName: String){
        let image = UIImage.init(named: imageName)
        let view = UIView.init(frame: CGRect(x: 5,y:0,width: 40,height: 40))
        let imageView = UIImageView.init(frame: CGRect(x: 0,y:0,width: Int(self.frame.size.height / 2),height: Int(self.frame.size.height/2)))
        view.addSubview(imageView)
        view.isUserInteractionEnabled = false
        imageView.center = view.center
        imageView.image = image
        leftView = view
        imageView.contentMode = .scaleAspectFit
        leftViewMode = .always
    }
    
    func setRightButtonWithImageSearchBar(active: String, inactive: String){
        let view = UIView.init(frame: CGRect(x: 0,y:0,width: 40,height: 40))
        let button = UIButton.init(frame: CGRect(x: 50,y:0,width: Int(self.frame.size.height / 2),height: Int(self.frame.size.height/2)))
        button.setImage(UIImage(named: active), for: .selected)
        button.setImage(UIImage(named: inactive), for: .normal)
        view.addSubview(button)
        button.center = view.center
        rightView = view
        rightViewMode = .never
        button.addTarget(self, action: #selector(clearText(_:)), for: .touchUpInside)
    }
    
    @objc func clearText(_ sender: UIButton) {
        
        text = ""
        rightViewMode = .never
        
    }
}


