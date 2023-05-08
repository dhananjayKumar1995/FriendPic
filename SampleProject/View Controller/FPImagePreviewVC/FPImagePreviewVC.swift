//
//  SCPreviewVC.swift
//  Shift
//
//  Created by Mobilecoderz1 on 07/08/19.
//  Copyright © 2019 Mobilecoderz. All rights reserved.
//

import UIKit

class FPImagePreviewVC: UIViewController {
    
    @IBOutlet weak var buttonClose: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    var photos = [String]()
    var currentSelectedIndexPath: IndexPath?
    var layoutOnce = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigationBar()
        
    }
    
    func setupCollectionView(){
        collectionView.registerReusableCell(FPPreviewPhotoCollectionCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        buttonClose.addTarget(self, action: #selector(buttonCloseAction), for: .touchUpInside)
    }
    
    
    
    func setupNavigationBar(){
        navigationItem.title =  "Photos".localized()
        setLeftBarButtonItem(imageName: "cross_white")
        navigationItem.leftBarButtonItem?.action = #selector(buttonBackTapped)
    }
    
    @objc func buttonCloseAction(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    @objc func buttonBackTapped() {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       Console.log("viewDidAppear")

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Console.log("viewWillAppear")

    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        Console.log("viewWillLayoutSubviews")
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        Console.log("viewDidLayoutSubviews")
        //buttonClose.makeRoundHeight()
       // buttonClose.addshad(shadowColor: UIColor.black.withAlphaComponent(0.5), borderColor: .clear, opacity: 1.0, offSet: CGSize(width: 0, height: 0), radius: 5.0, scale: true)
        if !layoutOnce {
            layoutOnce = true
            if let indexPath = currentSelectedIndexPath {
                collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            }
        }
    }
}
