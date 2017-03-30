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
        title = "Coffee Meets Bagel"
        addCollectionView()
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    func dataDidLoad() {
        collectionView.reloadData()
    }
    
    func imageDidLoad(atIndexPath indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
    
}

//create collection view
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
    
    func createCollectionViewWithConstraints() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        let xConstraint = collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let bottomConstraint = collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        let widthConstraint = collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
        let heightConstraint = collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8)
        xConstraint.isActive = true
        bottomConstraint.isActive = true
        widthConstraint.isActive = true
        heightConstraint.isActive = true
    }
    
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
        cell.teammateLabel.text = viewModel.teammateArray[indexPath.row].firstName
        cell.teammateLabel.textColor = UIColor.black
        cell.teammateImageView.image = viewModel.image(forIndexPath: indexPath)
        return cell
    }
    
    func setupCollectionViewFlowLayout() {
        let visibleCollectionHeight = view.frame.height * 0.75
        layout.sectionInset = UIEdgeInsetsMake(10.0, 5.0, 10.0, 5.0)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 25
        let collectionItemHeight = visibleCollectionHeight / 3.5
        layout.itemSize = CGSize(width: collectionItemHeight, height: collectionItemHeight)
    }
    
}
