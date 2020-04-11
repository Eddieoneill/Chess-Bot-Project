//
//  ChessBoardView.swift
//  ChessBotProject
//
//  Created by Edward O'Neill on 4/10/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import UIKit

import UIKit

class ChessBoardView: UIView {
    
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        return cv
    }()
    
    public lazy var player1Label: UILabel = {
        let label = UILabel()
        label.text = "Player1"
        label.font = UIFont.systemFont(ofSize: 25)
        label.textAlignment = .center
        label.backgroundColor = .systemBlue
        label.textColor = .white
        return label
    }()
    
    public lazy var player2Label: UILabel = {
        let label = UILabel()
        label.text = "Player2"
        label.font = UIFont.systemFont(ofSize: 25)
        label.backgroundColor = .systemPink
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    public lazy var player1StartLabel: UILabel = {
        let label = UILabel()
        label.text = "Your turn"
        label.font = UIFont.systemFont(ofSize: 25)
        label.textAlignment = .center
        return label
    }()
    
    public lazy var player2StartLabel: UILabel = {
        let label = UILabel()
        label.text = "Your turn"
        label.font = UIFont.systemFont(ofSize: 25)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupCollectionViewConstraints()
        setupPlayer1LabelConstraints()
        setupPlayer1StartLabelConstraints()
        setupPlayer2LabelConstraints()
        setupPlayer2StartLabelConstraints()
    }
    
    private func setupCollectionViewConstraints() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: centerYAnchor, constant: -200),
            collectionView.leadingAnchor.constraint(equalTo: centerXAnchor, constant: -200),
            collectionView.trailingAnchor.constraint(equalTo: centerXAnchor, constant: 200),
            collectionView.bottomAnchor.constraint(equalTo: centerYAnchor, constant: 200)
        ])
    }
    
    private func setupPlayer1LabelConstraints() {
        addSubview(player1Label)
        player1Label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            player1Label.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            player1Label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -20),
            player1Label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20)
        ])
    }
    
    private func setupPlayer1StartLabelConstraints() {
        addSubview(player1StartLabel)
        player1StartLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            player1StartLabel.topAnchor.constraint(equalTo: player1Label.bottomAnchor, constant: 20),
            player1StartLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -20),
            player1StartLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20)
        ])
    }
    
    private func setupPlayer2LabelConstraints() {
        addSubview(player2Label)
        player2Label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            player2Label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -20),
            player2Label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20),
            player2Label.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupPlayer2StartLabelConstraints() {
        addSubview(player2StartLabel)
        player2StartLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            player2StartLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -20),
            player2StartLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20),
            player2StartLabel.bottomAnchor.constraint(equalTo: player2Label.bottomAnchor, constant: -40)
        ])
    }
    
}

