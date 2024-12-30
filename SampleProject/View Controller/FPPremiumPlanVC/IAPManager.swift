//
//  IAPManager.swift
//  SampleProject
//
//  Created by Dhananjay Kumar on 25/02/22.
//

import Foundation
import StoreKit

enum SubscriptionType{
   case purchase
   case restore
    
}

protocol IAPManagerDelegate: AnyObject {
    func fetched(products: [IAProduct])
    func itemPurchased(params: [String: Any],currentSubscriptionType:SubscriptionType)
}
 
enum IAPManagerProductStatus: String {
    case disabled = "Purchases are disabled in your device!"
    case restored = "You've successfully restored your purchase!"
    case purchased = "You've successfully bought this item!"
    case noProducts = "No products are available"
    case purchasing = "Purchasing is in progress"
    case defered = "Purchasing is in progress and requires action"
}

struct IAProduct {
    let description: String
    let title: String
    let price : NSDecimalNumber
    let identifier: String
    let priceSymbol: String
    let priceWithCurrency: String
}

class IAPManager: NSObject {
    static let shared = IAPManager()
    fileprivate var productsRequest = SKProductsRequest()
    public var iapProducts = [SKProduct]()
    var showLoader = false
    var currentPurchaseStatus: IAPManagerProductStatus?
    weak var delegate: IAPManagerDelegate?
    var shouldRequestServer = true
    var currentPurchaseIdentifier: String?
    var currentSubscriptionType:SubscriptionType = .purchase
    static let monthlySubscriptionIdentifier = "com.friend.monthlyPremiumPlan"
    func canMakePurchases() -> Bool {
        return SKPaymentQueue.canMakePayments()
    }
 
    private override init()
    {
        super.init()
        SKPaymentQueue.default().add(self)
    }
    
    // for purchasing subscription first time
    func purchaseMyProduct(identifier: String){
        
        if iapProducts.count == 0 {
            currentPurchaseStatus = .noProducts
            //MARK:
            
            return
            
        }
        
        if self.canMakePurchases() {
            currentSubscriptionType = .purchase
            currentPurchaseIdentifier = identifier
            guard let product = iapProducts.first(where: {$0.productIdentifier == identifier}) else{
                DisplayBanner1.show(title: "Invalid Purchase")
                return
            }
            Loader.show()
            shouldRequestServer = true
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
            print("PRODUCT TO PURCHASE: \(product.productIdentifier)")
        } else {
            currentPurchaseStatus = .noProducts
            DisplayBanner1.show(title: "You can not make purchase.")
        }
    }
    
