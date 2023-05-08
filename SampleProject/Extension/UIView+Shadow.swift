//
//  Shadow.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 04/02/22.
//

import Foundation
import UIKit
extension UIView {

  // OUTPUT 1
  func dropShadow1() {

      // Shadow Color and Radius
   layer.shadowColor = Color.AddBtnbgcShadow.cgColor
   layer.shadowRadius = 5.0
   layer.shadowOpacity = 1.0
   layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
   layer.masksToBounds = false
  }

  // OUTPUT 2
    func dropShadow2(color: UIColor, opacity: Float = 0.8, offSet: CGSize, radius: CGFloat = 5.0, scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
    layer.shadowRadius = radius
    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
    
    
    func addshad(shadowColor: UIColor = UIColor.lightGray, borderColor: UIColor = UIColor.white , opacity: Float = 0.5, offSet: CGSize = CGSize(width: 0, height: 0), radius: CGFloat = 5, scale: Bool = true)  {
            self.layer.shadowPath =
            UIBezierPath(roundedRect: self.bounds,
                  cornerRadius: self.layer.cornerRadius).cgPath
            self.layer.shadowColor = shadowColor.cgColor
            self.layer.shadowOpacity = opacity
            self.layer.shadowOffset = offSet
            self.layer.shadowRadius = radius
            self.layer.masksToBounds = false
           
        }
    
}
