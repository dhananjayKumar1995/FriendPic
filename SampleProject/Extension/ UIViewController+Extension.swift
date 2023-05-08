//
//   UIViewController+Extension.swift
//  SampleProject
//
//  Created by RAVI K GUPTA on 04/01/22.
//

import UIKit
import Kingfisher

typealias alertActionHandler = ((UIAlertAction) -> ())?

extension UIViewController {
    
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
    func showAlert(title: String, message: String)  {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "ok", style: .default) { (_) in
        }
        alertController.addAction(confirmAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    func delay(time:TimeInterval,completionHandler: @escaping ()->()) {
        let when = DispatchTime.now() + time
        DispatchQueue.main.asyncAfter(deadline: when) {
            completionHandler()
        }
    }
    func setLeftBarButtonItem(imageName: String){
        let image =  UIImage.init(named: imageName)?.withRenderingMode(.alwaysOriginal)
        let barButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = barButtonItem
    }
    func setLeft(title: String){
        let barButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = barButtonItem
    }
    func setRightBarButtonItem(imageName: String){
        let image =  UIImage.init(named: imageName)?.withRenderingMode(.alwaysOriginal)
        let barButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = barButtonItem
        //navigationItem.setRightBarButton(barButtonItem, animated: true)
    }
    func setRightBarButtonItems(imageName: [String]){
        var items = [UIBarButtonItem]()
        for name in imageName {
            let image =  UIImage.init(named: name)?.withRenderingMode(.alwaysOriginal)
            let barButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: nil)
            items.append(barButtonItem)
        }
        navigationItem.rightBarButtonItems = items
        //navigationItem.setRightBarButton(barButtonItem, animated: true)
    }
    func setNavigation(_ title: String) {
        navigationItem.title = title
        
     
//        let nav = self.navigationController?.navigationBar
//        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
    func setRightBarButtonItem(title: String){
        let barButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: nil)
        barButtonItem.tintColor = .white
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    func setCentreBarItem(title: String){
        let label = UILabel()
        label.text = title
        label.contentMode = .scaleAspectFit
        navigationItem.titleView = label
    }
    
    func setLeftBarButtonItemWithTitle(_ title: String, andImage image: UIImage?) {
        let titleLbl = UILabel()
        titleLbl.font = UIFont(name: "", size: 20)
        titleLbl.text = title
        //titleLbl.numberOfLines = 2
        titleLbl.textColor = UIColor.white
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        let titleView = UIStackView(arrangedSubviews: [imageView, titleLbl])
        titleView.axis = .horizontal
        titleView.spacing = 10.0
        let barButtonItem = UIBarButtonItem(customView: titleView)
        navigationItem.leftBarButtonItem = barButtonItem
    }
    
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    func presentActionsheetWithOneButton(actionSheetTitle:String? , actionSheetMessage:String? , btnOneTitle:String  , btnOneStyle:UIAlertAction.Style , btnOneTapped:alertActionHandler, btnCancelHandler:alertActionHandler = nil) {
        
        let alertController = UIAlertController(title: actionSheetTitle, message: actionSheetMessage, preferredStyle: .actionSheet)
        
        if let subview = alertController.view.subviews.first, let actionSheet = subview.subviews.first {
            for innerView in actionSheet.subviews {
                innerView.backgroundColor = UIColor.white
            }
        }
        
        alertController.addAction(UIAlertAction(title: btnOneTitle, style: btnOneStyle, handler: btnOneTapped))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: btnCancelHandler))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentActionsheetWithTwoButtons(actionSheetTitle:String? , actionSheetMessage:String? , btnOneTitle:String  , btnOneStyle:UIAlertAction.Style , btnOneTapped:alertActionHandler , btnTwoTitle:String  , btnTwoStyle:UIAlertAction.Style , btnTwoTapped:alertActionHandler) {
        
        let alertController = UIAlertController(title: actionSheetTitle, message: actionSheetMessage, preferredStyle: .actionSheet)
        
        if let subview = alertController.view.subviews.first, let actionSheet = subview.subviews.first {
            for innerView in actionSheet.subviews {
                innerView.backgroundColor = .white
            }
        }
        
        alertController.addAction(UIAlertAction(title: btnOneTitle, style: btnOneStyle, handler: btnOneTapped))
        
        alertController.addAction(UIAlertAction(title: btnTwoTitle, style: btnTwoStyle, handler: btnTwoTapped))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}




extension UILabel{
    func style(fontType: FontType, fontSize: FontSize, textColor: UIColor, textStyle: UIFont.TextStyle? = nil, isDynamic: Bool = true, backgroundColor: UIColor = .clear){
        if isDynamic{
            adjustsFontForContentSizeCategory = true
            font = DynamicFont.font(type: fontType, size: fontSize, textStyle: textStyle)
        }else{
            font = StaticFont.font(type: fontType, size: fontSize)
            
        }
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        
    }
    func setAttributedTextForAsteric(color: UIColor){
        guard let textString = text, let font = font else{return}
        let range = (textString as NSString).range(of: "*")
        let attributedString = NSMutableAttributedString(string:textString)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: range)
        attributedString.addAttribute(NSAttributedString.Key.font, value: font , range: range)
        self.attributedText = attributedString
    }
}
extension UITextField{
    func style(fontType: FontType, fontSize: FontSize, textColor: UIColor, textStyle: UIFont.TextStyle? = nil, isDynamic: Bool = true, backgroundColor: UIColor = .clear, placeholderColor: UIColor){
        if isDynamic{
            adjustsFontForContentSizeCategory = true
            font = DynamicFont.font(type: fontType, size: fontSize, textStyle: textStyle)
        }else{
            font = StaticFont.font(type: fontType, size: fontSize)
            
        }
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        if let placeholder = placeholder{
            setAttributedPlaceholder(placeHolder: placeholder, color: placeholderColor, font: font)
        }
        
    }
}
extension UIButton{
    func style(fontType: FontType, fontSize: FontSize, textColor: UIColor, textStyle: UIFont.TextStyle? = nil, isDynamic: Bool = true, backgroundColor: UIColor = .clear){
        if isDynamic{
            titleLabel?.adjustsFontForContentSizeCategory = true
            titleLabel?.font = DynamicFont.font(type: fontType, size: fontSize, textStyle: textStyle)
        }else{
            titleLabel?.font = StaticFont.font(type: fontType, size: fontSize)
            
        }
        setTitleColor(textColor, for: .normal)
        setTitleColor(textColor, for: .selected)

        self.backgroundColor = backgroundColor
        
    }
}

