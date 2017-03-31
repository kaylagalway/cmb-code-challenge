//
//  TeammateDetailViewController.swift
//  cmbCodeChallenge
//
//  Created by Kayla Galway on 3/30/17.
//  Copyright © 2017 Kayla Galway. All rights reserved.
//

import Foundation
import UIKit


class TeammateDetailViewController: UIViewController {
    
    var teammateImageView: UIImageView!
    var teammateBioTextView: UITextView!
    var teammateTitleLabel: UILabel!
    var teammate: TeammateModel?
    
    fileprivate let errorAlertString = "Error Loading"
    fileprivate let errorMessageString = "There was an error loading this teammate's info! Please try again"
    fileprivate let okayString = "Okay"
    fileprivate let appleGothicRegularFontName = "AppleSDGothicNeo-Regular"
    fileprivate let appleGothicBoldFontName = "AppleSDGothicNeo-Bold"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addImageViewWithConstraints()
        addTitleLabelWithConstraints()
        addBioWithConstraints()
        addTeammateInformation()
        navigationController?.isNavigationBarHidden = false
    }
    
    private func addTeammateInformation() {
        if let chosenTeammate = teammate {
            title = "☕️" + " " + chosenTeammate.firstName + " " + chosenTeammate.lastName + " " + "☕️"
            teammateImageView.image = chosenTeammate.avatar
            teammateBioTextView.text = chosenTeammate.bio
            teammateBioTextView.contentSize = teammateBioTextView.bounds.size
        } else {
            showErrorLoadingTeammateAlert()
        }
    }
    
    private func showErrorLoadingTeammateAlert() {
        let alertController = UIAlertController(title: errorAlertString, message: errorMessageString, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: okayString, style: .default) { (action) in
            _ = self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(okayAction)
    }
    
    private func addImageViewWithConstraints() {
        teammateImageView = UIImageView()
        teammateImageView.contentMode = .scaleAspectFit
        view.addSubview(teammateImageView)
        teammateImageView.translatesAutoresizingMaskIntoConstraints = false
        let xConstraint = teammateImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let topConstraint = teammateImageView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 10.0)
        let widthConstraint = teammateImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        let heightConstraint = teammateImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        xConstraint.isActive = true
        heightConstraint.isActive = true
        widthConstraint.isActive = true
        topConstraint.isActive = true
        teammateImageView.layer.shadowOffset = CGSize.zero
        teammateImageView.layer.shadowColor = UIColor.black.cgColor
        teammateImageView.layer.shadowRadius = 3.0
        teammateImageView.layer.shadowOpacity = 1.0
    }
    
    private func addBioWithConstraints() {
        teammateBioTextView = UITextView()
        teammateBioTextView.textColor = UIColor.black
        teammateBioTextView.textAlignment = .left
        let bioFont = UIFont(name: appleGothicRegularFontName, size: 15)
        teammateBioTextView.font = bioFont
        view.addSubview(teammateBioTextView)
        teammateBioTextView.translatesAutoresizingMaskIntoConstraints = false
        let xConstraint = teammateBioTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let topConstraint = teammateBioTextView.topAnchor.constraint(equalTo: teammateTitleLabel.bottomAnchor, constant: 10)
        let bottomConstraint = teammateBioTextView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor)
        let widthConstraint = teammateBioTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
        xConstraint.isActive = true
        bottomConstraint.isActive = true
        widthConstraint.isActive = true
        topConstraint.isActive = true
    }
    
    private func addTitleLabelWithConstraints() {
        teammateTitleLabel = UILabel()
        teammateTitleLabel.textColor = UIColor.white
        teammateTitleLabel.textAlignment = .center
        teammateTitleLabel.backgroundColor = UIColor(colorLiteralRed: 35/255, green: 127/255, blue: 245/255, alpha: 1)
        let bioFont = UIFont(name: appleGothicBoldFontName, size: 18)
        teammateTitleLabel.font = bioFont
        teammateTitleLabel.text = teammate?.title
        view.addSubview(teammateTitleLabel)
        teammateTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        addTitleLabelConstraints()
    }
    
    private func addTitleLabelConstraints() {
        calculateDimensionsForTitleLabel()
        let centerXConstraint = teammateTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let centerYConstraint = teammateTitleLabel.centerYAnchor.constraint(equalTo: teammateImageView.bottomAnchor)
        centerXConstraint.isActive = true
        centerYConstraint.isActive = true
        teammateTitleLabel.layoutIfNeeded()
        teammateTitleLabel.clipsToBounds = true
        teammateTitleLabel.layer.cornerRadius = teammateTitleLabel.frame.height * 0.2
    }
    
    private func calculateDimensionsForTitleLabel() {
        let labelWidthWithText = teammateTitleLabel.intrinsicContentSize.width + 40
        if labelWidthWithText < view.frame.width * 0.4 {
            let widthConstraint = teammateTitleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4)
            widthConstraint.isActive = true
        } else {
            let widthConstraint = teammateTitleLabel.widthAnchor.constraint(equalToConstant: labelWidthWithText)
            widthConstraint.isActive = true
        }
        let heightConstraint = teammateTitleLabel.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1)
        heightConstraint.isActive = true
    }
    
}
