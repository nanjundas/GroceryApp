//
//  File.swift
//  GroceryApp
//
//  Created by Nanjundaswamy Sainath on 3/12/18.
//  Copyright © 2018 Nanjunda. All rights reserved.
//

import Foundation
import UIKit

class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subTextLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 8
    }
}
