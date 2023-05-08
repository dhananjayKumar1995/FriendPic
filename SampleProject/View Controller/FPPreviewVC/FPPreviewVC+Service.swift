//
//  FPPreviewVC+Service.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 04/03/22.
//

import Foundation
import UIKit
import PromiseKit

extension FPPreviewVC {
    
    //api for voting
    func voting(token: String,index:Int,isLike:Bool, imageId: String) {

        Loader.show()
        var like = "yes"
        if !isLike {
            like = "no"
        }
        let param = ["vote" : like, "image_id": imageId]
        firstly {
            service!.voting(token: token, param: param)
        }.done { (model: CommonResponse) in
            self.handleResponse1(model: model, index: index)
        }.catch {(error) in
            print(error)
            DisplayBanner2.show(title: error.localizedDescription)
        }.finally {
            Loader.hide()
        }
    }

    func handleResponse1 (model: CommonResponse,index:Int) {

        if model.status != 200{

            DisplayBanner1.show(title:model.message)
            return

        }
        DisplayBanner2.show(title:model.message)
        myCollectionView.reloadData()
        self.dismiss(animated: true)
        Console.log(model)
    }
    
//**********************************************************************************************
    
    //api for postviewforother
    func postViewForOther(token: String,index:Int) {

        Loader.show()

        firstly {
            service!.postViewForOther(token: token, param: ["post": "Post"])
        }.done { (model: OtherPostModel) in
            self.handleResponse1(model: model, index: index)
        }.catch {(error) in
            print(error)
            DisplayBanner2.show(title: error.localizedDescription)
        }.finally {
            Loader.hide()
        }
    }

    func handleResponse1 (model: OtherPostModel,index:Int) {
        if model.status != 200{
            DisplayBanner1.show(title:model.message)
            return
        }
        otherPostModel = model
        DisplayBanner2.show(title:model.message)
        myCollectionView.reloadData()
        setUpData()
        Console.log(model)
    }
    
    func setUpData() {
        labelName.text = otherPostModel?.data?.post?.user?.name
        if let count = otherPostModel?.data?.post?.images?.count, count > 1 {
            pageControl.isHidden = false
            pageControl.numberOfPages = count
        }
        else {
            pageControl.isHidden = true
        }
    }
    
    //BLOCK USER API
    func blockUser(params: [String:Any]) {
        
        Loader.show()
        
        firstly {
            service!.blockUser(param: params)
        }.done { (model: CommonResponse) in
            self.handleResponse(model: model)
        }.catch {(error) in
            print(error)
            DisplayBanner1.show(title: error.localizedDescription)
        }.finally {
            Loader.hide()
        }
    }
    
    func handleResponse (model: CommonResponse) {
        
        if model.status != 200{
            
            DisplayBanner1.show(title:model.message)
            return
        }
        DisplayBanner2.show(title:model.message)
        Console.log(model)
        
    }
}
