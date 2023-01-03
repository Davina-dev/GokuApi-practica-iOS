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
    var heroes: [Heroe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.title = "Heroes"
        
        let xib = UINib(nibName: "TableCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "customTableCell")
        
        let token = LocalDataLayer.shared.getToken()
        NetworkLayer.shared.fetchHeroes(token: token) { [weak self] allHeroes, error in
            // comprobar si cuando llega la info de la api todavía tenemos esta vista en pantalla
            guard let self = self else { return }
            
            if let allHeroes = allHeroes  {
                self.heroes = allHeroes
                LocalDataLayer.shared.save(heroes: allHeroes)
                
                //al recibir todos los heroes envío esta notificación
                NotificationCenter.default.post(Notification(name: Notification.Name("fetchHeroes")))
                
                //refresh tableview with new data fetched from the API
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                print("Error fetching heroes: ", error?.localizedDescription ?? "")
            }
          }
        
        }
        
        
        // Delegate and Datasource
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return heroes.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "customTableCell", for: indexPath) as! TableCell
            
            let heroe = heroes[indexPath.row]
            
            cell.iconImageView.setImage(url: heroe.photo)
            cell.titleLabel.text = heroe.name
            cell.descLabel.text = heroe.description
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        
        //jugamos con altura celda
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130   }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let heroe = heroes[indexPath.row]
        let detailsView = DetailsViewController()
        detailsView.heroe = heroe
        navigationController?.pushViewController(detailsView, animated: true)
    }
    
 
 
}

    
//para poder descargar la img que nos viene en url

extension UIImageView {
    func setImage(url: String) {
        guard let url = URL(string: url) else { return }
        
        downloadImage(url: url) { [weak self] image in
            guard let self = self else { return }
            
            // cambios de ui al hilo principal
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
    
    private func downloadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            completion(image)
        }
        task.resume()
    }
}
