//
//  LoginViewController.swift
//  ChessBotProject
//
//  Created by Edward O'Neill on 4/8/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import UIKit
import FirebaseAuth

enum AccountState {
  case existingUser
  case newUser
}

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    private var authSession = AuthenticationSession()
    private var databaseService = DatabaseService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.addTarget(self, action: #selector(enterPressed), for: .editingDidEndOnExit)
        passwordTextField.addTarget(self, action: #selector(enterPressed), for: .editingDidEndOnExit)
    }
    
    @objc func enterPressed() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        authSession.signExistingUser(email: email, password: password) { [weak self] (result) in
          switch result {
          case .failure(let error):
            DispatchQueue.main.async {
                self?.showAlert(title: "Please enter valid email/password", message: error.localizedDescription)
            }
          case .success:
            DispatchQueue.main.async {
                UIViewController.showViewController(storyBoardName: "Main", viewControllerId: "MainTabBarController")
            }
          }
        }
    }
    
    @IBAction func createButtonPressed(_ sender: UIButton) {
        UIViewController.showViewController(storyBoardName: "LoginView", viewControllerId: "CreateAccountViewController")
    }
    
}

