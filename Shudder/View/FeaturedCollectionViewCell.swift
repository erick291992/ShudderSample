//
//  FeaturedCollectionViewCell.swift
//  Shudder
//
//  Created by Erick Manrique on 11/10/18.
//  Copyright © 2018 homeapps. All rights reserved.
//

import UIKit

class FeaturedCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlet
    @IBOutlet weak var featuredLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Variables
    let cellId = String(describing: MoviesCollectionViewCell.self)
    let leftPadding:CGFloat = 10
    let rightPadding:CGFloat = 10
    let topPadding:CGFloat = 0
    let bottomPadding:CGFloat = 0
    
    var viewModel: FeaturedCollectionViewCellViewModel? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: cellId)
        // setting up left and right padding for collectionview
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding)
        }
    }

}


extension FeaturedCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - CollectionView methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.featuredPhotos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MoviesCollectionViewCell
        cell.movie = viewModel?.featuredPhotos[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}

