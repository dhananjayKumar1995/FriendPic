//
//  FPTermConditionVC.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 24/02/22.
//

import UIKit
import PromiseKit
import WebKit
import Kingfisher

enum  WebViewState {
    
    case termsAndCondition
    case privacyPolicy
}

class FPTermConditionVC: UIViewController, WKNavigationDelegate {
    
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var viewInternal: UIView!
    @IBOutlet weak var labelTermCondition: UILabel!
    @IBOutlet weak var buttonBack: UIButton!
    
    var currentState : WebViewState = .termsAndCondition
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData(currentState: currentState)
        webView.navigationDelegate = self
        setupApperence()
       
    }
    
    func setupData(currentState:WebViewState) {
        
        switch currentState {
        case .termsAndCondition:
            termCondition()
        case .privacyPolicy:
            privacyPolicy()
        }
    }
    
    @IBAction func buttonBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupApperence() {
        
        labelTermCondition.style(fontType: FontType.GoldplaySemiBold, fontSize: .size20, textColor: Color.appWhite)
        viewInternal.layer.cornerRadius = viewInternal.frame.height/45
        viewInternal.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
}

extension FPTermConditionVC {
    
    func termCondition(){
    
            labelTermCondition.text = "Terms and Conditions"
            guard let url = URL(string: "http://35.154.184.209/terms-and-conditions") else {
                return
            }
            webView.load(URLRequest(url: url))
    }
    
    func privacyPolicy() {
        
        labelTermCondition.text = "Privacy Policy"
        guard let url = URL(string: "http://35.154.184.209/privacy-policy") else {
            return
        }
        webView.load(URLRequest(url: url))
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        Loader.show()//Show loader
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        Loader.hide()//Hide loader
    }
}
struct urlType{
    static let termsCondition = "http://35.154.184.209/terms-and-conditions"
    static let privacyPolicy = "http://35.154.184.209/privacy-policy"

    
}
