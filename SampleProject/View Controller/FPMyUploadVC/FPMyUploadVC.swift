//
//  FPMyUploadVC.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 16/02/22.
//

import UIKit
import CoreMedia
import Photos
import Alamofire
import SwiftUI

enum LoadingState{
    case refresh
    case nextPage
}
enum ActionState{
    case download
    case uploadToInsta
}
class FPMyUploadVC: UIViewController, UIDocumentInteractionControllerDelegate {
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var viewInternal: UIView!
    @IBOutlet weak var labelMyupload: UILabel!
    @IBOutlet weak var viewRoot: UIView!
    
    @IBOutlet weak var labelEmpty: UILabel!
    @IBOutlet weak var viewEmptyPicture: UIView!
    var getImageData1:GetAllPostModel?
    var selectedIndex:Int = 0
    var currentPageNo = 1
    var currentLoadingState: LoadingState = .refresh
    var isLoading = false
    var imgUrl:URL?
    var saveimageType:SaveImageInPhotoLibrary = .instagramUpload
    var indexPath:IndexPath?
    var uploadInstatype = 0
    var currentState: ActionState = .download
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
                                    #selector(handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = Color.appDarkBlue
        return refreshControl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllPostPagination(pageNo: currentPageNo, loadingState: .refresh)
        setupTableView()
        setupApperance()
        viewEmptyPicture.isHidden = false
        // Do any additional setup after loading the view.
        
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
        currentPageNo = 1
        getAllPostPagination(pageNo: currentPageNo, loadingState: .refresh)
    }
    func getAllPostPagination(pageNo: Int, loadingState: LoadingState){
        currentLoadingState = loadingState
        if !isLoading{
            getAllPost(showLoader: loadingState == .refresh)

        }
    }
    
    func setupTableView() {
        //MARK:-REGISTER TABLE VIEW CELL
        myTableView.register(UINib(nibName: "FPMyUploadVCTableViewCell", bundle: nil), forCellReuseIdentifier: "FPMyUploadVCTableViewCell")
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        myTableView.backgroundColor = Color.appWhite
        myTableView.refreshControl = refreshControl
    }
    func setupApperance() {
        
        labelMyupload.style(fontType:FontType.GoldplaySemiBold, fontSize: .size20, textColor: Color.appWhite)
        labelEmpty.style(fontType: FontType.GoldplayMedium, fontSize: .size18, textColor: Color.appLightGray)
        viewInternal.layer.cornerRadius = viewInternal.frame.height/45
        viewInternal.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewEmptyPicture.backgroundColor = Color.appWhite
        viewEmptyPicture.layer.cornerRadius = viewEmptyPicture.frame.height/45
        viewEmptyPicture.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        myTableView.layer.cornerRadius = myTableView.frame.height/30
        myTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        //viewInternal.backgroundColor = Color.appLightGray
 
    }
    //*****************************************************************************************************
    
    //MARK:- TO DOWNLOAD IMAGES
    
    func downloadImage(index:Int,currentIndex:Int) {
        
        Loader.show()
        let imagestring = getImageData1?.data?.posts?.data[index].images[currentIndex].path
        
        if let url = URL(string: imagestring ?? "") {
            imgUrl = url
            var urlRequest = URLRequest(url: url)
            let token = kUserDefaults.string(forKey: "token") ?? ""
            urlRequest.httpMethod = "GET"
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
            selectedIndex = index
            print("Download Started")
            getData(from: urlRequest) { data, response, error in
                Loader.hide()
                guard let data = data, error == nil else { return }
                print(response?.suggestedFilename ?? url.lastPathComponent)
                print("Download Finished")
                
                DispatchQueue.main.async {
                    print("Image has been downloaded")
                    if let image = UIImage(data: data) {
                        // UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                        self.saveimageType = .download
                        self.saveImageIntoPhotoLibrary(image: image, type: self.saveimageType)
                    }
                }
            }
        }
    }
    func saveImageIntoPhotoLibrary(image:UIImage,type:SaveImageInPhotoLibrary) {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
               switch photoAuthorizationStatus {
               case .authorized:
                   DispatchQueue.main.async {

                   UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
                   }
               case .notDetermined:
                   PHPhotoLibrary.requestAuthorization({
                       (newStatus) in
                          
                       })
                   break
               case .restricted:
                   print("restricted")
                   break
               case .denied:
                   print("denied")
                   DispatchQueue.main.async { [weak self] in
                       self?.uploadToInstagram()
                   }
                   break
               case .limited:
                   break
               @unknown default:
                   break
               }
        
        
    }
    
    func uploadToInstagram(){
        if currentState == .uploadToInsta{
            guard let instagramUrl = URL(string: "instagram://app") else {return}
            if UIApplication.shared.canOpenURL(instagramUrl) {
                UIApplication.shared.open(instagramUrl)
                //let instaUrlStr = instagramUrl.path
            }
            else {
                DisplayBanner1.show(title: "Instagram app is not installed in your phone. Please install.")
            }
        }else{
            DisplayBanner1.show(title: "Please allow permission to save photo.")

        }
    }
    
    //MARK: - Add image to Library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let _ = error {
            // we got back an error!
            DisplayBanner1.show(title: "Save error")
        } else {
            if currentState == .uploadToInsta{
            guard let instagramUrl = URL(string: "instagram://app") else {return}
            if UIApplication.shared.canOpenURL(instagramUrl) {
                UIApplication.shared.open(instagramUrl)
                //let instaUrlStr = instagramUrl.path
            }
            else {
                DisplayBanner1.show(title: "Instagram app is not installed in your phone. Please install.")
            }
            }else{
                DisplayBanner2.show(title: "Your image has been saved to your photos.")
            }
//            if self.saveimageType == .instagramUpload {
//                if let indexPath = indexPath {
//                    self.postToInstagram(image: image, index: indexPath.item)
//                    uploadInstatype = uploadInstatype + 1
//                }
//            }
//            DisplayBanner2.show(title: "Your image has been saved to your photos.")
        }
    }
    
    //MARK:- TO GET DATA
    func getData(from urlRequest: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: urlRequest, completionHandler: completion).resume()
    
    }
    
    
    //MARK:- TO SHOW MYUPLOAD SCREEN IF IMAGE IS AVAILABLE OR HIDE MYUPLOAD SCREEN WITH BLANK SCREEN IF THERE IS NO IMAGES
      func showHideView() {
          
          if getImageData1?.data?.posts?.data.isEmpty == true{
              
              viewEmptyPicture.isHidden = false
          }
          else {
              viewEmptyPicture.isHidden = true
          }
      }
    
}




