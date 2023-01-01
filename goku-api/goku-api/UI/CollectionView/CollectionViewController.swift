//
//  CollectionViewController.swift
//  goku-api
//
//  Created by Davina Medina Ramirez on 20/12/22.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    
  

    @IBOutlet weak var collectionView: UICollectionView!
    
    var heroes: [Heroe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        navigationItem.title = "Heroes"
        heroes = LocalDataLayer.shared.getHeroes()
       
        
        let xib = UINib(nibName: "CollectionCell", bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: "customCollectionCell")
    }


    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes.count    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCollectionCell", for: indexPath) as! CollectionCell
        let heroe = heroes[indexPath.row]
        cell.iconImageView.setImage(url: heroe.photo)
        cell.titleLabel.text = heroe.name
        
        return cell
    }
    
    //modifica celdas
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsInRow: CGFloat = 2
        let spacing: CGFloat = 12 //12 puntos de celda a celda horizontalmente
        let totalSpacing: CGFloat = (itemsInRow - 1) * spacing
        let finalWidth = (collectionView.frame.width - totalSpacing) / itemsInRow
        
        return CGSize(width: finalWidth, height: 100)
    }
    
}
