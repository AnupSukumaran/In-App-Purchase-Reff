//
//  DetailModel.swift
//  RazeFaces
//
//  Created by Sukumar Anup Sukumaran on 25/02/19.
//  Copyright © 2019 Razeware LLC. All rights reserved.
//

import UIKit

class DetailModel: NSObject {
    
  func configureView(_ main: DetailViewController) {
    main.imageView?.image = main.image
  }
  
}
