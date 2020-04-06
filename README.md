# in-app-purchase-helper
App Store In-App-Purchase Helper

## How to use

* Add `StoreKitHelper.swift` to your project.

* Create a String Enum in your project, based on your In-App-Purchase Product Ids in the App Store

for example;
```swift
enum IAPItem: String{
    case
    monthlySubscription = "com.example.product1.monthly",
    yearlySubscription = "com.example.product2.yearly"
    //case = "Product ID under AppStore In-App Purchases"
}
```

* in viewDidLoad, get your products -Do not pass this step-

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    let productIds:Set = [IAPItem.monthlySubscription.rawValue,
                          IAPItem.yearlySubscription.rawValue] 
    
    StoreKitHelper.shared.getProducts(products: productIds)
}
```

* When you need to purchase a product, call `purchase` function and pass the product that you want to purchase.

for example;
```swift
StoreKitHelper.shared.purchase(productIdentifier: IAPItem.monthlySubscription.rawValue) { (transaction) in

    switch transaction.transactionState{
    case .purchased: break
    case .restored: break
    case .deferred: break
    case .failed: break
    default: break
    }

}
```

* If you need to `restore` purchases

for example; 
```swift
StoreKitHelper.shared.restorePurchases { (transaction) in

    switch transaction.transactionState{
    case .purchased: break
    case .restored: break
    case .deferred: break
    case .failed: break
    default: break
    }

}
```