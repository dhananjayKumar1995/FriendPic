//
//  FPPremiumPlanVCTableViewCell.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 25/02/22.
//

import UIKit

class FPPremiumPlanVCTableViewCell: UITableViewCell {

    @IBOutlet weak var labelDoller: UILabel!
    @IBOutlet weak var labelMonth: UILabel!
    @IBOutlet weak var buttonActivatePlan: UIButton!
    @IBOutlet weak var labelPremium: UILabel!
    @IBOutlet weak var viewPopUp: UIView!
    @IBOutlet weak var viewShadow: UIView!
    @IBOutlet weak var labelInvite5People: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
        viewShadow.addshad(shadowColor: Color.appLightGray1, opacity: 1.5, offSet: CGSize(width: -25.0, height: 30.0), radius: 15.0, scale: true)
        viewShadow.layer.shadowPath = UIBezierPath(rect: UIScreen.main.bounds).cgPath
        viewShadow.layer.shouldRasterize = true
        viewShadow.layer.rasterizationScale = UIScreen.main.scale
        setupApperence()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    override func layoutSubviews() {
//          super.layoutSubviews()
//          //set the values for top,left,bottom,right margins
//          let margins = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
//          contentView.frame = contentView.frame.inset(by: margins)
//          //contentView.layer.cornerRadius = 8
//    }
    
    func setupApperence() {
       
        labelPremium.style(fontType: FontType.GoldplaySemiBold, fontSize: .size18, textColor: Color.appWhite)
        labelDoller.style(fontType: FontType.GoldplayBold, fontSize: .size28, textColor: Color.appWhite)
        labelInvite5People.style(fontType: FontType.GoldplaySemiBold, fontSize: .size18, textColor: Color.appBlack)
        labelMonth.style(fontType: FontType.GoldplaySemiBold, fontSize: .size18, textColor: Color.appWhite)
        buttonActivatePlan.style(fontType: FontType.GoldplaySemiBold, fontSize: .size16, textColor: Color.appWhite)
        viewShadow.backgroundColor = Color.appWhite
        viewPopUp.backgroundColor = Color.appWhite
        viewShadow.layer.cornerRadius = viewShadow.frame.height/8
        viewShadow.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
    }
}
