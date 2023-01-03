//
//  DetailsViewController.swift
//  goku-api
//
//  Created by Davina Medina Ramirez on 1/1/23.
//

import UIKit


class DetailsViewController: UIViewController {

    @IBOutlet weak var heroeImageView: UIImageView!
    @IBOutlet weak var heroeNameLabel: UILabel!
    @IBOutlet weak var heroeDescLabel: UILabel!
    @IBOutlet weak var transformationButton: UIButton!
    
    var heroe: Heroe!
    var transformations :[Transformation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        transformationButton.alpha = 0
        title = heroe.name
        
        heroeImageView.setImage(url: heroe.photo)
        heroeNameLabel.text = heroe.name
        heroeDescLabel.text = heroe.description
    
        let token = LocalDataLayer.shared.getToken()
        
        NetworkLayer
            .shared
            .fetchTransformations(token: token, heroeId: heroe.id) { [weak self] allTrans, error in
                guard let self = self else { return }
                
                if let allTrans = allTrans {
                    self.transformations = allTrans
                    
                    print("trans count: ", allTrans.count)
                    
                    if !self.transformations.isEmpty {
                        DispatchQueue.main.async {
                            self.transformationButton.alpha = 1
                        }
                    }
                    
                } else {
                    print("Error fetching transformations: ", error?.localizedDescription ?? "")
                }
            }
    }

    @IBAction func transformationButtonTapped(_ sender: UIButton) {
        let transView = TransformationsViewController()
        transView.transformations = self.transformations
        
        navigationController?.pushViewController(transView, animated: true)
    }
    
   

}
