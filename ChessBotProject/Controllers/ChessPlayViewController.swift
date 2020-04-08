//
//  ChessPlayViewController.swift
//  ChessBotProject
//
//  Created by Edward O'Neill on 4/8/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import UIKit

class ChessPlayViewController: UIViewController {
    
    private let databaseService = DatabaseService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signoutButtonPressed(_ sender: UIBarButtonItem) {
        databaseService.signoutButtonPressed()
    }
    
}
