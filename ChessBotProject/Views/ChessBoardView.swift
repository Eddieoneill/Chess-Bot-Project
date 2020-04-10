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
    
}

