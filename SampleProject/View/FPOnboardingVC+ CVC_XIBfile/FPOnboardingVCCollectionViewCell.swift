//
//  FPOnboardingVCCollectionViewCell.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 22/03/22.
//

import UIKit

class FPOnboardingVCCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var viewInternal: UIView!
    
    @IBOutlet weak var leadingConsImage: NSLayoutConstraint!
    @IBOutlet weak var LabelDescription: UILabel!
    @IBOutlet weak var imageCollection: UIImageView!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
        LabelDescription.style(fontType:FontType.GoldplayMedium, fontSize: .size16, textColor: Color.appDarkGray)
    }

}
