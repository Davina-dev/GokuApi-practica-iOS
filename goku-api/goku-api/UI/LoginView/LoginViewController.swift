//
//  LoginViewController.swift
//  goku-api
//
//  Created by Davina Medina Ramirez on 23/12/22.
// 

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        
        emailTextField.center.x -= view.bounds.width
        passwordTextField.center.x -= view.bounds.width
        loginButton.alpha = 0
        
        UIView.animate(withDuration:2.5, delay: 0,usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: []){
            self.emailTextField.center.x += self.view.bounds.width
        }
        UIView.animate(withDuration: 3, delay: 0,usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: []){
            self.passwordTextField.center.x += self.view.bounds.width
        }
        UIView.animate(withDuration: 3){
            self.loginButton.alpha = 1
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        guard let email = emailTextField.text, !email.isEmpty else {
            print("email is empty")
            return
        }
        
        guard let password = passwordTextField.text , !password.isEmpty else {
            print("password is empty")
            return
        }
        
        NetworkLayer.shared.login(email: email, password: password) { token, error in
            if let token = token {
                LocalDataLayer.shared.save(token: token)
                print("We got a valid token!")
                print(token)
                
                DispatchQueue.main.async {
                    // deprecated form
                    //UIApplication.shared.keyWindow?.rootViewController = HomeTabBarController()
                    
                    UIApplication
                        .shared
                        .connectedScenes
                        .compactMap{ ($0 as? UIWindowScene)?.keyWindow }
                        .first?
                        .rootViewController = HomeTabBarController()
                }
                
                
            } else {
                print("Login Error: ", error?.localizedDescription ?? "")
            }
        }
    }
    
    
}
