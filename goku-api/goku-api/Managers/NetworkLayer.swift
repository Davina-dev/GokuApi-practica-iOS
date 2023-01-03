//
//  NetworkLayer.swift
//  goku-api
//
//  Created by Davina Medina Ramirez on 23/12/22.
//-> ¡¡¡ Capa dee llamar a la API !!!


import Foundation

enum NetworkError: Error{
    case malformedURL
    case noData
    case statusCode(code: Int?)
    case decodingFailed
    case unknown
}

final class NetworkLayer {
    
    static let shared = NetworkLayer()
    
    func login(email: String, password: String, completion: @escaping (String?, Error?) -> Void){
        //url
        guard let url = URL(string: "https://dragonball.keepcoding.education/api/auth/login") else {
            completion(nil, NetworkError.malformedURL)
            return
        }
        // email y password lo convierto a base64
        let loginstring = "\(email):\(password)"
        let loginData: Data = loginstring.data(using: .utf8)!
        let base64 =  loginData.base64EncodedString()
        
        // lo pongo en la cabecera
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Basic \(base64)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: urlRequest){ data, response, error in
            
            guard error == nil else {completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NetworkError.noData)
                return
                
            }
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                completion(nil, NetworkError.statusCode(code: statusCode))
                return
            }
            
            // lo convierto en una cadena (token)
            guard let token = String(data: data, encoding: .utf8) else {
                completion(nil, NetworkError.decodingFailed)
                return
            }
            completion(token, nil)
        }
        task.resume()
    }
    
    // ¿funcion dsloguear???? BUSCAR
    
    
    //post lista heroer
    func fetchHeroes(token : String?, completion: @escaping ([Heroe]?, Error?)-> Void){
        //url
        guard let url = URL(string: "https://dragonball.keepcoding.education/api/heros/all") else {
            completion(nil, NetworkError.malformedURL)
            return
        }
        
        // en método post para traer heroes necesitamos pasar parámetro obligatorio a la query
        var urlComponnts = URLComponents()
        urlComponnts.queryItems = [URLQueryItem(name: "name", value: "")]
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
        urlRequest.httpBody = urlComponnts.query?.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard error == nil else {
                completion(nil, error)
                return
            }
            //comprovar que tenemos data
            guard let data = data else {
                completion(nil, NetworkError.noData)
                return
            }
            
            guard let heroes = try? JSONDecoder().decode([Heroe].self, from: data) else{
                completion(nil, NetworkError.decodingFailed)
                return
            }
            // Yu.huu!
            completion(heroes, nil)
        }
        
        task.resume()
    }
    
    // repetimos lo mismo para transformaciones d heros
    
    func fetchTransformations(token: String?, heroeId: String?, completion: @escaping ([Transformation]?, Error?) -> Void) {
        guard let url = URL(string: "https://dragonball.keepcoding.education/api/heros/tranformations") else {
            completion(nil, NetworkError.malformedURL)
            return
        }
        
        var urlComponents = URLComponents()
        urlComponents.queryItems = [URLQueryItem(name: "id", value: heroeId ?? "")]
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
        urlRequest.httpBody = urlComponents.query?.data(using: .utf8)
        
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                completion(nil, NetworkError.statusCode(code: statusCode))
                print("Error loading URL: Status error --> ", (response as? HTTPURLResponse)?.statusCode ?? -1)
                return
            }
            
            guard let data = data else {
                completion(nil, NetworkError.noData)
                return
            }
            
            guard let transformations = try? JSONDecoder().decode([Transformation].self, from: data) else {
                completion(nil, NetworkError.decodingFailed)
                return
            }
            
            // Yu-huu!
            completion(transformations, nil)
        }
        
        task.resume()
    }
    
    
    
    
}
