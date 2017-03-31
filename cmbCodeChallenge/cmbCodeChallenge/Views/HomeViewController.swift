//
//  HomeViewController.swift
//  cmbCodeChallenge
//
//  Created by Kayla Galway on 3/30/17.
//  Copyright © 2017 Kayla Galway. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController, HomeViewModelDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var viewModel = HomeViewModel()
    var collectionView: UICollectionView!
    let layout = UICollectionViewFlowLayout()
    
    fileprivate let reuseIdentifier = "teammateCell"
    fileprivate let bagelString = "Bagel"
    fileprivate let bagelAlertMessage = "Bagel is a bagel. That is all we know."
    fileprivate let bagelActionTitle = "Understandable"
    
    override func viewDidLoad() {
        addViewsWithConstraints()
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    //HomeViewModelDelegate method
    //when first async call for data finishes
    func dataDidLoad() {
        collectionView.reloadData()
    }
    
    //HomeViewModelDelegate method
    //when image is downloaded for specific cell, reload cell
    func imageDidLoad(atIndexPath indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
    
}

//Collection view delegate methods and helper methods
extension HomeViewController {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        //if number of teammates is not even, add extra filler cell
        if viewModel.teammateArray.count % 2 != 0 {
            return viewModel.teammateArray.count + 1
        } else {
            return viewModel.teammateArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,for: indexPath) as! HomeCollectionViewCell
        cell.backgroundColor = UIColor.white
        cell.teammateLabel.textColor = UIColor.black
        
        if indexPath.row >= viewModel.teammateArray.count {
            //if there is odd # of teammates/an extra filler cell, fill with bagel image
            showBagelInfo(forCell: cell)
        } else {
            //otherwise show teammate info
            showTeammateInfo(forCell: cell, atIndexPath: indexPath)
        }
        
        return cell
    }
    
    func showTeammateInfo(forCell cell: HomeCollectionViewCell,atIndexPath indexPath: IndexPath) {
        cell.teammateLabel.text = viewModel.teammateArray[indexPath.row].firstName
        let teammateImage = viewModel.image(forIndexPath: indexPath)
        if teammateImage != nil {
            cell.activityIndicator.stopAnimating()
        }
        cell.teammateImageView.image = teammateImage
    }
    
    func showBagelInfo(forCell cell: HomeCollectionViewCell) {
        cell.teammateLabel.text = bagelString
        cell.teammateImageView.image = #imageLiteral(resourceName: "bagel-plain")
        cell.activityIndicator.stopAnimating()
        cell.tag = 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! HomeCollectionViewCell
        guard cell.tag != 1 else {
            showBagelAlert()
            return
        }
        launchDetailVC(withCell: cell, atIndexPath: indexPath)
    }
    
    private func showBagelAlert() {
        let bagelAlertController = UIAlertController(title: bagelString, message: bagelAlertMessage, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: bagelActionTitle, style: .default, handler: nil)
        bagelAlertController.addAction(okayAction)
        present(bagelAlertController, animated: true, completion: nil)
    }
    
    private func launchDetailVC(withCell cell: HomeCollectionViewCell,atIndexPath indexPath: IndexPath) {
        let teammateDetailViewController = TeammateDetailViewController()
        let chosenTeammate = self.viewModel.teammateArray[indexPath.row]
        UIView.animate(withDuration: 0.2, delay: 0, options: .allowUserInteraction, animations: {
            cell.backgroundColor = UIColor(colorLiteralRed: 255/255, green: 46/255, blue: 127/255, alpha: 0.1)
        }) { (true) in
            teammateDetailViewController.teammate = chosenTeammate
            self.navigationController?.pushViewController(teammateDetailViewController, animated: true)
            cell.backgroundColor = UIColor.white
        }
    }
    
}

//Collection view constraints and layout methods
extension HomeViewController {
    
    func addViewsWithConstraints() {
        addCollectionView()
        addLogoImageWithConstraints()
    }
    
    private func addCollectionView() {
        createCollectionViewWithConstraints()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = UIColor(colorLiteralRed: 205/255, green: 235/255, blue: 255/255, alpha: 0.5)
        viewModel.fetchTableViewData()
        setupCollectionViewFlowLayout()
    }
    
    private func createCollectionViewWithConstraints() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(collectionView)
        let xConstraint = collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let bottomConstraint = collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let widthConstraint = collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0)
        let heightConstraint = collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.85)
        xConstraint.isActive = true
        bottomConstraint.isActive = true
        widthConstraint.isActive = true
        heightConstraint.isActive = true
    }
    
    private func setupCollectionViewFlowLayout() {
        let halvedWidthOfCollection = floor(collectionView.frame.width / 2)
        let itemPadding = CGFloat(10.0)
        let collectionItemSide = halvedWidthOfCollection - itemPadding
        layout.itemSize = CGSize(width: collectionItemSide, height: collectionItemSide * 1.3)
        let margin = (collectionView.frame.width - (collectionItemSide * 2)) / 3
        layout.minimumInteritemSpacing = margin - 10
        layout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        layout.minimumLineSpacing = margin
    }
    
    private func addLogoImageWithConstraints() {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "cmblogo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        let xConstraint = imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let topConstraint = imageView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 0)
        let bottomConstraint = imageView.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: 0)
        let widthConstraint = imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        xConstraint.isActive = true
        topConstraint.isActive = true
        widthConstraint.isActive = true
        bottomConstraint.isActive = true
    }
}
