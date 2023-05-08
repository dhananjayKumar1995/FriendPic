//
//  SCPreviewPhotoCollectionCell.swift
//  Shift
//
//  Created by Mobilecoderz1 on 07/08/19.
//  Copyright © 2019 Mobilecoderz. All rights reserved.
//

import UIKit

class FPPreviewPhotoCollectionCell: UICollectionViewCell, Reusable {
    @IBOutlet weak var imageViewPhoto: UIImageView!
    
    @IBOutlet weak var imageViewBckgrounImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        scrollView.delegate = self
        scrollView.maximumZoomScale = 2.0
    }

}
extension FPPreviewPhotoCollectionCell: UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageViewPhoto
    }
}
