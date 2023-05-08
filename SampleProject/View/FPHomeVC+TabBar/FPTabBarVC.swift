//
//  FPTabBarVc.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 03/02/22.
//

import UIKit

class FPTabBarVC: UITabBarController, UITabBarControllerDelegate  {
    /*
     determine if the indicator
     will be drawn on top of bar items or not
     */
    @IBInspectable var onTopIndicator: Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        if (navigationController?.viewControllers.count ?? 0) > 1 {
            kAppDelegate.setSwipe(enabled: false, navigationController: self.navigationController)
        }
        else {
            kAppDelegate.setSwipe(enabled: true, navigationController: self.navigationController)
        }
        UserDefaults.standard.set(true, forKey:"loggedin")
        // Do any additional setup after loading the view.
    }

    //MARK:- View Controller Life Cycle
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        // Draw Indicator above the tab bar items
        guard let numberOfTabs = tabBar.items?.count else {
            return
        }

        let numberOfTabsFloat = CGFloat(numberOfTabs)
        let imageSize = CGSize(width: 45,
                               height: tabBar.frame.height)
       // let imageSize = CGSize(width: 50.0,
        //                       height: tabBar.frame.height+20)

        let indicatorImage = UIImage.drawTabBarIndicator(color: Color.appFPBlue1,
                                                         size: imageSize,
                                                         onTop: onTopIndicator)


        
        self.tabBar.selectionIndicatorImage = indicatorImage
       // self.tabBar.backgroundColor = .white
        self.tabBar.selectedImageTintColor = Color.appFPBlue1
        tabBar.isTranslucent = false
        tabBar.layer.backgroundColor = Color.hometabbgc.cgColor//UIColor.white.cgColor
        tabBar.barTintColor = .white
        //self.tabBar.items?.first?.imageInsets = UIEdgeInsets(top:6, left:0, bottom: 0, right: 0)
       // UITabBar.appearance().barTintColor = UIColor.white // your color

        tabBar.items?.forEach { item in
            
            item.imageInsets = UIEdgeInsets(top:6, left:0, bottom: 0, right: 0)
        }
    }


}

extension UIImage{
    //Draws the top indicator by making image with filling color
    class func drawTabBarIndicator(color: UIColor, size: CGSize, onTop: Bool) -> UIImage {
        let indicatorHeight = 5.0
        let yPosition = onTop ? 0 : (size.height - indicatorHeight)

        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: yPosition, width: size.width, height: indicatorHeight))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image!
    }
}

