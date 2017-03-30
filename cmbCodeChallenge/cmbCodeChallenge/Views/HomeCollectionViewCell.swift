//
//  HomeCollectionViewCell.swift
//  cmbCodeChallenge
//
//  Created by Kayla Galway on 3/29/17.
//  Copyright © 2017 Kayla Galway. All rights reserved.
//

import Foundation
import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    let teammateImageView = UIImageView()
    let teammateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViewsToCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViewsToCell() {
        addImageViewToCell()
        addLabelToCell()
    }
    
    func addImageViewToCell() {
        teammateImageView.alpha = 0.5
        teammateImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(teammateImageView)
        let xConstraint = teammateImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        let yConstraint = teammateImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        let widthConstraint = teammateImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        let heightConstraint = teammateImageView.heightAnchor.constraint(equalTo: teammateImageView.widthAnchor)
        xConstraint.isActive = true
        yConstraint.isActive = true
        widthConstraint.isActive = true
        heightConstraint.isActive = true
    }
    
    func addLabelToCell() {
        teammateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(teammateLabel)
        let xConstraint = teammateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        let yConstraint = teammateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        xConstraint.isActive = true
        yConstraint.isActive = true
        bringSubview(toFront: teammateLabel)
    }
    
}
