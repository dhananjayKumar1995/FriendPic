//
//  Appdelegate+Helper.swift
//  SampleProject
//
//  Created by RAVI K GUPTA on 04/01/22.
//

import UIKit

extension AppDelegate {
    
    func setSwipe(enabled: Bool, navigationController: UINavigationController?){
        if let nav = navigationController as? SwipeableNavigationController {
            nav.isSwipeEnabled = enabled
        }
    }
    
    func checkToLoadScreen(){
        let token = kUserDefaults.string(forKey: AppKeys.token)
        print("Token\(token)")
        if token == nil
        {
            print(token)
            let  userFirstTime = kUserDefaults.bool(forKey: "userFirstTime")
            if userFirstTime {
                switchLoginScreen()
            }
            else {
                switchOnboardingScreen()
            }
        }
        else {
            switchHomeScreen()
        }
    }
    
    
    func switchOnboardingScreen() {
        
        let vc = FPOnboardingVC.instantiate(fromAppStoryboard:.registration)
        let navVC = SwipeableNavigationController(rootViewController: vc)
        navVC.setNavigationBarHidden(true, animated: false)
        //  self.window?.rootViewController = navVC
        self.setRoot(navVC)
        
    }
    
    func switchLoginScreen() {
        
        let vc = FPLoginVC.instantiate(fromAppStoryboard:.registration)
        let navVC = SwipeableNavigationController(rootViewController: vc)
        navVC.setNavigationBarHidden(true, animated: false)
        //  self.window?.rootViewController = navVC
        self.setRoot(navVC)
        
    }
    
    func switchHomeScreen() {
        
        let vc = FPTabBarVC.instantiate(fromAppStoryboard:.registration)
        let navVC = SwipeableNavigationController(rootViewController: vc)
        navVC.setNavigationBarHidden(true, animated: false)
        //  self.window?.rootViewController = navVC
        self.setRoot(navVC)
        kAppDelegate.registerForPushNotifications()
    }
    
    func setRoot(_ vc:UIViewController){
        
        //MARK:- To create first time window object in Application
        if #available(iOS 13.0, *) {
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } else {
            let bounds = UIScreen.main.bounds
            self.window = UIWindow(frame: bounds)
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
        }
    }
    
    
    //MARK: - TO SAVE DATA
    func saveUserData(userData:UserDataModel) {
        if userData.data?.token != nil {
            
            //kUserDefaults.set(userData.data?.token, forKey: UserDefaultKey.token)
            kUserDefaults.set(userData.data?.token ?? "", forKey: UserDefaultKey.token)
        }
        kUserDefaults.set(userData.data?.user?.name, forKey: UserDefaultKey.name)
        kUserDefaults.set(userData.data?.user?.email, forKey: UserDefaultKey.email)
        kUserDefaults.set(userData.data?.user?.accountType, forKey: UserDefaultKey.account_type)

        //            kUserDefaults.set(userData.data?.user?.account_type, forKey: UserDefaultKey.account_type)
        //            kUserDefaults.set(userData.data?.user?._id, forKey: ServerKey.userId)
        //            kUserDefaults.set(userData.data?.user?.isPhoneVerified, forKey: ServerKey.isPhoneVerified)
        //            kUserDefaults.set(userData.data?.user?.isEmailVerified, forKey: ServerKey.isEmailVerified)
        //            kUserDefaults.set(userData.data?.user?.countryCode, forKey: ServerKey.countryCode)
        //            kUserDefaults.set(userData.data?.user?.email, forKey: ServerKey.email)
        //            kUserDefaults.set(userData.data?.user?.phoneNumber, forKey: ServerKey.phoneNumber)
        //            kUserDefaults.set(userData.data?.user?.avatar, forKey: ServerKey.avatar)
        //            kUserDefaults.set(userData.data?.user?.isAvatarVerified, forKey: ServerKey.isAvatarVerified)
        //            kUserDefaults.set(userData.data?.user?.isVideoVerified, forKey: ServerKey.isVideoVerified)
        //            kUserDefaults.set(userData.data?.user?.tocAccepted, forKey: ServerKey.tocAccepted)
    }
    
    func deleteData() {
        
        kUserDefaults.removeObject(forKey: UserDefaultKey.token)
        kUserDefaults.removeObject(forKey: UserDefaultKey.name)
       // kUserDefaults.removeObject(forKey: UserDefaultKey.email)
        
    }
    
}
