//
//  RecommendationsViewController.swift
//  TheMovieDB
//
//  Created by Edwy Lugo on 26/02/20.
//  Copyright © 2020 Edwy Lugo. All rights reserved.
//

import UIKit

class RecommendationsViewController: UIViewController {

   private var collectionView: UICollectionView!
        private var recomendations: [Card] = [Card]()
        private weak var controller : UIViewController!
        
        let margin : CGFloat = 20
        
        init(controller: UIViewController, recommendations: [Card]) {
            super.init(nibName: nil, bundle: nil)
            self.recomendations = recommendations
            self.controller = controller
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.view.backgroundColor = UIColor(named: "background")
            self.configCollection()
        }
        
            func configCollection() {
                // Define a largura dos cards
                let itemWidth = Functions.getItemWidth()
                let itemHeight = Functions.getItemHeight()
                
                let collectionLayout = UICollectionViewFlowLayout()
                collectionLayout.scrollDirection = .horizontal
                collectionLayout.itemSize = CGSize.init(width: itemWidth, height: itemHeight)
                
                self.collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenWidth), collectionViewLayout: collectionLayout)
                
                self.collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
                self.collectionView.delegate = self
                self.collectionView.dataSource = self
                self.collectionView.collectionViewLayout = collectionLayout
                self.collectionView.backgroundColor = UIColor(named: "background")
                self.collectionView.isScrollEnabled = true
                self.collectionView.isUserInteractionEnabled = true
                

                self.view.addSubview(self.collectionView)
            }

    }


    // MARK: Collection view method and delegate
    extension RecommendationsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.recomendations.count
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 5
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CardCollectionViewCell
            let card = self.recomendations[indexPath.item]
            cell.configCell(card: card)
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let card = self.recomendations[indexPath.item]
            let controller = CardViewController.init(card: card)
            self.controller.navigationController?.pushViewController(controller, animated: true)
        }

}
