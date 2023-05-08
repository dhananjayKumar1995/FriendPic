//
//  Constant.swift
//  SampleProject
//
//  Created by RAVI K GUPTA on 04/01/22.
//


import UIKit
import Foundation

let kAppDelegate = UIApplication.shared.delegate as! AppDelegate
let kScreenHeight = UIScreen.main.bounds.height
let kScreenWidth = UIScreen.main.bounds.width
let kUserDefaults = UserDefaults.standard
let CWindow = CSharedApplication.keyWindow

struct Constants {

    
}
struct Color {
    static let appBackground = UIColor(hexString: "#71CDE2")
    static let appDarkBlue = UIColor(hexString: "#024C8C")
    static let appDimLightBlue = UIColor(hexString: "#9ACCF3")
    static let appTitle = UIColor(hexString: "#949FA8")
   
    static let appDimGray = UIColor(hexString: "#E9E9E9")
    static let appLightRed = UIColor(hexString: "#F2EDED")
   // static let appLightGray = UIColor(hexString: "#EDEDF0")
    static let applightYellow = UIColor(hexString: "#EBA400")
    static let applightBG = UIColor(hexString: "#F2F6F9")
    static let appRed = UIColor(hexString: "#FF0000")
    static let appFaded = UIColor(hexString: "#A7C0D6")
    static let appDarkBlack = UIColor(hexString: "#000000")
    static let appBlack = UIColor(hexString: "#0C040C")
    static let appLightBlack = UIColor(hexString: "#09070C")
    static let applightBlue = UIColor(hexString: "#2276B7")
    static let appSkyBlue = UIColor(hexString: "#E5F3FD")
    static let appLightGreen = UIColor(hexString:"#5FD486")
    static let appGray = UIColor(hexString:"#A6A4A8")
    static let appEditButtonGray = UIColor(hexString: "#A9A7AC")
   // static let appDarkGray = UIColor(hexString:"#707070")
   
    static let appDimlightGray = UIColor(hexString: "#F0F0F0")
    static let appPlaceholder = UIColor(hexString: "#1A1A1A")
    static let applightDimGray = UIColor(hexString: "#EAEAEA")
    static let applesslightDim = UIColor(hexString: "#F1F1F1")
    
    
   
    static let  hometabbgc = UIColor(hexString: "#F3F3F3")
    static let  homeAddBtnbgc = UIColor(hexString: "#FFFFFF")
    static let  AddBtnbgcShadow = UIColor(hexString: "#60BAB2")
    static let  appLightBlacks = UIColor(hexString: "#252525")
    static let  appLightErrorRed = UIColor(hexString: "#D65745")
    static let  appLightSuccessGreen = UIColor(hexString: "#55B938")
    
    static let appLightgray = UIColor(hexString: "#8A8A8A")
    static let appLightSkyBlue = UIColor(hexString: "#4AB9AF")//97D8D2
    static let appBlue = UIColor(hexString: "#4AA2F8")
    static let appFPRed = UIColor(hexString: "#F44336")
    static let appBlue1 = UIColor(hexString: "#4EACF9")
    static let appLightMidDarkGray = UIColor(hexString: "#DADEDD")
    static let appWhite = UIColor(hexString: "#FFFFFF")
    static let appFPBlue = UIColor(hexString: "#5DC7BD")
    static let appFPBlue1 = UIColor(hexString: "#2AADA2")
    static let appFPBlue2 = UIColor(hexString: "#CCECE9")
    static let appFPBlue3 = UIColor(hexString: "#28BAAC")
    static let appLightGray = UIColor(hexString: "#8A8A8A")
    static let appLightGray1 = UIColor(hexString: "#F0F0F0")//ACACAC
    static let appLightGray2 = UIColor(hexString: "#707070")
    static let appDarkGray = UIColor(hexString: "#252525")
    static let appLightGray3 = UIColor(hexString: "#9B9B9B")
    static let appDarkGrayColor = UIColor(hexString: "#575757")
                                 
}

struct AppKeys {

   static let token = "token"
   static let userData = "userData"
   static let userFirstTime = "userFirstTime"
   static let loggedIn = "loggedin"
}

struct UserDefaultKey {
    
    static let token = "token"
    static let email = "email"
    static let account_type = "account_type"
    static let social_id = "social_id"
    static let name = "name"
    static let ios_subscription_id = "ios_subscription_id"
    static let is_expired = "is_expired"
    static let validity_in_month = "validity_in_month"
    static let active = "active"
    static let price = "price"
}

struct ServerKey {
    
}

let CSharedApplication = UIApplication.shared

