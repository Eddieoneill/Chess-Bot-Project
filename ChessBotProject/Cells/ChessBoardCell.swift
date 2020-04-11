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
    var pieceSelected = false
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
            pieceImageView.topAnchor.constraint(equalTo: topAnchor, constant: 1),
            pieceImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 1),
            pieceImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1),
            pieceImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 1)
        ])
    }
    
    func resetBoardBackGround(_ boardMatrix: [[ChessBoardCell]]) {
        var rowCount = 0
        var cellCount = 0
        
        for cells in boardMatrix {
            for cell in cells {
                if rowCount % 2 == 0 {
                    createRowTypeOne(cell, cellCount)
                } else {
                    createRowTypeTwo(cell, cellCount)
                }
                
                cell.backgroundColor = .black
                cell.pieceSelected = false
                cell.alpha = 1
                cellCount += 1
                
                if cellCount > 7 {
                     rowCount += 1
                     cellCount = 0
                }
            }
        }
    }
    
    private func createRowTypeOne(_ cell: ChessBoardCell, _ cellCount: Int) {
        if cellCount % 2 == 0 {
            cell.pieceImageView.backgroundColor = .white
        } else {
            cell.pieceImageView.backgroundColor = .gray
        }
    }
    
    private func createRowTypeTwo(_ cell: ChessBoardCell, _ cellCount: Int) {
        if cellCount % 2 == 0 {
            cell.pieceImageView.backgroundColor = .gray
        } else {
            cell.pieceImageView.backgroundColor = .white
        }
    }
}

