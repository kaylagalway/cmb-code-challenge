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
    var teammateBio: UITextView!
    var teammate: TeammateModel?
    
    fileprivate let errorAlertString = "Error Loading"
    fileprivate let errorMessageString = "There was an error loading this teammate's info! Please try again"
    fileprivate let okayString = "Okay"
    fileprivate let appleGothicFontName = "AppleSDGothicNeo-Regular"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        addImageViewWithConstraints()
        addBioWithConstraints()
        addTeammateInformation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    private func addTeammateInformation() {
        if let chosenTeammate = teammate {
            title = "☕️" + " " + chosenTeammate.firstName + " " + chosenTeammate.lastName + " " + "☕️"
            teammateImageView.image = chosenTeammate.avatar
            teammateBio.text = chosenTeammate.bio
            teammateBio.contentSize = teammateBio.bounds.size
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
        let bottomConstraint = teammateImageView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
        let topConstraint = teammateImageView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 20)
        let widthConstraint = teammateImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        xConstraint.isActive = true
        bottomConstraint.isActive = true
        widthConstraint.isActive = true
        topConstraint.isActive = true
    }
    
    private func addBioWithConstraints() {
        teammateBio = UITextView()
        teammateBio.textColor = UIColor.blue
        teammateBio.textAlignment = .center
        let bioFont = UIFont(name: appleGothicFontName, size: 16)
        teammateBio.font = bioFont
        teammateBio.textColor = UIColor.brown
        view.addSubview(teammateBio)
        teammateBio.translatesAutoresizingMaskIntoConstraints = false
        let xConstraint = teammateBio.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let topConstraint = teammateBio.topAnchor.constraint(equalTo: teammateImageView.bottomAnchor, constant: 20)
        let bottomConstraint = teammateBio.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -30)
        let widthConstraint = teammateBio.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        xConstraint.isActive = true
        bottomConstraint.isActive = true
        widthConstraint.isActive = true
        topConstraint.isActive = true
    }
    
}
