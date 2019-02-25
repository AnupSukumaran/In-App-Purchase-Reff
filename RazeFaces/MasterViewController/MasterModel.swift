//
//  MasterModel.swift
//  RazeFaces
//
//  Created by Sukumar Anup Sukumaran on 25/02/19.
//  Copyright © 2019 Razeware LLC. All rights reserved.
//

import Foundation
import StoreKit

class MasterModel: NSObject {
  
  let showDetailSegueIdentifier = "showDetail"
  var products: [SKProduct] = []
  
  //MARK: checking Product purchased or Not
  func productPurchasedOrNot(_ main: MasterViewController, _ identifier: String  ) -> Bool {
    if identifier == showDetailSegueIdentifier {
      
      guard let indexPath = main.tableView.indexPathForSelectedRow else {
        return false
      }
      
      let product = products[indexPath.row]
      
      return RazeFaceProducts.store.isProductPurchased(product.productIdentifier)
    }
    
    return true
  }
  
  //MARK: Upon selection if purchased products will show 
  func actionForShowingPurchasedProduct(_ main: MasterViewController, _ segue: UIStoryboardSegue) {
    if segue.identifier == showDetailSegueIdentifier {
      
      guard let indexPath = main.tableView.indexPathForSelectedRow else { return }
      let product = products[indexPath.row]
      if let name = resourceNameForProductIdentifier(product.productIdentifier),
        let vc = segue.destination as? DetailViewController {
        let image = UIImage(named: name)
        vc.image = image
      }
      
    }
  }
  
  //MARK: Pull to refresh table view
  func tableViewRefreshControl(_ main: MasterViewController) {
    
    main.refreshControl = UIRefreshControl()
    main.refreshControl?.addTarget(main, action: #selector(main.reload), for: .valueChanged)
    
  }
  
  func reload(_ main: MasterViewController) {
    products = []
    main.tableView.reloadData()
    RazeFaceProducts.store.requestProducts{ [weak self] success, products in
      guard let self = self else { return }
      if success {
        self.products = products!
        main.tableView.reloadData()
      }
      main.refreshControl?.endRefreshing()
    }
  }
  
  //MARK:setting restore button to nav bar
  func settingRestoreBtnToNav(_ main: MasterViewController) {
    let restoreButton = UIBarButtonItem(title: "Restore",style: .plain, target: main, action: #selector(main.restoreTapped(_:)))
    main.navigationItem.rightBarButtonItem = restoreButton
  }
  
  
  
  //MARK: Setting Notifcation For In-App-Purchase Funcs
  func settingInAppPurchaseNotific(_ main: MasterViewController) {
    NotificationCenter.default.addObserver(main, selector: #selector(main.handlePurchaseNotification(_:)),
                                           name: .IAPHelperPurchaseNotification,
                                           object: nil)
  }
  
  func handlePurchaseNotification(_ notification: Notification, _ main: MasterViewController) {
    guard
      let productID = notification.object as? String,
      let index = products.index(where: { product -> Bool in
        product.productIdentifier == productID
      })
      else { return }
    
    main.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
  }
  
  
  //MARK: Cell Called
  func cellConfig(_ main: MasterViewController, indexPath: IndexPath) -> ProductCell {
    let cell = main.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ProductCell
    
    let product = products[indexPath.row]
    
    cell.product = product
    cell.buyButtonHandler = { product in
      RazeFaceProducts.store.buyProduct(product)
    }
    
    return cell
  }
  
}
