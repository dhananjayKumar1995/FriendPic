//
//  AppDelegate+Notification.swift
//  Ramnant
//
//  Created by ankur gupta on 29/09/21.
//

import Foundation
import UIKit
import PromiseKit
import Kingfisher


extension AppDelegate : UNUserNotificationCenterDelegate{
    //MARK:- Register for Push Notifications
    func registerForPushNotifications() {
        //1
        UIApplication.shared.registerForRemoteNotifications()
        let notificicationCenter = UNUserNotificationCenter.current()
        notificicationCenter.delegate = self
        //2
        notificicationCenter.requestAuthorization(
            options: [.alert, .sound, .badge]) { [weak self] granted, _ in
                //3
                print("Permission granted: \(granted)")
                guard granted else { return }
                //4
                self?.getNotificationSettings()
            }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            print("Notification settings: \(settings)")
            
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                //UIApplication.shared.registerForRemoteNotifications()
            }
            
        }
    }
    //MARK:-Get Notifications When app is in foreground
        func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            if let userInfo = notification.request.content.userInfo as? [String:Any] {
                print("willPresent ---- \(String(describing: userInfo))")
                //self.goToNavigationController()
                NotificationCenter.default.post(name: Notification.Name("refreshHomeData"), object: nil, userInfo: nil)
            }
            completionHandler([.alert,.badge,.sound])
          }
    
         func goToNavigationController() {
             let vc = FPNotificationVC.instantiate(fromAppStoryboard: .registration)
             if let topVC = UIApplication.shared.topVisibleViewController() {
                 if topVC.navigationController != nil {
                     //Console.log("IF BLOCK")
                     vc.hidesBottomBarWhenPushed = true
                     topVC.navigationController?.pushViewController(vc, animated: true)
                 }  else {
                     vc.hidesBottomBarWhenPushed = true
                     topVC.navigationController?.pushViewController(vc, animated: true)
                     //Console.log("Else block")
                 }
             }
         }
    func getPushInfoWhenAppInvokedFromKilledState(launchOptions: [UIApplication.LaunchOptionsKey: Any]?){
        if let userInfo = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] as? [String: Any] {
            
            //notificationRecieved(info: userInfo, identifier: "getPushInfoWhenAppInvokedFromKilledState", origin: .tapped, notificationType: .push)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                // self.registerForPushNotification()
                self.goToNavigationController()
            }
            
        }
    }
    

    //MARK:- When Notification is triggered
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if let info = response.notification.request.content.userInfo as? Dictionary<String , Any> {
            print("notification Data :\(info)")
            self.goToNavigationController()
        }
        completionHandler()
    }

    //MARK:- Get Device Token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        kUserDefaults.set(token, forKey: "deviceToken")
        updateTokenToServer()
        print("Device Token: \(token)")//save to defualts->send it in scoket-init event socket "device token"
    }
    
   // func setDeviceToken
        
    //MARK:- Failed to register notification
    func application(_ application: UIApplication,didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
}


extension AppDelegate {
    // Call api for update device token
    func updateTokenToServer() {
        guard let _ = kUserDefaults.string(forKey: AppKeys.token) else {
            return
        }
        guard let deviceToken = kUserDefaults.string(forKey: "deviceToken") else {
            return
        }
        if isDeviceTokenUpdate {
            print("Device \("isDeviceTokenUpdate") token already updated")
            return
        }
        
        if isLoadingUpdateTokenApi {
            print("isLoadingUpdateTokenApi running")
            return
        }
        isLoadingUpdateTokenApi = true
        let uuid = UIDevice.current.identifierForVendor?.uuidString ?? ""
        let param = ["device_token":deviceToken, "device_uid": uuid] as [String : Any]
       // Loader.hide()
        firstly {
            service!.setDeviceToken(param: param)
        }.done { (model:CommonResponse) in
            self.isDeviceTokenUpdate = true
            //DisplayBanner.show(title: model.message)
        }.catch { (error) in
            print(error)
            //DisplayBanner.show(title: error.localizedDescription)
        }.finally {
            //Loader.hide()
        }
    }
}


//extension UIApplication {
//    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
//        if let navigationController = controller as? UINavigationController {
//            return topViewController(controller: navigationController.visibleViewController)
//        }
//        if let tabController = controller as? UITabBarController {
//            if let selected = tabController.selectedViewController {
//                return topViewController(controller: selected)
//            }
//        }
//        if let presented = controller?.presentedViewController {
//            return topViewController(controller: presented)
//        }
//        return controller
//    }
//}
