//
//  CreateAccountViewController.swift
//  ChessBotProject
//
//  Created by Edward O'Neill on 4/8/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import UIKit
import FirebaseAuth

class CreateAccountViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var databaseService = DatabaseService()
    private var authSession = AuthenticationSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.addTarget(self, action: #selector(enterPressed), for: .editingDidEndOnExit)
        passwordTextField.addTarget(self, action: #selector(enterPressed), for: .editingDidEndOnExit)
    }
    
    @IBAction func createButtonPressed() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        authSession.createNewUser(email: email, password: password) { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Please enter a valid email/password", message: "\(error.localizedDescription)")
                }
            case .success(let authDataResult):
                self?.createDatabaseUser(authDataResult: authDataResult)
            }
        }
    }
    
    @objc func enterPressed() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    private func createDatabaseUser(authDataResult: AuthDataResult) {
        databaseService.createDatabaseUser(authDataResult: authDataResult, accountType: "Ticketmaster") { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Account error", message: error.localizedDescription)
                }
            case .success:
                DispatchQueue.main.async {
                    UIViewController.showViewController(storyBoardName: "Main", viewControllerId: "MainTabBarController")
                }
            }
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        UIViewController.showViewController(storyBoardName: "LoginView", viewControllerId: "LoginViewController")
    }
}
