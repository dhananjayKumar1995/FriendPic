//
//  FPHomeVCTableViewCell.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 08/04/22.
//

import UIKit

class FPHomeVCTableViewCell: UITableViewCell {

    @IBOutlet weak var buttonShare: UIButton!
    @IBOutlet weak var labelCountDislike: UILabel!
    @IBOutlet weak var buttonDislike: UIButton!
    @IBOutlet weak var labelCountLike: UILabel!
    @IBOutlet weak var buttonLike: UIButton!
    @IBOutlet weak var viewLikeDislike: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var viewShadow: UIView!
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var viewCollection: UIView!
    @IBOutlet weak var viewInternal: UIView!
    @IBOutlet weak var viewRefreshPage: UIView!
    @IBOutlet weak var btnRefreshPage: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupApperance()
        configurePageControl()
        //MARK:-REGISTER COLLECTION VIEW CELL
        let nibCell = UINib(nibName: "FPHomeVCCollectionViewCell", bundle: nil)
        myCollectionView.register(nibCell, forCellWithReuseIdentifier: "FPHomeVCCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupApperance() {
        
        viewRefreshPage.backgroundColor = Color.appFPBlue1
        viewRefreshPage.layer.cornerRadius = viewRefreshPage.layer.frame.height/5
        btnRefreshPage.style(fontType: FontType.GoldplaySemiBold, fontSize: .size15, textColor: Color.appWhite,backgroundColor: .clear)
        
        buttonShare.backgroundColor = Color.appFPBlue
        buttonShare.layer.cornerRadius = buttonShare.layer.frame.height/5
        buttonShare.style(fontType: FontType.GoldplaySemiBold, fontSize: .size15, textColor: Color.appWhite,backgroundColor: Color.appFPBlue1)
        labelCountLike.style(fontType:FontType.GoldplayMedium, fontSize: .size16, textColor: Color.appFPBlue1)
        labelCountDislike.style(fontType:FontType.GoldplayMedium, fontSize: .size16, textColor: Color.appFPRed)
     
        myCollectionView.layer.cornerRadius = myCollectionView.frame.height/15
        myCollectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        myCollectionView.backgroundColor = Color.appWhite
        viewCollection.backgroundColor = Color.appWhite
        viewInternal.backgroundColor = Color.appWhite
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
    
}
