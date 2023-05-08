//
//  FPHomeVC+Service.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 08/02/22.
//

import Foundation
import PromiseKit

extension FPHomeVC {
    
    
    //get image ....calling from home view did load
    func getImage() {

        Loader.show()

        firstly {
            service!.GetImage(params: [:])
        }.done { (model: GetDashboardImageModel) in
            self.handleResponse(model: model)
        }.catch {(error) in
            print(error)
            DisplayBanner2.show(title: error.localizedDescription)
        }.finally {
            Loader.hide()
        }
    }

    func handleResponse (model: GetDashboardImageModel) {

        if model.status != 200{

            DisplayBanner1.show(title:model.message)
            return

        }
        else {
//        if model.data?.images.count == 1 {
//            pageControl.numberOfPages = 0
//        }
//        else {
//            pageControl.numberOfPages = model.data?.images.count ?? 0//getImageDta?.data?.count ?? 0
//        }
        getImageData = model
        myTableView.reloadData()
        setUpData()
        showHideView()
        setPlusButtonState()
        Console.log(model)
        }
        setNotificationBadgeCount()
        
    }
    
    func setNotificationBadgeCount() {
        let count = getImageData?.data?.newNotificationCount ?? 0
        if count == 0 {
            labelNotificationCount.isHidden = true
            labelNotificationCount.text = "\(count)"
        }
        else {
            labelNotificationCount.isHidden = false
            labelNotificationCount.text = "\(count)"
        }
    }
    
    func setPlusButtonState() {
        let count = getImageData?.data?.images.count ?? 0
        if count != 0 {
            viewFloatyButton.isUserInteractionEnabled = false
            viewFloatyButton.enableMode = .disabled
            viewFloatyButton.alpha = 0.5
            if getImageData?.data?.sharedAt != nil {
                labelHangOnYourFrdVoting.style(fontType:FontType.GoldplayMedium, fontSize: .size18, textColor: Color.appDarkGray)
                labelHangOnYourFrdVoting.text = "Hang On Your Friends Are Voting"
            }else{
                labelHangOnYourFrdVoting.style(fontType:FontType.GoldplaySemiBold, fontSize: .size18, textColor: Color.appDarkGray)
                labelHangOnYourFrdVoting.text = "Share Pictures Below with Friends to Receive Votes"
            }
            labelHangOnYourFrdVoting.isHidden = false
        }
        else {
            viewFloatyButton.isUserInteractionEnabled = true
            viewFloatyButton.enableMode = .enabled
            viewFloatyButton.alpha = 1.0
            labelHangOnYourFrdVoting.isHidden = true
        }
    }
    
    func setUpData(){
       // labelLikeCount.text = "\(getImageData?.data?.upVote ?? 0)"
        //labelDisLikeCount.text = "\(getImageData?.data?.downVote ?? 0)"
    }
    
    //**************************************************************************
    
    // IMAGE UPLOAD API
    
    func imageUpload(params:[String:Any]) {
            
                Loader.show()
                print("this is tha datas:--",params)
                
                Client.requestMultipartApiServer(methodName:"/image/upload", parameters:params, methodType: .post, showLoader: false) { result in
                    Loader.hide()
                    switch result {
                    case .success(let data):
                       print(Logger.prettyPrintDict(with: data))
                      
                        let model  : CommonResponse? = Client.getModel(object: data)
                        if model?.status == 200 {
                            self.getImage()
                        }
                        
                        DisplayBanner2.show(title: model?.message)
                       // self.handleResponseForEditProfile(model: model)
                     
                    case .failure(let error):
                        
                        DisplayBanner1.show(title:error?.localizedDescription)
                       
                    default:
                        debugPrint("Do Nothing")
                    }
                    
                } _: { progress in
                    
                    print(progress)
            }

        }
    
    
    //***********************************************************************************
    
    //REMOVE DASHBOARD IMAGE API CALLING FROM REMOVE POPUP SCREEN
    
    func removeDashboardImage() {

        Loader.show()

        firstly {
            service!.removeDashboardImage(params: [:])
        }.done { (model: CommonResponse) in
            self.handleResponse1(model: model)
        }.catch {(error) in
            print(error)
            DisplayBanner2.show(title: error.localizedDescription)
        }.finally {
            Loader.hide()
        }
    }

    func handleResponse1 (model: CommonResponse) {

        if model.status != 200{
            DisplayBanner1.show(title:model.message)
            return

        }
        else {

            DisplayBanner2.show(title:model.message)
            getImageData?.data?.images.removeAll()
            myTableView.reloadData()
            viewForEmptyPicture.isHidden = false
            setPlusButtonState()
//            buttonShare.setImage(UIImage(named: "shareDisable"), for: .normal)
//            buttoncross.isHidden = true
//            if getImageData?.data?.images.count == 1 {
//                pageControl.numberOfPages = 0
//            }
//            else {
//                pageControl.numberOfPages = getImageData?.data?.images.count ?? 0
//            }
            
            Console.log(model)
        }

    }
    
    
}



