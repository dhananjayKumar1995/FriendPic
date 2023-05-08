//
//  FPContactVCTableViewCell.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 18/02/22.
//

import UIKit

class FPContactVCTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewSeperator: UIView!
    @IBOutlet weak var buttonCheck: UIButton!
    @IBOutlet weak var labelMobileNo: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelProfile: UILabel!
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var viewInternal: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpApperence()
        
        buttonCheck.isSelected = true
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setUpApperence() {
        buttonCheck.setImage(UIImage(named: "emptyOkTick"), for: .normal)
        viewSeperator.backgroundColor = Color.appLightMidDarkGray
        imageProfile.image = UIImage(named: "contactProfileEmpty")
        labelProfile.style(fontType: FontType.GoldplaySemiBold, fontSize: .size22, textColor: Color.appFPBlue3)
        labelName.style(fontType: FontType.GoldplaySemiBold, fontSize: .size16, textColor: Color.appDarkGray)
        labelMobileNo.style(fontType: FontType.GoldplayMedium, fontSize: .size12, textColor: Color.appDarkGray)
    }
}
