//
//  FPPreviewVC.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 23/02/22.
//

import UIKit
import Kingfisher

class FPPreviewVC: UIViewController {

    @IBOutlet weak var buttonUserBlock: UIButton!
    @IBOutlet weak var buttonReportFlag: UIButton!
    @IBOutlet weak var labelSelectThumbs: UILabel!
    @IBOutlet weak var buttonDislike: UIButton!
    @IBOutlet weak var buttonLike: UIButton!
    @IBOutlet weak var viewLikeDislikeShadow: UIView!
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var viewInternal: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var buttonBack: UIButton!
    var urlStr = ""
    var imgCollection = ["postImgs","postImgs","postImgs"]
    var currentSelectedIndex:Int? = 0
    var otherPostModel:OtherPostModel?
    var phoneNumber = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        configurePageControl()
        imageProfile.isHidden = true
        self.viewLikeDislikeShadow.addshad(shadowColor: Color.appLightGray1, opacity: 0.8, offSet: CGSize(width: 0, height: 20.0), radius: 10.0, scale: true)
        setupApperance()

        //MARK:-REGISTER COLLECTION VIEW CELL
        let nibCell = UINib(nibName: "FPHomeVCCollectionViewCell", bundle: nil)
        myCollectionView.register(nibCell, forCellWithReuseIdentifier: "FPHomeVCCollectionViewCell")
        let obj  = urlStr.components(separatedBy: "/").last ?? ""
        let token = obj.components(separatedBy: "?").first ?? ""
  
        let string = urlStr
        let component = URLComponents(string: string)
        let items = component?.queryItems?.first
        phoneNumber = items?.value ?? ""
        postViewForOther(token: token, index: 0)
        
    }
    
    func setupApperance() {
        labelSelectThumbs.style(fontType: FontType.GoldplaySemiBold, fontSize: .size18, textColor: Color.appDarkGray)
        labelName.style(fontType: FontType.GoldplaySemiBold, fontSize: .size18, textColor: Color.appDarkGray)
        labelSelectThumbs.text = "Select Check Mark To Vote On\n The Best Photo"
        viewLikeDislikeShadow.backgroundColor = Color.appWhite
        viewInternal.layer.cornerRadius = viewInternal.frame.height/45
        viewInternal.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        myCollectionView.layer.cornerRadius = myCollectionView.frame.height/30
        myCollectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        buttonBack.addTarget(self, action: #selector(buttonBackAction), for: .touchUpInside)
        //viewInternal.backgroundColor = Color.appLightGray
        
        
    }
    
    @objc func buttonBackAction(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    //MARK:- CONFIGURE PAGE CONTROL
    func configurePageControl() {
        
        let scale: CGFloat = 1.0
        pageControl.transform = CGAffineTransform(scaleX: scale, y: scale)
        pageControl.numberOfPages = imgCollection.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = Color.appFPBlue3
        pageControl.pageIndicatorTintColor = Color.appGray
       // pageControl.centerXAnchor.constraint(equalTo: myCollectionView.centerXAnchor).isActive = true
        //pageControl.bottomAnchor.constraint(equalTo: myCollectionView.safeAreaLayoutGuide.bottomAnchor, constant: 2).isActive = true
        //myCollectionView.addSubview(pageControl)
        // myCollectionView.bringSubviewToFront(pageControl)
        
    }
  
    
    //MARK:- SCROLL VIEW DID END DECELERATING / ROUND FOR CONTENT OFF SET
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}


struct OtherPostModel : Decodable {
    var status:Int?
    var message:String?
    var data:OtherPostData?
}

struct OtherPostData : Decodable {
    var post:PostData?
    var message:String?
    var data:PostData?
}

struct PostData : Decodable {
    var images:[ImageInfo]?
    var user:UserInfo?
    var id:Int?
    var userId:Int?
   // var upVote:Int?
    var completed:Int?
    //var downVote:Int?
    var is_reported:Int?
}


struct ImageInfo : Decodable {
    var path:String?
    var id:Int?
    var postId:Int?
}

struct UserInfo:Decodable {
    var name:String?
    var profilePic:String?
}