    // if already purchased subcription and want to restore same subscription in same device or other device
    func restorePurchase(){
        Loader.show()
        shouldRequestServer = true
        currentSubscriptionType = .restore
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    func fetchAvailableProducts(showLoader: Bool){
        self.showLoader = showLoader
        if iapProducts.count > 0{
            return
        }
        if showLoader {
            Loader.show()
        }
        productsRequest = SKProductsRequest(productIdentifiers: Set(arrayLiteral: IAPManager.monthlySubscriptionIdentifier))
        
        productsRequest.delegate = self
        productsRequest.start()
    }
    func getProducts() -> [IAProduct]{
        var products = [IAProduct]()
        for product in iapProducts{
            let numberFormatter = NumberFormatter()
            numberFormatter.formatterBehavior = .behavior10_4
            numberFormatter.numberStyle = .currency
            numberFormatter.locale = product.priceLocale
            let price1Str = numberFormatter.string(from: product.price)
            print(product.localizedDescription + "\nfor just \(price1Str!)")
            products.append(IAProduct(description: product.description, title: product.localizedTitle, price: product.price, identifier: product.productIdentifier, priceSymbol: price1Str ?? "error", priceWithCurrency:  price1Str ?? "error"))
        }
        return products
    }
    
    func removeObserver(){
        SKPaymentQueue.default().remove(self)
    }
}

extension IAPManager: SKProductsRequestDelegate{
    func request(_ request: SKRequest, didFailWithError error: Error) {
             Loader.hide()
        Console.log("didFailWithError \(error.localizedDescription)")
    }
    func productsRequest (_ request:SKProductsRequest, didReceive response:SKProductsResponse) {
        print(response.invalidProductIdentifiers)
            Loader.hide()
        if (response.products.count > 0) {
            iapProducts = response.products
            var products = [IAProduct]()
            for product in iapProducts{
                let numberFormatter = NumberFormatter()
                //numberFormatter.formatterBehavior = .behavior10_4
                numberFormatter.numberStyle = .currency
                numberFormatter.locale = product.priceLocale
                let price1Str = numberFormatter.string(from: product.price)
                print(product.localizedDescription + "\nfor just \(price1Str!)")
                products.append(IAProduct(description: product.description, title: product.localizedTitle, price: product.price, identifier: product.productIdentifier, priceSymbol: price1Str ?? "error", priceWithCurrency: price1Str ?? "error"))
            }
            delegate?.fetched(products: products)
        }else {
            currentPurchaseStatus = .noProducts
            Console.log("No product available.")
        }
    }
}
extension IAPManager: SKPaymentTransactionObserver{
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                print("purchased")
                SKPaymentQueue.default().finishTransaction(transaction)
                Loader.hide()
                itemPurchasedSuccessfully(identifier: transaction.payment.productIdentifier, transaction: transaction)
            case .failed:
                print("failed")
                Loader.hide()
                SKPaymentQueue.default().finishTransaction(transaction)
            case .restored:
                Loader.hide()
                print("restored")
                printReceiptData()
                itemPurchasedSuccessfully(identifier: transaction.payment.productIdentifier, transaction: transaction)
                SKPaymentQueue.default().finishTransaction(transaction)
            case .purchasing :
                print("purchasing")
            case .deferred :
                print("deferred")
            @unknown default:
                Loader.hide()
                print("unknown")
            }
            if let _ = transaction.error {
                //DisplayBanner1.show(title: "Can't connect to iTunes store")
            }
        }
    }
    
    func printReceiptData() {
        let receiptFileURL = Bundle.main.appStoreReceiptURL
        let receiptData = try? Data(contentsOf: receiptFileURL!)
        if let recieptString = receiptData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0)) {
            print("printReceiptData\(recieptString)\n")
        }
    }
    
    private func itemPurchasedSuccessfully(identifier:String,transaction:SKPaymentTransaction){
        if !shouldRequestServer {
            Console.log("itemPurchasedSuccessfully attampted to request server")
            return
        }
        shouldRequestServer = false
        guard let product = getProducts().first(where: {$0.identifier == identifier}) else{
           // DisplayBanner.show(title: "Invalid identifier.")
            return
        }

        Console.log("itemPurchasedSuccessfully \(identifier)")
        var params = [String: Any]()

        if identifier == IAPManager.monthlySubscriptionIdentifier{
            params["plan_id"] = 1
        }
        params["transaction_id"] = identifier
        params["password"] = "4f8cabeba6dd413fbdce6c232e16117d"
        if let appStoreReceiptURL = Bundle.main.appStoreReceiptURL,
            FileManager.default.fileExists(atPath: appStoreReceiptURL.path) {
            
            do {
                let receiptData = try Data(contentsOf: appStoreReceiptURL, options: .alwaysMapped)
                print(receiptData)
                
                let receiptString = receiptData.base64EncodedString(options: [])
                params["receipt_data"] = receiptString
                delegate?.itemPurchased(params: params, currentSubscriptionType: currentSubscriptionType)
                
                print("Great Product Purchased and params are :- \(params)")
            }
            catch {
                print("Couldn't read receipt data with error: " + error.localizedDescription)
                Console.log("Couldn't read receipt data with error: " + error.localizedDescription) }
             }
        
    }
    
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        Loader.hide()
        if queue.transactions.count > 0 {
            DisplayBanner2.show(title: "Purchase restored successfully")
        }
        else {
            DisplayBanner1.show(title: "There is no purchase to restore")
        }
    }
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        DisplayBanner1.show(title: error.localizedDescription)
        Loader.hide()
    }
  }




