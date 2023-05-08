//
//  FPOnboardingVC.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 18/01/22.
//

import UIKit
import AdvancedPageControl

//MARK:- SCREEN RATIO
//*******************************************************

let screenHeightFactor  = UIScreen.main.bounds.height/896
let screenWidthFactor   = UIScreen.main.bounds.width/414

class FPOnboardingVC: UIViewController {
    
    @IBOutlet weak var pageControls: AdvancedPageControlView!
    @IBOutlet weak var buttonSkip: UIButton!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var viewCollectionView: UIView!
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    //MARK:- VARIABLES
    let onboardingImage = ["1_onboarding","2_onboarding","3_onboarding"]
    let onboardingLabel = ["Select friends to vote on your best photos before them uploading onto social media.","Receive friends votes within minutes.","Share Highest Voted photo With The World!"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK:-REGISTER COLLECTION VIEW CELL
        let nibCell = UINib(nibName: "FPOnboardingVCCollectionViewCell", bundle: nil)
        myCollectionView.register(nibCell, forCellWithReuseIdentifier: "FPOnboardingVCCollectionViewCell")
        pageControls.drawer = ExtendedDotDrawer(numberOfPages: 3,height: 10,width: 10,
                                                space: 5.0,raduis: 5.0,
                                                indicatorColor: Color.appFPBlue1,
                                                dotsColor: Color.appFPBlue2,
                                                isBordered: false,
                                                borderWidth: 0.0,
                                                indicatorBorderColor: .clear,
                                                indicatorBorderWidth: 0.0)
        
        // buttonBack.isHidden = true
        setupApperance()
        // Do any additional setup after loading the view.
        
    }
    
    func setupApperance() {
        //buttonNext.style(fontType:FontType.segoeUIBold, fontSize: .size25, textColor: Color.appWhite, textStyle: .subheadline,backgroundColor: Color.appDimLightBlue)
        //buttonNext.layer.cornerRadius = buttonNext.frame.height/2 * screenHeightFactor
        
        buttonNext.style(fontType: FontType.GoldplaySemiBold, fontSize: .size20, textColor: Color.appWhite)
        buttonSkip.style(fontType:FontType.GoldplaySemiBold, fontSize: .size15, textColor: Color.appWhite)
        viewCollectionView.layer.cornerRadius = viewCollectionView.frame.height/45
        viewCollectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        pageControls.setPageOffset(offSet / width)
    }
}





