//
//  FPNotificationVC.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 22/02/22.
//

import UIKit

class AllNotification {
    var notificationSection: String?
   
    init(notificationSection: String) {
        self.notificationSection = notificationSection
    }
}

class FPNotificationVC: UIViewController {
    @IBOutlet weak var labelNotification: UILabel!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var viewInternal: UIView!
    @IBOutlet weak var myTableView: UITableView!
    
    var allNotification = [AllNotification]()
    var notification:NotificationModel?
    var currentPageNo = 1
    var currentLoadingState: LoadingState = .refresh
    var isLoading = false
    var post_id:Int?
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
                                    #selector(handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = Color.appDarkBlue
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpApperence()
        setupTableView()
        //isRowSelected = true
        
        allNotification.append(AllNotification.init(notificationSection: "Recent"))
        getAllNotification(pageNo: currentPageNo, loadingState: .refresh)
       
        // Do any additional setup after loading the view.
     
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
        currentPageNo = 1
        getAllNotification(pageNo: currentPageNo, loadingState: .refresh)
    }
    
    func getAllNotification(pageNo: Int, loadingState: LoadingState){
        currentLoadingState = loadingState
        if !isLoading{
            let param = ["page":currentPageNo]
            getNotification(showLoader: loadingState == .refresh, param: param)
        }
    }
    
    func setupTableView() {
        //MARK:-REGISTER TABLE VIEW CELL
        myTableView.register(UINib(nibName: "FPNotificationVCTableViewCell", bundle: nil), forCellReuseIdentifier: "FPNotificationVCTableViewCell")
        myTableView.refreshControl = refreshControl
    }
    
    func setUpApperence() {
        
        labelNotification.style(fontType: FontType.GoldplaySemiBold, fontSize: .size20, textColor: Color.appWhite)
        viewInternal.backgroundColor = Color.appWhite
        myTableView.backgroundColor = .none
        viewInternal.layer.cornerRadius = viewInternal.frame.height/45
        viewInternal.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        myTableView.layer.cornerRadius = myTableView.frame.height/45
        myTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
