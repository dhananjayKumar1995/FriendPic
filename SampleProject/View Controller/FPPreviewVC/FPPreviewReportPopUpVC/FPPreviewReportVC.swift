//
//  FPPremiumReportVC.swift
//  SampleProject
//
//  Created by MC-MM0012 on 06/06/22.
//

import UIKit

protocol IsReporedDelegate{
    func isRepored(isReported:Int)
}
class FPPreviewReportVC: UIViewController {

    @IBOutlet weak var reportTextView: GrowingTextView!
    @IBOutlet weak var buttonCencel: UIButton!
    @IBOutlet weak var buttonSubmit: UIButton!
    @IBOutlet weak var viewDialogBox: UIView!
    @IBOutlet weak var labelReport: UILabel!
    
    var postId:Int?
    var delegate:IsReporedDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupapperence()
        // Do any additional setup after loading the view.
    }
    
    func setupapperence(){
        reportTextView.placeholder = "Enter your reason..."
        reportTextView.placeholderColor = Color.appGray
        reportTextView.minHeight = 110
        reportTextView.maxHeight = 110
        labelReport.style(fontType: FontType.GoldplayBold, fontSize: .size18, textColor: Color.appDarkGray)
        reportTextView.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appLightBlack)
        buttonSubmit.style(fontType: FontType.GoldplaySemiBold, fontSize: FontSize.size16, textColor: Color.appWhite)
        viewDialogBox.layer.cornerRadius = viewDialogBox.layer.frame.height/18
    }

}
