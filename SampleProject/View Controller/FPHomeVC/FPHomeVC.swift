//
//  FPHomeVC.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 03/02/22.
//

import UIKit
import Photos
import AVFoundation
import AVKit
import Kingfisher

class FPHomeVC: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var labelNotificationCount: UILabel!
    @IBOutlet weak var labelFriendPic: UILabel!
    @IBOutlet weak var labelHangOnYourFrdVoting: UILabel!
    @IBOutlet weak var buttoncross: UIButton!
    @IBOutlet weak var buttonNotification: UIButton!
    @IBOutlet weak var viewInternal: UIView!
    @IBOutlet weak var viewForEmptyPicture: UIView!
    @IBOutlet weak var labelPictureNotAbailabel: UILabel!
    
    @IBOutlet weak var viewFlotyBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewFloatyButton: Floaty!
   // var floaty = Floaty()
    
    var config1 = YPImagePickerConfiguration()
    var config2 = YPImagePickerConfiguration()
    var imgCollection = ["homeimg","homeimg","homeimg"]
    var getImageData:GetDashboardImageModel?
    var fromHomeScr = false
    var indexvalue:Int = 0
    var imageURL = String()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
                                    #selector(refreshPage(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = Color.appWhite
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        floatyBtn()
        viewFloatyButton.respondsToKeyboard = false
        setupApperance()
        kAppDelegate.subscriptionDetail()
        viewForEmptyPicture.isHidden = false
        labelHangOnYourFrdVoting.isHidden = true
        myTableView.isScrollEnabled = false
        myTableView.refreshControl = refreshControl
        //USE NOTIFICATION CENTER

        NotificationCenter.default.addObserver(self, selector:#selector(updatedSharedAt(notification:)), name: .sharedAt, object: nil)
        //MARK:-REGISTER TABLE VIEW CELL
        myTableView.register(UINib(nibName: "FPHomeVCTableViewCell", bundle: nil), forCellReuseIdentifier: "FPHomeVCTableViewCell")
        
        if let url = kUserDefaults.string(forKey: "shareUrlStr") {
            kAppDelegate.handleShareUrl(shareUrlStr: url)
        }
        kAppDelegate.updateTokenToServer()
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshHomeData), name: Notification.Name("refreshHomeData"), object: nil)
        setNotificationBadgeCount()
        // Do any additional setup after loading the view.
       // NotificationCenter.default.post(name: .shareImageURL, object: nil,userInfo: ["shareImageURL":model.data?.shareable?.first?.link ?? ""])
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updatedSharedAt), name:.shareImageURL, object: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getImage()
        if kAppDelegate.showPremiumPopup == true{
            showPopupin3rdLoginAttempt()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewFloatyButton.close()
    }
    
    func showPopupin3rdLoginAttempt(){
        let popupVC = FPCommonPopUpVC.instantiate(fromAppStoryboard: .registration)
        popupVC.modalTransitionStyle = .crossDissolve
        popupVC.modalPresentationStyle = .custom
        popupVC.popupType = .atEvery3rdLoginAttempt
        popupVC.delegate = self
        self.present(popupVC, animated: true, completion: nil)
    }
    //MARK: REFRESH MY ALBUM DESCRIPTION
    @objc func refreshPage(_ refreshControl: UIRefreshControl) {
        getImage()
        refreshControl.endRefreshing()
        
    }
    
    @objc func refreshHomeData() {
        getImage()
    }
    
    @objc func updatedSharedAt(notification:Notification) {
     
        guard let shareImageURL =  (notification.userInfo as? [String: AnyObject])?["shareImageURL"] as? String   else {
            return
        }
        
        imageURL = shareImageURL
        
      }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        myTableView.layer.cornerRadius = myTableView.frame.height/30
        myTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            self.viewFlotyBottomConstraint.constant = 20
        })
        labelNotificationCount.makeRounded()
    }
    
    //MARK:- VIEW WILL APPER
    
    func floatyBtn()
    {
        
        //let floaty = Floaty()
    
        viewFloatyButton.buttonColor = Color.appFPBlue
        viewFloatyButton.dropShadow1()
        
        viewFloatyButton.addItem("Camera", icon: UIImage(named: "cameraas")!, handler: { _ in
            self.config1.screens = [.photo]
            self.config1.library.options = nil
            self.config1.library.onlySquare = false
            self.config1.library.isSquareByDefault = true
            self.config1.library.minWidthForItem = nil
            self.config1.library.mediaType = YPlibraryMediaType.photo
            self.config1.library.defaultMultipleSelection = false
            self.config1.library.maxNumberOfItems = 1
            self.config1.library.minNumberOfItems = 1
            self.config1.library.numberOfItemsInRow = 4
            self.config1.library.spacingBetweenItems = 1.0
            self.config1.library.skipSelectionsGallery = false
            self.config1.library.preselectedItems = nil
            self.config1.showsCrop = .rectangle(ratio: 1.0)
            
            let picker = YPImagePicker(configuration: self.config1)
            if #available(iOS 13.0, *) {
                let navBarAppearance = UINavigationBarAppearance()
                navBarAppearance.configureWithOpaqueBackground()
                picker.navigationBar.scrollEdgeAppearance = navBarAppearance
            } else {
                // Fallback on earlier versions
            }
            picker.didFinishPicking { [unowned picker] items, _ in
                
                if items.count != 0 {
                    self.imageItemUpload(items: items)
                }
                picker.dismiss(animated: true, completion: nil)
            }
            self.present(picker, animated: true, completion: nil)
            
        })
        
        viewFloatyButton.addItem("Gallery", icon: UIImage(named: "galery")! , handler: { _ in
            self.config2.screens = [.library]
            self.config2.library.options = nil
            self.config2.library.onlySquare = false
            self.config2.library.isSquareByDefault = true
            self.config2.library.minWidthForItem = nil
            self.config2.library.mediaType = YPlibraryMediaType.photo
            self.config2.library.defaultMultipleSelection = true
            self.config2.library.maxNumberOfItems = 3
            self.config2.library.minNumberOfItems = 1
            self.config2.library.numberOfItemsInRow = 4
            self.config2.library.spacingBetweenItems = 1.0
            self.config2.library.skipSelectionsGallery = false
            self.config2.library.preselectedItems = nil
            self.config2.showsCrop = .rectangle(ratio: 1.0)
            //self.config2.showsCrop = .rectangle(ratio: 1.0)
            self.config2.gallery.hidesRemoveButton = false

            
            let picker = YPImagePicker(configuration: self.config2)
            if #available(iOS 13.0, *) {
                let navBarAppearance = UINavigationBarAppearance()
                navBarAppearance.configureWithOpaqueBackground()
                picker.navigationBar.scrollEdgeAppearance = navBarAppearance
            } else {
                // Fallback on earlier versions
            }
            picker.didFinishPicking { [unowned picker] items, _ in

                if items.count != 0 {
                    self.imageItemUpload(items: items)
                }
                
                picker.dismiss(animated: true, completion: nil)
            }
            //self.present(picker, animated: true, completion: nil)
            self.showSheetForMultipleSelection(self, picker: picker)
            
        })
        
        viewFloatyButton.items.forEach { item in
            
            item.buttonColor = Color.appFPBlue
        }
       // self.buttonAddImage.addSubview(viewFloatyButton)
        
    }

    func showSheetForMultipleSelection(_ viewController: UIViewController, allowsEditing: Bool = true,picker: YPImagePicker) {
        
      //  imagePicker.allowsEditing = allowsEditing
      //  self.allowsEditing = allowsEditing
        
        
        let alert = UIAlertController(title: "Choose Option", message: "", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Allow app to access photo album", style: .default, handler: {(action: UIAlertAction) in
            self.openAppSettings()
        }))
        
        alert.addAction(UIAlertAction(title: "Choose Pictures", style: .default, handler: {(action: UIAlertAction) in
           // self.openPhotoLibrary(mediaType:.image,viewController:viewController)
            print("open previous selected")
            self.present(picker, animated: true, completion: nil)
        }))
        
        //        alert.addAction(UIAlertAction(title: "Choose Videos", style: .default, handler: {(action: UIAlertAction) in
        //
        //            //self.capturePhotoFromCamera(viewController, type: .image)
        //        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        if UIDevice.current.userInterfaceIdiom == .pad {
