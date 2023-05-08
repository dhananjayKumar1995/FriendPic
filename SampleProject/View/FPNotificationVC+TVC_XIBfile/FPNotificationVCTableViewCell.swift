//
//  FPNotificationVCTableViewCell.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 22/02/22.
//

import UIKit

class FPNotificationVCTableViewCell: UITableViewCell {

    @IBOutlet weak var viewInternal: UIView!
    @IBOutlet weak var labelDateTime: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageProfile: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpApperence()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
          super.layoutSubviews()
          //set the values for top,left,bottom,right margins
          let margins = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
          contentView.frame = contentView.frame.inset(by: margins)
          //contentView.layer.cornerRadius = 8
    }
    
    func setUpApperence() {
        
        viewInternal.layer.cornerRadius = viewInternal.frame.height/5
        viewInternal.backgroundColor = Color.appLightGray1
        labelName.style(fontType: FontType.GoldplayMedium, fontSize: .size14, textColor: Color.appDarkGray)
        labelDateTime.style(fontType: FontType.GoldplayRegular, fontSize: .size12, textColor: Color.appDarkGray)
        
    }
    
}
