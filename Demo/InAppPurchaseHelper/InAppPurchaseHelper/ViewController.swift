//
//  ViewController.swift
//  InAppPurchaseHelper
//
//  Created by Mustafa Karakus on 06/04/2020.
//  Copyright © 2020 Mustafa Karakus. All rights reserved.
//

import UIKit
enum IAPItem: String{
    case
    monthlySubscription = "com.example.product1.monthly",
    yearlySubscription = "com.example.product2.yearly"
    //case = "Product ID under AppStore In-App Purchases"
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let productIds:Set = [IAPItem.monthlySubscription.rawValue,
                              IAPItem.yearlySubscription.rawValue] 
        
        StoreKitHelper.shared.getProducts(products: productIds)
    }
    
    // Purchase Sample
    func purchase(item: IAPItem){
        StoreKitHelper.shared.purchase(productIdentifier: item.rawValue) { (transaction) in
            switch transaction.transactionState{
            case .purchased: break
            case .restored: break
            case .deferred: break
            case .failed: break
            default: break
            }
        }
    }
    
    // Restore Sample
    func restore(){
        StoreKitHelper.shared.restorePurchases { (transaction) in
            switch transaction.transactionState{
            case .purchased: break
            case .restored: break
            case .deferred: break
            case .failed: break
            default: break
            }
        }
    }
}

