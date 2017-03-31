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
        addViewsWithConstraints()
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
        cell.teammateLabel.text = viewModel.teammateArray[indexPath.row].firstName
        cell.teammateLabel.textColor = UIColor.black
        cell.backgroundColor = UIColor.white
        cell.teammateImageView.image = viewModel.image(forIndexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let teammateDetailViewController = TeammateDetailViewController()
        let chosenTeammate = self.viewModel.teammateArray[indexPath.row]
        teammateDetailViewController.teammate = chosenTeammate
        self.navigationController?.pushViewController(teammateDetailViewController, animated: true)
        /*
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
 */
    }
    
}

//Layout collection view
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
        layout.minimumInteritemSpacing = margin
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