class CustomTextField: UITextField{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}


class CustomLeftPaddingTextField: UITextField{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    let padding = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 30)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

class CustomLeftRightPaddingTextField: UITextField{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    let padding = UIEdgeInsets(top: 20, left: 80, bottom: 20, right: 80)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}




//class CustomVerificationTextField: UITextField{
//    var customDelegate: EmptyDelegate?
//    override public func deleteBackward() {
//        if text == "" {
//            customDelegate?.empty(field: self)
//        }
//        super.deleteBackward()
//    }
//}
extension UITextView{
    func style(fontType: FontType, fontSize: FontSize, textColor: UIColor, textStyle: UIFont.TextStyle? = nil, isDynamic: Bool = true, backgroundColor: UIColor = .clear){
        if isDynamic{
            adjustsFontForContentSizeCategory = true
            font = DynamicFont.font(type: fontType, size: fontSize, textStyle: textStyle)
        }else{
            font = StaticFont.font(type: fontType, size: fontSize)
            
        }
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
}
class CustomExpandButton: UIButton{
    override func layoutSubviews() {
        super.layoutSubviews()
       // self.titleLabel?.preferredMaxLayoutWidth = self.titleLabel?.frame.size.width ?? 0
    }

    override var intrinsicContentSize: CGSize {
        //return self.titleLabel?.intrinsicContentSize ?? CGSize.zero
        return CGSize(width: frame.size.width, height: titleLabel?.frame.size.height ?? 0.0);

    }
}
class CustomView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    func setup(){
        if tag == 1{
            backgroundColor = Color.appDarkBlue
        }
    }
}

extension UIViewController {

    func setNavigationTitleWithBackButton(title:String) {
        let btnLeftMenu: UIButton = UIButton()
        let image = UIImage(named: "angle-leftWhite");
        btnLeftMenu.setImage(image, for: .normal)
        btnLeftMenu.setTitle(title.localized(), for: .normal);
        btnLeftMenu.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right:0.0)
        btnLeftMenu.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right:-20.0)
      //  btnLeftMenu.style(fontType:FontType.bold, fontSize: .size18, textColor: Color.appWhite)
        btnLeftMenu.addTarget(self, action: #selector (backButtonClick(sender:)), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        self.navigationItem.leftBarButtonItem = barButton
    }

    @objc func backButtonClick(sender : UIButton) {
        self.navigationController?.popViewController(animated: true);
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension UIApplication {
    
    static func getAppdelegate() -> AppDelegate? {
        if let appdelegate = UIApplication.shared.delegate as? AppDelegate {
            return appdelegate
        }
        return nil
    }
    
    
//    static func lock() {
//        UIApplication.getWindow()?.lock(mainImage: UIImage(named: "loading"))
//    }
//
//    static func unlock() {
//        UIApplication.getWindow()?.unlock()
//    }
}

