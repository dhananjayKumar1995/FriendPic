//
//  FPMyUploadVC+Service.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 17/02/22.
//

import Foundation
import PromiseKit

extension FPMyUploadVC {
    
    //get image ....calling from FPMyUploadVC view did load
    func getAllPost(showLoader:Bool) {
        
        isLoading = true
        Loader.show()
        
        firstly {
            service!.myUploadPost(params: ["page": currentPageNo])
        }.done { (model: GetAllPostModel) in
            self.handleResponse(model: model)
        }.catch {(error) in
            print(error)
            DisplayBanner2.show(title: error.localizedDescription)
        }.finally {
            Loader.hide()
        }
    }
    /*
     func handleResponse (model: GetAllPostModel) {
     
     if model.status != 200{
     
     DisplayBanner1.show(title:model.message)
     return
     
     }
     getImageData1 = model
     myTableView.reloadData()
     Console.log(model)
     }
     */
    
    func handleResponse(model: GetAllPostModel?) {
        
        currentPageNo += 1
        switch currentLoadingState {
        case .refresh:
            // self.categoryListModel?.data?.category?.docs?.removeAll()
            self.getImageData1 = model
            //            if  getImageData1?.data?.posts?.data.count == 0{
            //
            //                lablePlaceholder.isHidden = false
            //                lablePlaceholder.text = "No Post found."
            //
            //            } else {
            //
            //                buttonAddMyPreferance.isHidden = false
            //            }
        case .nextPage:
            setData(model: model)
            break
        }
        
        myTableView.reloadData()
        showHideView()
        isLoading = false
    }
    
    func setData(model: GetAllPostModel?){
        
        if let list = model?.data?.posts?.data {
            
            self.getImageData1?.data?.posts?.data.append(contentsOf: list)
        }
    }
    
    
    
    //***********************************************************************
    
    //DELETE image FROM MY UPLOAD ....calling from DELETE POP UP SCREEN
    func deletePostFromUpload(postId: Int,index:Int) {
        
       // isLoading = true
        Loader.show()
        
        firstly {
            service!.deletePostFromUpload(postId: postId)
        }.done { (model: GetAllPostModel) in
            self.handleResponse1(model: model, index: index)
        }.catch {(error) in
            print(error)
            DisplayBanner2.show(title: error.localizedDescription)
        }.finally {
            Loader.hide()
        }
    }
    
    func handleResponse1 (model: GetAllPostModel,index:Int) {
        
        if model.status != 200{

            DisplayBanner1.show(title:model.message)
            return
        }
        DisplayBanner2.show(title:model.message)
        getImageData1?.data?.posts?.data.remove(at: index)
        let totalData = getImageData1?.data?.posts?.total ?? 0
        getImageData1?.data?.posts?.total = totalData - 1
        myTableView.reloadData()
        showHideView()
       // viewEmptyPicture.isHidden = false
        Console.log(model)
    }
}
