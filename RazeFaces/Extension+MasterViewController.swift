//
//  Extension+MasterViewController.swift
//  RazeFaces
//
//  Created by Sukumar Anup Sukumaran on 25/02/19.
//  Copyright © 2019 Razeware LLC. All rights reserved.
//

import UIKit

// MARK: - UITableViewDataSource
extension MasterViewController {
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return funcs.products.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return funcs.cellConfig(self, indexPath: indexPath)
  }
  
  
}

