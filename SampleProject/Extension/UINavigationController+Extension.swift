//
//  UINavigationController+Extension.swift
//  prefGrab
//
//  Created by RAVI K GUPTA on 01/09/21.
//

import UIKit
extension UINavigationController{
    
    func setBottomShadow(){
        navigationBar.layer.masksToBounds = false
        navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        navigationBar.layer.shadowOpacity = 0.8
        navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        navigationBar.layer.shadowRadius = 10
    }
    func available(viewController: AnyClass)-> UIViewController?{
        for vc in viewControllers {
            if vc.isKind(of: viewController)  {
                return vc
            }
            
        }
        return nil
    }
    func containsViewController(ofKind kind: AnyClass) -> Bool{
        return self.viewControllers.contains(where: { $0.isKind(of: kind) })
    }
    func setTranparent(){
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
    }
    func style(){
        navigationBar.barTintColor = Color.appWhite
        navigationBar.tintColor = Color.appDarkBlue
      //  navigationBar.titleTextAttributes = [NSAttributedString.Key.font: StaticFont.font(type: .bold, size: .size22) , NSAttributedString.Key.foregroundColor: Color.appDarkBlue]
    }
    func swipe(setEnabled: Bool){
        (self as? SwipeableNavigationController)?.isSwipeEnabled = setEnabled
    }
}

