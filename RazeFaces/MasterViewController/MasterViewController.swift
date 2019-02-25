/// Copyright (c) 2018 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit


class MasterViewController: UITableViewController {
  
  var funcs = MasterModel()

  override func viewDidLoad() {
    
    super.viewDidLoad()
    title = "RazeFaces"
    funcs.tableViewRefreshControl(self)
    funcs.settingRestoreBtnToNav(self)
    funcs.settingInAppPurchaseNotific(self)
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    funcs.reload(self)
  }
  
  override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
    return funcs.productPurchasedOrNot( self, identifier)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    funcs.actionForShowingPurchasedProduct(self, segue)
  }
  
  @objc func reload() {
    funcs.reload(self)
  }
  
  @objc func handlePurchaseNotification(_ notification: Notification) {
    funcs.handlePurchaseNotification(notification, self)
  }
  
  @objc func restoreTapped(_ sender: AnyObject) {
    RazeFaceProducts.store.restorePurchases()
  }

  
}

