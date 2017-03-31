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
    var teammate: TeammateModel?
    
    fileprivate let errorAlertString = "Error Loading"
    fileprivate let errorMessageString = "There was an error loading this teammate's info! Please try again"
    fileprivate let okayString = "Okay"
    fileprivate let appleGothicFontName = "AppleSDGothicNeo-Regular"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        addImageViewWithConstraints()
        addBioWithConstraints()
        addTeammateInformation()
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
        let topConstraint = teammateImageView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor)
        let widthConstraint = teammateImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0)
        let heightConstraint = teammateImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0)
        xConstraint.isActive = true
        heightConstraint.isActive = true
        widthConstraint.isActive = true
        topConstraint.isActive = true
        makeImageViewCircular()
    }
    
    private func makeImageViewCircular() {
        teammateImageView.layoutIfNeeded()
//        teammateImageView.layer.cornerRadius = teammateImageView.frame.height / 2
//        teammateImageView.clipsToBounds = true
//        teammateImageView.layer.borderWidth = 4.0
//        teammateImageView.layer.borderColor = UIColor(colorLiteralRed: 255/255, green: 46/255, blue: 127/255, alpha: 1).cgColor
    }
    
    private func addBioWithConstraints() {
        teammateBioTextView = UITextView()
        teammateBioTextView.textColor = UIColor.gray
        teammateBioTextView.textAlignment = .left
        let bioFont = UIFont(name: appleGothicFontName, size: 16)
        teammateBioTextView.font = bioFont
        view.addSubview(teammateBioTextView)
        teammateBioTextView.translatesAutoresizingMaskIntoConstraints = false
        let xConstraint = teammateBioTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let topConstraint = teammateBioTextView.topAnchor.constraint(equalTo: teammateImageView.bottomAnchor, constant: 10)
        let bottomConstraint = teammateBioTextView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -10)
        let widthConstraint = teammateBioTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95)
        xConstraint.isActive = true
        bottomConstraint.isActive = true
        widthConstraint.isActive = true
        topConstraint.isActive = true
    }
    
}
