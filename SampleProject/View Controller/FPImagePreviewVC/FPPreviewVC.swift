//
//  SCPreviewVC.swift
//  Shift
//
//  Created by Mobilecoderz1 on 07/08/19.
//  Copyright © 2019 Mobilecoderz. All rights reserved.
//

import UIKit

class FPImagePreviewVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var photos: [OrderPhotos]?
    var currentSelectedIndexPath: IndexPath?
    var layoutOnce = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigationBar()
        
    }
    
    func setupCollectionView(){
        collectionView.register(UINib(nibName: Constants.CellIdentifier.previewPhotoCollectionCell, bundle: nil), forCellWithReuseIdentifier: Constants.CellIdentifier.previewPhotoCollectionCell)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    func setupNavigationBar(){
        navigationItem.title =  "Photos".localized()
        setLeftBarButtonItem(imageName: "cross_white")
        navigationItem.leftBarButtonItem?.action = #selector(buttonBackTapped)
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
        if !layoutOnce {
            layoutOnce = true
            if let indexPath = currentSelectedIndexPath {
                collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            }
        }
    }
}
