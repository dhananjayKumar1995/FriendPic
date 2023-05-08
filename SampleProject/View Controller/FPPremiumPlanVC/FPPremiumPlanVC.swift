//
//  FPPremiumPlanVC.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 24/02/22.
//

import UIKit

protocol SubscribedDelegate: AnyObject {
    func subscribed()
}

class FPPremiumPlanVC: UIViewController {
    
    
    @IBOutlet weak var buttonPrivacyPolicy: UIButton!
    @IBOutlet weak var labelAnd: UILabel!
    @IBOutlet weak var buttonTermCondition: UIButton!
    @IBOutlet weak var buttonRestore: UIButton!
    @IBOutlet weak var footerTableView: UIView!
    @IBOutlet weak var viewInternal: UIView!
    @IBOutlet weak var labelPremiumPlanDescription: UILabel!
    @IBOutlet weak var labelPremiumPlan: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var buttonBack: UIButton!
    

    
    var products = [IAProduct]()
    var paymentModel = [IAProduct]()
    var currentSelectedIndex:Int? = 0
    var delegate: SubscribedDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupApperence()
        fetchData()
        IAPManager.shared.delegate = self
        //MARK:-REGISTER COLLECTION VIEW CELL
        myTableView.register(UINib(nibName: "FPPremiumPlanVCTableViewCell", bundle: nil), forCellReuseIdentifier: "FPPremiumPlanVCTableViewCell")
        subscriptionDetail()
        // Do any additional setup after loading the view.
    }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        buttonRestore.makeRoundHeight()
    }
   
    
    func fetchData(){
        if IAPManager.shared.iapProducts.count > 0{
            products = IAPManager.shared.getProducts()
            checkToShowPlaceholder()
        }else{
            IAPManager.shared.fetchAvailableProducts(showLoader: true)
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
        fetchData()
    }
    
    func setupApperence() {        
        labelAnd.style(fontType: FontType.GoldplaySemiBold, fontSize: .size20, textColor: Color.appBlack)
        buttonRestore.style(fontType: FontType.GoldplaySemiBold, fontSize: .size15, textColor: Color.appWhite)
        buttonTermCondition.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appBlue1)
        buttonPrivacyPolicy.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appBlue1)
        labelPremiumPlan.style(fontType: FontType.GoldplaySemiBold, fontSize: .size20, textColor: Color.appWhite)
        labelPremiumPlanDescription.style(fontType: FontType.GoldplayMedium, fontSize: .size16, textColor: Color.appWhite)
        myTableView.backgroundColor = Color.appWhite
        footerTableView.backgroundColor = Color.appSkyBlue
        footerTableView.layer.cornerRadius = footerTableView.frame.height/5
        footerTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        myTableView.layer.cornerRadius = myTableView.frame.height/45
        myTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewInternal.layer.cornerRadius = viewInternal.frame.height/45
        viewInternal.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        buttonRestore.backgroundColor = UIColor.init(hexString: "#5DC7BD")
    }
    
    func checkToShowPlaceholder() {
        if products.count == 0 {
            myTableView.setEmptyMessage("No product available for purchase")
            footerTableView.isHidden = true
        }
        else {
            myTableView.backgroundView = nil
            footerTableView.isHidden = false
        }
    }
}

extension FPPremiumPlanVC: IAPManagerDelegate{
   
    func fetched(products: [IAProduct]) {
        DispatchQueue.main.async { [weak self] in
            self?.products = products
            self?.checkToShowPlaceholder()
            // collectionView.reloadData()
            self?.myTableView.reloadData()
        }
    }

    func itemPurchased(params: [String : Any],currentSubscriptionType:SubscriptionType) {
        print(params)
        DispatchQueue.main.async {[weak self] in
            self?.subscribe(params: params,currentSubscriptionType:currentSubscriptionType)

        }
    }
}


