//
//  FPSettingVCTableViewCell.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 16/02/22.
//

import UIKit

class FPSettingVCTableViewCell: UITableViewCell {
    @IBOutlet weak var viewInternal: UIView!
    @IBOutlet weak var imageNextArrow: UIImageView!
    @IBOutlet weak var labelTableCell: UILabel!
    @IBOutlet weak var imageTableCell: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupApperance()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupApperance() {
        
        labelTableCell.style(fontType:FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appDarkGray)
        
        
    }
    
}
