//
//  StoreKitHelper.swift
//  InAppPurchaseHelper
//
//  Created by Mustafa Karakus on 06/04/2020.
//  Copyright © 2020 Mustafa Karakus. All rights reserved.
//

import Foundation
import StoreKit
  
class StoreKitHelper: NSObject{
    static let shared = StoreKitHelper()
    let paymentQueue = SKPaymentQueue.default()
    var products = [SKProduct]()
    var completion: ((SKPaymentTransaction)-> Void)?
    
    private override init() { }
    
    func getProducts(products:Set<String>){ 
        let request = SKProductsRequest(productIdentifiers: products)
        request.delegate = self
        request.start()
        paymentQueue.add(self)
    }
    
    func purchase(productIdentifier: String, completion: ((SKPaymentTransaction)-> Void)?){
        guard let productToPurchase = products.filter({ $0.productIdentifier == productIdentifier }).first else { return }
        let payment = SKPayment(product: productToPurchase)
        paymentQueue.add(payment)
        self.completion = completion
    }
    
    func restorePurchases(completion: ((SKPaymentTransaction)-> Void)?){
        paymentQueue.restoreCompletedTransactions()
        self.completion = completion
    }
}

extension StoreKitHelper: SKProductsRequestDelegate{
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products
        for product in response.products{
            print(product.localizedTitle)
        }
    }
}

extension StoreKitHelper: SKPaymentTransactionObserver{
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions{
            print(transaction.transactionState.status(), transaction.payment.productIdentifier)
            switch transaction.transactionState{
            case .purchasing: break
            default:
                queue.finishTransaction(transaction)
                self.completion?(transaction)
            }
        }
    }
}

extension SKPaymentTransactionState{
    func status() -> String{
        switch self {
        case .deferred: return "deferred"
        case .failed: return "failed"
        case .purchased: return "purchased"
        case .purchasing: return "purchasing"
        case .restored: return "restored"
        default: return "unknown"
        }
    }
}
 
