//
//  DetailsViewController.swift
//  goku-api
//
//  Created by Davina Medina Ramirez on 1/1/23.
//

import UIKit


class DetailsViewController: UIViewController {

    var heroe: Heroe!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = heroe.name
       
       
    }
}
