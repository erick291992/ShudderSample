//
//  FeaturedCollectionViewController.swift
//  Shudder
//
//  Created by Erick Manrique on 11/10/18.
//  Copyright © 2018 homeapps. All rights reserved.
//

import UIKit

class FeaturedCollectionViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellId = String(describing: FeaturedCollectionViewCell.self)
    let viewModel:FeaturedCollectionViewControllerViewModel = FeaturedCollectionViewControllerViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting up tab bar blur effect
        setupTabBar()
        // setting navigation bar with blur effert
        setupNavigationBar()
        
        
        setupCollectionView()
        bindViewModel()
        viewModel.getMovies()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Functions
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: cellId)
        
//        collectionView.register(UINib(nibName: cellHeaderId, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: cellHeaderId)
    }
    
    func bindViewModel() {
        // This will allow the collection view to refresh when it finally recieves data from flickr api
        viewModel.featuredCollectionViewCellViewModels.bindAndFire { [unowned self](featuredCollectionViewCellViewModel) in
            self.collectionView.reloadData()
        }
    }
    
    func setupNavigationBar() {
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        let visualEffectView   = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        visualEffectView.frame =  (self.navigationController?.navigationBar.bounds.insetBy(dx: 0, dy: -(statusBarHeight)).offsetBy(dx: 0, dy: -(statusBarHeight)))!
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.addSubview(visualEffectView)
        self.navigationController?.navigationBar.sendSubviewToBack(visualEffectView)
        self.title = "Shudder"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30), NSAttributedString.Key.foregroundColor: UIColor(r: 183.0, g: 37.0, b: 25.0)]
    }
    
    func setupTabBar() {
        let visualEffectView   = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        visualEffectView.frame =  (self.tabBarController?.tabBar.bounds)!
        
        self.tabBarController?.tabBar.isTranslucent = true
        self.tabBarController?.tabBar.backgroundColor = .clear
        self.tabBarController?.tabBar.backgroundImage = UIImage()
        self.tabBarController?.tabBar.addSubview(visualEffectView)
        self.tabBarController?.tabBar.sendSubviewToBack(visualEffectView)
    }

}

extension FeaturedCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - CollectionView methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.featuredCollectionViewCellViewModels.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeaturedCollectionViewCell
        
        let cellViewModel = viewModel.featuredCollectionViewCellViewModels.value[indexPath.row]
        
        cell.viewModel = cellViewModel
        // Normally i would set this in the view model itself but it will get to complicated to do that because the headers titles array is hard coded
        cell.featuredLabel.text = viewModel.featuresHeaderTitles[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
}
