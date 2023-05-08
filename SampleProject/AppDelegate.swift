//
//  AppDelegate.swift
//  SampleProject
//
//  Created by RAVI K GUPTA on 04/01/22.
//

import UIKit
import Branch
import IQKeyboardManagerSwift
import PromiseKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var restrictRotation:UIInterfaceOrientationMask = .portrait
    var isDeviceTokenUpdate = false
    var isLoadingUpdateTokenApi = false
    var mySubscription:SubscriptionDetailModel?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //for subscription plan
        IAPManager.shared.fetchAvailableProducts(showLoader: false)
        
        //for deeplinking
        // if you are using the TEST key
      
        
        // window = UIWindow()
        service = Services()
        IQKeyboardManager.shared.enable = true
        UIFont.printFontFamily()
        // window?.frame = UIScreen.main.bounds
        
        //TO SHOW SCREEN AFTER LOUNCH APP
        checkToLoadScreen()
        getPushInfoWhenAppInvokedFromKilledState(launchOptions: launchOptions)
        Branch.setUseTestBranchKey(false)
        // listener for Branch Deep Link data
        Branch.getInstance().initSession(launchOptions: launchOptions) {(params,error) in
            // do stuff with deep link data (nav to page, display content, etc)
            print(params as? [String: AnyObject] ?? {})
            guard let shareUrlStr = params?["+non_branch_link"] as? String else { return }
            let url = shareUrlStr.components(separatedBy: "=")
            let second = url[1]
            let third = url.last ?? ""
            let total = second + "=" + third
            self.handleShareUrl(shareUrlStr: total)
        }
        return true
    }
    
    func handleShareUrl(shareUrlStr:String) {
        kUserDefaults.set(shareUrlStr, forKey: "shareUrlStr")
        guard let _ = kUserDefaults.string(forKey: AppKeys.token) else {
            return
        }
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.5, execute: {
            
            let rootView = UIApplication.shared.topVisibleViewController()
            if let votingVC = rootView as? FPPreviewVC {
                if votingVC.urlStr == shareUrlStr {
                    kUserDefaults.set(nil, forKey: "shareUrlStr")
                    return
                }
            }
            let vc = FPPreviewVC.instantiate(fromAppStoryboard: .registration)
            vc.modalPresentationStyle = .fullScreen
            vc.urlStr = shareUrlStr
            vc.hidesBottomBarWhenPushed = true
            if let tabbar = rootView?.tabBarController{
                tabbar.present(vc, animated: true)
            }
            else {
                rootView?.present(vc, animated: true)
            }
            kUserDefaults.set(nil, forKey: "shareUrlStr")
        })
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return restrictRotation
    }
    
    // MARK: UISceneSession Lifecycle
    
    
    //for deeplinking
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return Branch.getInstance().application(app, open: url, options: options)
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        // handler for Universal Links
        return Branch.getInstance().continue(userActivity)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // handler for Push Notifications
        // Branch.getInstance().handlePushNotification(userInfo)
    }
    
    //for deeplinking
    // Get deep linking link
    func getShareableLink(uCode:String, titleName: String, imageUrl: String,completionHandler : @escaping (String)->() ) {
        let branchUniversalObject = BranchUniversalObject(canonicalIdentifier: "Kwikpic/App")
        branchUniversalObject.imageUrl = imageUrl
        branchUniversalObject.title = titleName
        branchUniversalObject.publiclyIndex = true
        branchUniversalObject.locallyIndex = true
        let linkProperties = BranchLinkProperties()
        linkProperties.feature = "share"
        linkProperties.channel = "sms"
        branchUniversalObject.contentDescription = "Kwikpic App"
        linkProperties.addControlParam("groupCode", withValue: uCode)
        branchUniversalObject.getShortUrl(with: linkProperties) { (url, error) in
            if error == nil, let urlString = url {
                print("Deep Link URL : \(urlString)")
                completionHandler(urlString)
            }
            else {
                completionHandler("")
                print("URL not created : \(error?.localizedDescription)")
            }
        }
    }
    
    //get subcription for premium plan
    func subscriptionDetail() {
        
        Loader.show()
        
        firstly {
            service!.subscriptionDetail(params: [:])
        }.done { (model: SubscriptionDetailModel) in
            self.handleResponse(model: model)
        }.catch {(error) in
            print(error)
            DisplayBanner2.show(title: error.localizedDescription)
        }.finally {
            Loader.hide()
        }
    }
    
    func handleResponse (model: SubscriptionDetailModel) {
        
        //    if model.status != 200{
        //
        //        //DisplayBanner1.show(title:model.message)
        //        return
        //
        //    }
        mySubscription = model
        
        //kUserDefaults.set(model.data?.subscription?.iosSubscriptionId, forKey: UserDefaultKey.ios_subscription_id)
        //    kUserDefaults.set(model.data?.subscription?.isExpired, forKey: UserDefaultKey.is_expired)
        //    kUserDefaults.set(model.data?.subscription?.plan?.price, forKey: UserDefaultKey.price)
        //    kUserDefaults.set(model.data?.subscription?.plan?.validityInMonth, forKey: UserDefaultKey.validity_in_month)
        //    kUserDefaults.set(model.data?.subscription?.plan?.active, forKey: UserDefaultKey.active)
        
    }
}

