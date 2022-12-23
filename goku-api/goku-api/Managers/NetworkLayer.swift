//
//  NetworkLayer.swift
//  goku-api
//
//  Created by Davina Medina Ramirez on 23/12/22.
//-> Llamamos a la api


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
}
