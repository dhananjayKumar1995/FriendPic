//
//  FPContactVC.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 18/02/22.
//

import UIKit
import Contacts
import SwiftyContacts

//NOTIFICATION CENTER
extension Notification.Name {
    
    static let sharedAt = Notification.Name("sharedAt")
}
//PROTOCOL METHOD
protocol SharedAtDelegate {
    func isAlreadyShared(isShared:String)
}
struct ContactList {
    var contactNumber: String?
    var contactName: String?
    var contactProfileName: String?
    var isSelected = false
}

//********************************
class FPContactVC: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var textFieldSearchBar: UITextField!
    @IBOutlet weak var viewSearchBar: UIView!
    @IBOutlet weak var labelContactNotFound: UILabel!
    @IBOutlet weak var viewEmptyContact: UIView!
    @IBOutlet weak var buttonSearch: UIButton!
    @IBOutlet weak var labelContactList: UILabel!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var viewInternal: UIView!
    @IBOutlet weak var buttonSend: UIButton!
    @IBOutlet weak var buttonTextfield: UIButton!
    @IBOutlet weak var myTableview: UITableView!
    
    var myContact = [ContactList]()
    var searchArrRes : [ContactList] = []
    
    var delegate : SharedAtDelegate?
    var getImageData:GetDashboardImageModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textFieldSearchBar.delegate = self
        self.myTableview.delegate = self
        self.myTableview.dataSource = self
        myTableview.alwaysBounceVertical = true
        viewSearchBar.isHidden = true
        viewEmptyContact.isHidden = false
        if kAppDelegate.mySubscription == nil {
            subscriptionDetail()
        }
        hideKeyboardWhenTappedAround()
       // textFieldSearchBar.placeholder = "Search..."
        // Do any additional setup after loading the view.
        setUpApperence()
        
        //MARK:-REGISTER COLLECTION VIEW CELL
        myTableview.register(UINib(nibName: "FPContactVCTableViewCell", bundle: nil), forCellReuseIdentifier: "FPContactVCTableViewCell")
        
        fetchContactData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
    }
    func registerKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    func setUpApperence() {
        
        //textFieldSearchBar.setRightView(imageName: "")
        buttonTextfield.setImage(UIImage(named: "search"), for: .normal)
        textFieldSearchBar.applyPadding(padding: 15)
        labelContactList.style(fontType: FontType.GoldplaySemiBold, fontSize: .size20, textColor: Color.appWhite)
        labelContactNotFound.style(fontType: FontType.GoldplayMedium, fontSize: .size16, textColor: Color.appLightGray)
        viewEmptyContact.backgroundColor = Color.appWhite
        viewInternal.backgroundColor = Color.appWhite
        myTableview.backgroundColor = Color.appWhite
        myTableview.layer.cornerRadius = myTableview.frame.height/45
        myTableview.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewInternal.layer.cornerRadius = viewInternal.frame.height/45
        viewInternal.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewEmptyContact.layer.cornerRadius = viewEmptyContact.frame.height/45
        viewEmptyContact.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        myTableview.backgroundColor = .clear
        
    }
    func SearchBar() {
        textFieldSearchBar.becomeFirstResponder()
        textFieldSearchBar.style(fontType: FontType.GoldplayMedium, fontSize: .size15, textColor: Color.appDarkGray, placeholderColor: Color.appLightgray)
        viewSearchBar.layer.cornerRadius = viewSearchBar.layer.frame.height/5
        viewSearchBar.backgroundColor = Color.appWhite
        viewSearchBar.isHidden = false
        buttonSearch.isSelected.toggle()
        myTableview.reloadData()
    }
}

extension FPContactVC {
    @objc func keyboardWillShow(note: NSNotification) {
        if let keyboardSize = (note.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.myTableview.contentInset =  UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 10, right: 0)
            UIView.animate(withDuration: 0.25, animations: {
                self.myTableview.layoutIfNeeded()
                self.view.layoutIfNeeded()
            }) { (bool:Bool) in
            }
        }
    }
    
    @objc func keyboardWillHide(note: NSNotification) {
        myTableview.contentInset =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
        }) { (bool:Bool) in
        }
    }
}