//extension FPMyUploadVC {
//
//    class InstagramManager: NSObject, UIDocumentInteractionControllerDelegate {
//
//        private let kInstagramURL = "instagram://"
//        private let kUTI = "com.instagram.exclusivegram"
//        private let kfileNameExtension = "instagram.igo"
//        private let kAlertViewTitle = "Error"
//        private let kAlertViewMessage = "Please install the Instagram application"
//
//        var documentInteractionController = UIDocumentInteractionController()
//
//        // singleton manager
//        class var sharedManager: InstagramManager {
//            struct Singleton {
//                static let instance = InstagramManager()
//            }
//            return Singleton.instance
//        }
//
//        func postImageToInstagramWithCaption(imageInstagram: UIImage, instagramCaption: String, view: UIView) {
//            // called to post image with caption to the instagram application
//
//            let instagramURL = NSURL(string: kInstagramURL)
//            if UIApplication.shared.canOpenURL(instagramURL! as URL) {
//                let jpgPath = (NSTemporaryDirectory() as NSString).appendingPathComponent(kfileNameExtension)
//                UIImageJPEGRepresentation(imageInstagram, 1.0)!.writeToFile(jpgPath, atomically: true)
//                let rect = CGRectMake(0,0,612,612)
//                let fileURL = NSURL.fileURL(withPath: jpgPath)
//                documentInteractionController.url = fileURL
//                documentInteractionController.delegate = self
//                documentInteractionController.uti = kUTI
//
//                // adding caption for the image
//                documentInteractionController.annotation = ["InstagramCaption": instagramCaption]
//                documentInteractionController.presentOpenInMenu(from: rect, in: view, animated: true)
//            }
//            else {
//
//                // alert displayed when the instagram application is not available in the device
//                UIAlertView(title: kAlertViewTitle, message: kAlertViewMessage, delegate:nil, cancelButtonTitle:"Ok").show()
//            }
//        }
//    }
//
//
//     func sendToInstagram(){
//
//         let image = postImage
//
//                 InstagramManager.sharedManager.postImageToInstagramWithCaption(image!, instagramCaption: "\(description)", view: self.view)
//
//     }
//}

class EmptyScreenView: UIView {
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return nil
    }
}


enum SaveImageInPhotoLibrary {
    case download
    case instagramUpload
}

