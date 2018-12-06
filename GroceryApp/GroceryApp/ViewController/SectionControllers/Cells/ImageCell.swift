//
//  ImageCell.swift
//  GroceryApp
//
//  Created by Nanjundaswamy Sainath on 6/12/18.
//  Copyright © 2018 Nanjunda. All rights reserved.
//

import Foundation
import UIKit

class ImageCell: UICollectionViewCell {

    lazy var imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = .white
        self.addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.frame = self.contentView.bounds.inset(by: UIEdgeInsets(top: 32, left: 32, bottom: 32, right: 32))
    }
}
