//
//  FPMyUploadVCTableViewCell.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 23/02/22.
//

import UIKit
import Kingfisher

class FPMyUploadVCTableViewCell: UITableViewCell {

    @IBOutlet weak var viewInternal: UIView!
    @IBOutlet weak var viewLikeDislike: UIView!
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var viewCollection: UIView!
    @IBOutlet weak var buttonLike: UIButton!
    @IBOutlet weak var buttonDislike: UIButton!
    @IBOutlet weak var labelLikeCount: UILabel!
    @IBOutlet weak var labelDislikeCount: UILabel!
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var viewShadow: UIView!
    @IBOutlet weak var buttonDelete: UIButton!
    @IBOutlet weak var labelDateTime: UILabel!
    @IBOutlet weak var buttonUploadToInata: UIButton!
    @IBOutlet weak var buttonDownload: UIButton!
    
    var getImageData1:GetAllPostModel?
    var imgCollection = ["homeimg","homeimg","homeimg"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupApperance()
        configurePageControl()
        
        self.viewCollection.addshad(shadowColor: Color.appLightGray1, opacity: 0.8, offSet: CGSize(width: -18.0, height: 0.0), radius: 10.0, scale: true)
        viewCollection.layer.shadowPath = UIBezierPath(rect: UIScreen.main.bounds).cgPath
        viewCollection.layer.shouldRasterize = true
        viewCollection.layer.rasterizationScale = UIScreen.main.scale
      
        //MARK:-REGISTER COLLECTION VIEW CELL
        let nibCell = UINib(nibName: "FPHomeVCCollectionViewCell", bundle: nil)
        myCollectionView.register(nibCell, forCellWithReuseIdentifier: "FPHomeVCCollectionViewCell")
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
          super.layoutSubviews()
          //set the values for top,left,bottom,right margins
//          let margins = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
//          contentView.frame = contentView.frame.inset(by: margins)
//    //      contentView.layer.cornerRadius = 8
    }
    
    func setupApperance() {
        
        labelLikeCount.style(fontType:FontType.GoldplayMedium, fontSize: .size16, textColor: Color.appFPBlue1)
        labelDislikeCount.style(fontType:FontType.GoldplayMedium, fontSize: .size16, textColor: Color.appFPRed)
        labelDateTime.style(fontType:FontType.GoldplayMedium, fontSize: .size13, textColor: Color.appLightGray3)
        buttonUploadToInata.style(fontType:FontType.GoldplayMedium, fontSize: .size13, textColor: Color.appFPBlue1)

        myCollectionView.layer.cornerRadius = myCollectionView.frame.height/15
        myCollectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        viewLikeDislike.layer.cornerRadius = viewLikeDislike.frame.height/8
        viewLikeDislike.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        myCollectionView.backgroundColor = .none
        viewCollection.backgroundColor = .none
        viewInternal.backgroundColor = .none
        viewLikeDislike.backgroundColor = Color.appWhite
  
    }
    
    
    //MARK:- CONFIGURE PAGE CONTROL
    func configurePageControl() {
        
        let scale: CGFloat = 1.0
        pageControl.transform = CGAffineTransform(scaleX: scale, y: scale)
       // pageControl.numberOfPages = imgCollection.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = Color.appFPBlue3
        pageControl.pageIndicatorTintColor = Color.appGray
        pageControl.centerXAnchor.constraint(equalTo: myCollectionView.centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: myCollectionView.safeAreaLayoutGuide.bottomAnchor, constant: 2).isActive = true
        viewShadow.addSubview(pageControl)
        // myCollectionView.bringSubviewToFront(pageControl)
        
    }
 
    //MARK:- SCROLL VIEW DID END DECELERATING / ROUND FOR CONTENT OFF SET
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
//        pageControl.currentPage = Int(pageNumber)
//    }
    
}

extension CALayer {
  func applySketchShadow(
    color: UIColor = .black,
    alpha: Float = 0.5,
    x: CGFloat = 0,
    y: CGFloat = 2,
    blur: CGFloat = 4,
    spread: CGFloat = 0)
  {
    masksToBounds = false
    shadowColor = color.cgColor
    shadowOpacity = alpha
    shadowOffset = CGSize(width: x, height: y)
    shadowRadius = blur / 2.0
    if spread == 0 {
      shadowPath = nil
    } else {
      let dx = -spread
      let rect = bounds.insetBy(dx: dx, dy: dx)
      shadowPath = UIBezierPath(rect: rect).cgPath
    }
  }
}
