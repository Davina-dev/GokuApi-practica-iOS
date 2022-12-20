//
//  TableViewcontroller.swift
//  goku-api
//
//  Created by Davina Medina Ramirez on 19/12/22.
//

import UIKit

struct CustomItem {
    let image: UIImage
    let text: String
}

class TableViewcontroller: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let customRows = [
        CustomItem(image: UIImage(systemName: "pencil.circle")!, text: "lunes"),
        CustomItem(image: UIImage(systemName: "trash.circle")!, text: "martes"),
        CustomItem(image: UIImage(systemName: "folder.circle")!, text: "miércoles"),
        CustomItem(image: UIImage(systemName: "paperplane.circle")!, text: "jueves"),
        CustomItem(image: UIImage(systemName: "doc.circle")!, text: "viernes"),
        CustomItem(image: UIImage(systemName: "terminal")!, text: "sábado"),
        CustomItem(image: UIImage(systemName: "book.closed")!, text: "domingo")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let xib = UINib(nibName: "TableCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "customTableCell")
    }


// Delegate and Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customRows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "customTableCell", for: indexPath) as! TableCell
        let customItem = customRows[indexPath.row]
        cell.iconImageView.image = customItem.image
        cell.titleLabel.text = customItem.text
        
        return cell
    }
    
    //jugamos con altura celda
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}


