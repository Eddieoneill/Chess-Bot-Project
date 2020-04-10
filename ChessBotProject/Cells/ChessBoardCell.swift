//
//  ChessBoardCell.swift
//  ChessBotProject
//
//  Created by Edward O'Neill on 4/10/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import UIKit

class ChessBoardCell: UICollectionViewCell {
    
    let whitePieces: [WhitePieces] = [.rook, .knight, .bishop, .queen, .king, .bishop, .knight, .rook]
    let blackPieces: [BlackPieces] = [.rook, .knight, .bishop, .king, .queen, .bishop, .knight, .rook]
    var moved = false
    var isWhitePiece = false
    var isBlackPiece = false
    var piece: ChessPiece?
    
    public lazy var pieceImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "")
        iv.contentMode = .scaleAspectFit
        return iv
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
        setupPiceImageViewConstrains()
    }
    
    private func setupPiceImageViewConstrains() {
        addSubview(pieceImageView)
        pieceImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pieceImageView.topAnchor.constraint(equalTo: topAnchor),
            pieceImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pieceImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pieceImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
//    public func configureCell(book: BookInfo) {
//        bookTitle.text = book.title
//
//        bookDiscription.text = book.description
//
//        newsImageView.getImage(with: book.bookImage) { [weak self](result) in
//
//            switch result {
//            case .failure(let appError):
//                print("no image found: \(appError)")
//            case .success(let image):
//                DispatchQueue.main.async {
//                    self?.newsImageView.image = image
//                }
//            }
//        }
//    }
}

