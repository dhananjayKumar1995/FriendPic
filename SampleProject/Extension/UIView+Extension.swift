//
//  UIView+Extension.swift
//  SampleProject
//
//  Created by RAVI K GUPTA on 04/01/22.
//

import Foundation
import UIKit
import SwiftUI

extension UIView {
    
    func dropShadowDown() {

        // Shadow Color and Radius
     layer.shadowColor = Color.appBlack.cgColor
     layer.shadowRadius = 10.0
     layer.shadowOpacity = 0.5
     layer.shadowOffset = CGSize(width: 0.0, height: 22.0)
     layer.masksToBounds = false
    }
    
    func dropShadowLBL(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        self.layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.1).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
    }
    func makeRounded()
    {
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
    }
    
    func makeRoundCorner(_ radius:CGFloat)
    {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    func setShadow(radius: CGFloat = 2.0){
        layer.masksToBounds = false
        layer.shadowColor = Color.appBlack.withAlphaComponent(0.8).cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    func setCardView(view : UIView){
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.5
    }
    func setBottomShadow(radius: CGFloat = 2.0){
        self.layer.masksToBounds = false
        self.layer.cornerRadius = radius
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: -1 ,height: +3)
        self.layer.shadowRadius = radius
    }
    func setRadius(_ corner : CGFloat){
        layer.cornerRadius = corner
        layer.masksToBounds = true
    }
    func makeRound(){
        layer.cornerRadius = self.frame.width/2
        layer.masksToBounds = true
    }
    func makeRoundHeight(){
        layer.cornerRadius = self.frame.height/2
        layer.masksToBounds = true
    }
    func setRadius(_ corner : CGFloat , _ color : UIColor){
        layer.cornerRadius = corner
        layer.masksToBounds = true
        layer.borderWidth = 3
        layer.borderColor = color.withAlphaComponent(0.5).cgColor
    }
    func dropShadowBTN(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }
    func setShadowToNavigationBar(){
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 10
    }
    
    func setShadowForProfile(radius: CGFloat = 2.0){
        layer.shadowColor = Color.appDimLightBlue.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = 2.5
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.masksToBounds = false
    }
    
    func setBottomShadow(shadowRadius: CGFloat, cornerRadius: CGFloat){
        self.layer.masksToBounds = false
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: -1 ,height: +5)
        self.layer.shadowRadius = shadowRadius
    }
    func setGradientLinearLeftToRight(colors: [CGColor]){
        //        if let allSubLayers = layer.sublayers {
        //            for sublayer in allSubLayers {
        //                sublayer.removeFromSuperlayer()
        //            }
        //        }
        layer.sublayers = nil
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors
        gradientLayer.locations = [0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        //layer.addSublayer(gradientLayer)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    public enum innerShadowSide
    {
        case all, left, right, top, bottom, topAndLeft, topAndRight, bottomAndLeft, bottomAndRight, exceptLeft, exceptRight, exceptTop, exceptBottom
    }
    
    
    func setRadius(_ corner : CGFloat , _ color : UIColor, _ borderWidth: CGFloat){
        layer.cornerRadius = corner
        layer.masksToBounds = true
        layer.borderWidth = borderWidth
        layer.borderColor = color.cgColor
    }
    func setBorder(color: UIColor, borderWidth: CGFloat = 1) {
        layer.borderWidth = borderWidth
        layer.borderColor = color.cgColor
        clipsToBounds = true
    }
    private static let lineDashPattern: [NSNumber] = [7, 7]
    private static let lineDashWidth: CGFloat = 4.0
    
    func makeDashedBorderLine(pointTo: CGPoint, pointFrom: CGPoint, color: UIColor) {
        let layers = layer.sublayers
        if layers?.first?.accessibilityLabel == "remove" {
            layer.sublayers?.first?.removeFromSuperlayer()
        }
        let path = CGMutablePath()
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = UIView.lineDashWidth
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineDashPattern = UIView.lineDashPattern
        shapeLayer.lineDashPhase = 2
        path.addLines(between: [pointTo,
                                pointFrom])
        shapeLayer.accessibilityLabel = "remove"
        shapeLayer.path = path
        //layer.addSublayer(shapeLayer)
        layer.insertSublayer(shapeLayer, at: 0)
    }
    
//    func makeDashedBorderLine(pointTo: CGPoint, pointFrom: CGPoint) {
//        let layers = layer.sublayers
//        if layers?.last?.accessibilityLabel == "remove" {
//
//            let path = CGMutablePath()
//            path.addLines(between: [pointTo,
//                                    pointFrom])
//            (layers?.last as? CAShapeLayer)?.path = path
//            return
//        }
//        let path = CGMutablePath()
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.lineWidth = UIView.lineDashWidth
//        shapeLayer.strokeColor = UIColor.AppColor.appGreen.cgColor
//        shapeLayer.lineDashPattern = UIView.lineDashPattern
//        shapeLayer.lineDashPhase = 2
//        path.addLines(between: [pointTo,
//                                pointFrom])
//        shapeLayer.accessibilityLabel = "remove"
//        shapeLayer.path = path
//        layer.addSublayer(shapeLayer)
//    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            let cornerMasks = [
                corners.contains(.topLeft) ? CACornerMask.layerMinXMinYCorner : nil,
                corners.contains(.topRight) ? CACornerMask.layerMaxXMinYCorner : nil,
                corners.contains(.bottomLeft) ? CACornerMask.layerMinXMaxYCorner : nil,
                corners.contains(.bottomRight) ? CACornerMask.layerMaxXMaxYCorner : nil,
                corners.contains(.allCorners) ? [CACornerMask.layerMinXMinYCorner, CACornerMask.layerMaxXMinYCorner, CACornerMask.layerMinXMaxYCorner, CACornerMask.layerMaxXMaxYCorner] : nil
            ].compactMap({ $0 })
            
            var maskedCorners: CACornerMask = []
            cornerMasks.forEach { (mask) in maskedCorners.insert(mask) }
            
            self.clipsToBounds = true
            self.layer.cornerRadius = radius
            self.layer.borderWidth = 2
            self.layer.borderColor = UIColor.red.cgColor
            self.layer.maskedCorners = maskedCorners
        } else {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
}


extension UIApplication {
    
    func topVisibleViewController() -> UIViewController? {
        
        guard let window = kAppDelegate.window else{return nil}
        
        var top = window.rootViewController
        while true {
            if let presented = top?.presentedViewController {
                top = presented
            } else if let nav = top as? UINavigationController {
                top = nav.visibleViewController
            } else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            } else {
                break
            }
        }
        return top
    }
}

//mark:- to set underline in button and label

extension NSMutableAttributedString {
@discardableResult func bold(_ text:String) -> NSMutableAttributedString {

    let attrs : [NSAttributedString.Key : Any] = [
    
        NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue]
   let boldString = NSMutableAttributedString(string: text, attributes: attrs)
   self.append(boldString)
   return self
}

@discardableResult func normal(_ text:String)->NSMutableAttributedString {
    let attrs : [NSAttributedString.Key : Any] = [
        //NSAttributedString.Key.font : UIFont(name: "Segoe UI Bold", size: 24)!,
        NSAttributedString.Key.foregroundColor : UIColor.white
   ]
   let normal =  NSAttributedString(string: text,  attributes:attrs)
   self.append(normal)
   return self
}
}

//hide keyboard
extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
       let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
}