//            viewController.addActionSheetForiPad(actionSheet: alert)
//        }
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func openAppSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        }
    }
    
    func setupApperance() {
        
        //        buttonAddImage.addTarget(self, action: #selector(showPicker), for: .touchUpInside)
        
        labelFriendPic.style(fontType:FontType.GoldplaySemiBold, fontSize: .size20, textColor: Color.appWhite)
        labelHangOnYourFrdVoting.style(fontType:FontType.GoldplaySemiBold, fontSize: .size18, textColor: Color.appDarkGray)
        labelPictureNotAbailabel.style(fontType:FontType.GoldplaySemiBold, fontSize: .size30, textColor: Color.appBlack)
        viewForEmptyPicture.backgroundColor = Color.appWhite
        viewForEmptyPicture.layer.cornerRadius = viewForEmptyPicture.frame.height/45
        viewForEmptyPicture.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewInternal.layer.cornerRadius = viewInternal.frame.height/45
        viewInternal.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        labelNotificationCount.style(fontType: .GoldplayMedium, fontSize: .size14, textColor: .white)
        labelNotificationCount.backgroundColor = .red

    }
    
    //MARK:- CONFIGURE PAGE CONTROL
/*    func configurePageControl() {
        
        let scale: CGFloat = 1.0
        pageControl.transform = CGAffineTransform(scaleX: scale, y: scale)
        //pageControl.numberOfPages = getImageDta?.data?.count ?? 0//imgCollection.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = Color.appFPBlue3
        pageControl.pageIndicatorTintColor = Color.appGray
        pageControl.centerXAnchor.constraint(equalTo: myCollectionView.centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: myCollectionView.safeAreaLayoutGuide.bottomAnchor, constant: 2).isActive = true
        myCollectionView.addSubview(pageControl)
        // myCollectionView.bringSubviewToFront(pageControl)
        
    }
    
    //MARK:- SCROLL VIEW DID END DECELERATING / ROUND FOR CONTENT OFF SET
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
    */
    
    //MARK:-  TO IMAGE UPLOAD
    func imageItemUpload(items: [YPMediaItem]) {
        
        var multiPart = [MultiPart]()
        
        
        for item in items {
                switch item {
                case .photo(let photo):
                    
                    if let image =  (self.resizeImage(image: photo.image, targetSize: CGSize(width: 600.0, height: 600.0))) {
                    
                        if let data = image.jpegData(compressionQuality: 1.0) {
                        multiPart.append(MultiPart(data: data, fileNameWithExt: "image.png", serverKey: "images[]", mimeType: .image))
                        print(photo)
                        print("Image Size\(data)")
                        }
                    }
                    else {
                    DisplayBanners.show(message: NSLocalizedString("Maximum image size should be 10 mb.", comment: ""))
                    return
                    }
                    
                
                case .video(let video):
                    print(video)
                }
            }
        self.imageUpload(params: ["images[]":multiPart])
    }
    
    
  //MARK:- TO SHOW HOME SCREEN IF IMAGE IS AVAILABLE OR HIDE HOME SCREEN WITH BLANK SCREEN IF THERE IS NO IMAGES
    func showHideView() {
        
        if getImageData?.data?.images.isEmpty == true {
            
            viewForEmptyPicture.isHidden = false
        }
        else {
            viewForEmptyPicture.isHidden = true
        }
    }
    
 // MARK:- RESIZE OF SELECTED IMAGE TO UPLOAD
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}



