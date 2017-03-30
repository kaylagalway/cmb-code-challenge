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
    
    override func viewDidLoad() {
        addCollectionView()
        addLogoImageWithConstraints()
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    func dataDidLoad() {
        collectionView.reloadData()
    }
    
    func imageDidLoad(atIndexPath indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
    
}

//Layout collection view
extension HomeViewController {
    
    func addCollectionView() {
        createCollectionViewWithConstraints()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = UIColor.white
        viewModel.fetchTableViewData()
        setupCollectionViewFlowLayout()
    }
    
    private func createCollectionViewWithConstraints() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        let xConstraint = collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let bottomConstraint = collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        let widthConstraint = collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0)
        let heightConstraint = collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8)
        xConstraint.isActive = true
        bottomConstraint.isActive = true
        widthConstraint.isActive = true
        heightConstraint.isActive = true
    }
    
    private func setupCollectionViewFlowLayout() {
        let halvedWidthOfCollection = floor(collectionView.frame.width / 2)
        let itemPadding = CGFloat(40.0)
        let collectionItemSide = halvedWidthOfCollection - itemPadding
        layout.itemSize = CGSize(width: collectionItemSide, height: collectionItemSide)
        let margin = (collectionView.frame.width - (collectionItemSide * 2)) / 3
        layout.minimumInteritemSpacing = margin
        layout.sectionInset = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
        layout.minimumLineSpacing = margin
    }
    
    func addLogoImageWithConstraints() {
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

//Collection view delegate methods
extension HomeViewController {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.teammateArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,for: indexPath) as! HomeCollectionViewCell
        cell.teammateLabel.alpha = 1
        cell.teammateLabel.text = viewModel.teammateArray[indexPath.row].firstName
        cell.teammateLabel.textColor = UIColor.black
        cell.teammateImageView.image = viewModel.image(forIndexPath: indexPath)
        cell.teammateImageView.alpha = 0.3
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! HomeCollectionViewCell
        UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            cell.teammateImageView.alpha = 1
        }) { (true) in
            let teammateDetailViewController = TeammateDetailViewController()
            let chosenTeammate = self.viewModel.teammateArray[indexPath.row]
            teammateDetailViewController.teammate = chosenTeammate
            cell.teammateImageView.alpha = 0.5
            self.navigationController?.pushViewController(teammateDetailViewController, animated: true)
        }
    }
    
}




