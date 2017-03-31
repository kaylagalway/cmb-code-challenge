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
    
    let teammateImageView: UIImageView!
    let teammateLabel: UILabel!
    let activityIndicator = UIActivityIndicatorView()
    fileprivate let appleGothicFontName = "AppleSDGothicNeo-Bold"
    
    override init(frame: CGRect) {
        teammateImageView = UIImageView()
        teammateLabel = UILabel()
        super.init(frame: frame)
        addViewsToCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViewsToCell() {
        addImageViewToCell()
        addLabelToCell()
    }
    
    private func addImageViewToCell() {
        teammateImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(teammateImageView)
        let xConstraint = teammateImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        let yConstraint = teammateImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20)
        let widthConstraint = teammateImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8)
        let heightConstraint = teammateImageView.heightAnchor.constraint(equalTo: teammateImageView.widthAnchor)
        xConstraint.isActive = true
        yConstraint.isActive = true
        widthConstraint.isActive = true
        heightConstraint.isActive = true
        teammateImageView.layoutIfNeeded()
        teammateImageView.layer.cornerRadius = teammateImageView.frame.height / 2
        teammateImageView.layer.masksToBounds = true
    }
    
    private func addLabelToCell() {
        let titleFont = UIFont(name: appleGothicFontName, size: 20)
        teammateLabel.font = titleFont
        teammateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(teammateLabel)
        let imageBottomY = teammateImageView.frame.origin.y + teammateImageView.frame.height
        let halfwayPoint = ((contentView.frame.height - imageBottomY) / 5)
        let xConstraint = teammateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        let yConstraint = teammateLabel.centerYAnchor.constraint(equalTo: teammateImageView.bottomAnchor, constant: halfwayPoint)
        xConstraint.isActive = true
        yConstraint.isActive = true
        bringSubview(toFront: teammateLabel)
    }
    
    private func addActivityIndicatorToView() {
        let xConstraint = teammateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        let yConstraint = teammateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        xConstraint.isActive = true
        yConstraint.isActive = true
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
    }
    
}
