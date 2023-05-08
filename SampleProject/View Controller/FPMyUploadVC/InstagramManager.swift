//
//  InstagramManager.swift
//  InstagramSDK
//
//  Created by Dhananjay kumar on 23/03/22.
//  share image with caption to instagram

import Foundation
import UIKit
import CloudKit
import Photos
import CoreMedia

import Alamofire

//let documentInteractionController = UIDocumentInteractionController()

class InstagramManager: NSObject, UIDocumentInteractionControllerDelegate {
    
    private let documentInteractionController = UIDocumentInteractionController()
    private let kInstagramURL = "instagram://app"//"instagram://"
    private let kUTI = "com.instagram.exclusivegram" //"com.instagram.exclusivegram"
    private let kfileNameExtension = "instagram.ig"//"instagram.igo"
    private let kAlertViewTitle = "Error"
    private let kAlertViewMessage = "Please install the Instagram application"
    
    var getImageData1:GetAllPostModel?
    var selectedIndex:Int = 0
    
    // singleton manager
    class var sharedManager: InstagramManager {
        struct Singleton {
            static let instance = InstagramManager()
        }
        return Singleton.instance
    }
    
    func postImageToInstagram(imageInstagram: UIImage,index:Int,currentIndex:Int, view: UIView) {
        // called to post image with caption to the instagram application
        
        //let imagestring = getImageData1?.data?.posts?.data[index].images[currentIndex].path
       // let url = URL(string: imagestring ?? "")
        let instagramURL = NSURL(string: kInstagramURL)
        
        selectedIndex = index
        if UIApplication.shared.canOpenURL(instagramURL! as URL) {
            let jpgPath = (NSTemporaryDirectory() as NSString).appendingPathComponent(kfileNameExtension)
            
            do {
                
                try imageInstagram.jpegData(compressionQuality: 0.75)?.write(to: URL(fileURLWithPath: jpgPath), options: .atomic)//imagestring
                
            } catch {
                print(error)
            }

            let rect = CGRect.zero
            let fileURL = NSURL.fileURL(withPath: jpgPath)
            
            
            documentInteractionController.url = fileURL
            documentInteractionController.delegate = self
            documentInteractionController.uti = kUTI

            // adding caption for the image
           // documentInteractionController.annotation = ["InstagramCaption": instagramCaption]
            documentInteractionController.presentOpenInMenu(from: rect, in: view, animated: true)
        }
        else {
            
            // alert displayed when the instagram application is not available in the device
            //UIAlertView(title: kAlertViewTitle, message: kAlertViewMessage, delegate:nil, cancelButtonTitle:"Ok").show()
            DisplayBanner1.show(title: kAlertViewMessage)
    
        }
    }
}


