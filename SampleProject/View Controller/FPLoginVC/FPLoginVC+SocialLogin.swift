//
//  FPLoginVC+SocialLogin.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 14/02/22.
//

import Foundation
import AuthenticationServices
import FBSDKLoginKit
import FacebookCore
import FacebookLogin
import FBSDKCoreKit


//*************************MARK:- APPLE LOGIN

@available(iOS 13.0, *)
extension FPLoginVC: ASAuthorizationControllerDelegate {
    
    
    //Apple sign in default  button initialize ... calling from viewdidload in FPLoginVC
    func setUpAppleSignInButtonOption() {
        if #available(iOS 13.0, *) {
            buttonApple.isHidden = false
            let appleButton = ASAuthorizationAppleIDButton()
            appleButton.translatesAutoresizingMaskIntoConstraints = false
            appleButton.addTarget(self, action: #selector(buttonActionAppleSignIn), for: .touchUpInside)
            buttonApple.addSubview(appleButton)
            NSLayoutConstraint.activate(
                [
                    buttonApple.leadingAnchor.constraint(equalTo: buttonApple.leadingAnchor),
                    buttonApple.trailingAnchor.constraint(equalTo: buttonApple.trailingAnchor),
                    buttonApple.topAnchor.constraint(equalTo: buttonApple.topAnchor),
                    buttonApple.bottomAnchor.constraint(equalTo: buttonApple.bottomAnchor)])
        } else {
            buttonApple.isHidden = true
            // Fallback on earlier versions
        }
    }
    
    //MARK:- Apple sign in method
    @available(iOS 13.0, *)
    @objc func buttonActionAppleSignIn(_ sender:ASAuthorizationAppleIDButton) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email,]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
    
    // ASAuthorizationControllerDelegate function for authorization failed
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        Console.log(error.localizedDescription)
    }
    
    // ASAuthorizationControllerDelegate function for successful authorization
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            self.appleSignIn(credential:appleIDCredential)
            
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            
            self.appleSignIn(credential:passwordCredential)
            
        }
        
    }
    
    // Apple Sign in Api Method
    @available(iOS 13.0, *)
    func appleSignIn(credential:Any){
        
        var parameters = [String:Any]()
        if let credential = credential as?  ASAuthorizationAppleIDCredential {
                    parameters = [ "name":credential.fullName?.familyName ?? "","email": credential.email ?? "","account_type": "Apple", "social_id": credential.user ]
                    print(credential.user)
                }
                else {
                    let cred = credential as! ASPasswordCredential
                    parameters = [
                        "user_type": "Apple",
                        "social_Id": cred.user]
                }
        Console.log("appleSignIn\(parameters)")
        SocialLoginFun(params: parameters)
    }
    
}

//**********************************************************************************

//************************************MARK:- fACEBOOK LOGIN
extension  FPLoginVC {
        
    //MARK:- facebook sign in method
    func facebookLoginAction() {
        let loginManager = LoginManager()
        loginManager.logOut()
        loginManager.logIn(permissions: ["public_profile","email"], from: self) { (result, error) in
            
            guard let result = result else {
                Console.log("No result found")
                return
            }
            if result.isCancelled {
                Console.log("Cancelled \(error?.localizedDescription ?? "")")
            } else if let error = error {
                Console.log("Process error \(error.localizedDescription)")
            } else {
                self.getFBUserData()
            }
        }
    }
    
    func getFBUserData(){
        if((AccessToken.current) != nil){
            GraphRequest(graphPath: "me", parameters: ["fields": "id,name,first_name, last_name ,picture.type(large), email, gender"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as! [String : AnyObject]
                    Console.log(self.dict)
                    let _ = self.dict["id"] as? String
                    print(result)
                    self.loginWithFbAPI()
                }
               
            })
           
        }
    }
    
    func loginWithFbAPI(){
        if let id = self.dict["id"] as? String{
            facebookLoginApi(facebookId: id)
        }
    }
    
    
    // Facebook Sign in Api Method
    func facebookLoginApi(facebookId: String) {
        
        let parameters =  ["name": dict["name"] ?? "", "email": dict["email"] ?? "", "account_type": "Facebook", "social_id": dict["id"] ?? ""] as [String:Any]
        print(parameters)
        Console.log("FacebookSignIn \(parameters)")
        SocialLoginFun(params: parameters)

    }
}
