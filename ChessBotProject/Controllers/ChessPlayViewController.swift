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
    private let chessBoard = ChessBoardView()
    private var rowCount = 0
    private var cellCount = 0
    private var boardCells = [ChessBoardCell]()
    private var boardMatrix = [[ChessBoardCell]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = chessBoard
        view.backgroundColor = .systemGray6
        chessBoard.collectionView.dataSource = self
        chessBoard.collectionView.delegate = self
        chessBoard.collectionView.register(ChessBoardCell.self, forCellWithReuseIdentifier: "chessBoardCell")
    }
    
    @IBAction func signoutButtonPressed(_ sender: UIBarButtonItem) {
        databaseService.signoutButtonPressed()
    }
    
    private func createBoard(_ cell: ChessBoardCell) {
        if rowCount % 2 == 0 {
            createRowTypeOne(cell)
        } else {
            createRowTypeTwo(cell)
        }
        
        boardCells.append(cell)
        cellCount += 1
        
        if boardCells.count > 7 {
            boardMatrix.append(boardCells)
            boardCells = []
            rowCount += 1
            cellCount = 0
        }
    }
    
    private func createRowTypeOne(_ cell: ChessBoardCell) {
        if cellCount % 2 == 0 {
            cell.backgroundColor = .white
        } else {
            cell.backgroundColor = .gray
        }
    }
    
    private func createRowTypeTwo(_ cell: ChessBoardCell) {
        if cellCount % 2 == 0 {
            cell.backgroundColor = .gray
        } else {
            cell.backgroundColor = .white
        }
    }
    
    private func checkPiece(_ blackPiece: BlackPieces? = nil, _ whitePieces: WhitePieces? = nil) -> Int {
        if let blackPiece = blackPiece {
            return checkBlackPiece(blackPiece)
        } else if let whitePieces = whitePieces {
            return checkWhitePiece(whitePieces)
        } else {
            return 0
        }
    }
    
    private func checkBlackPiece(_ blackPiece: BlackPieces) -> Int {
        var seen = false
        
        for cell in boardCells {
            guard let piece = cell.piece else { continue }
            
            if piece.piceType == blackPiece.rawValue {
                seen = true
                break
            }
        }
        
        if seen {
            return 2
        } else {
            return 1
        }
    }
    
    private func checkWhitePiece(_ whitePiece: WhitePieces) -> Int {
        var seen = false
        
        for cell in boardCells {
            guard let piece = cell.piece else { continue }
            
            if piece.piceType == whitePiece.rawValue {
                seen = true
                break
            }
        }
        
        if seen {
            return 2
        } else {
            return 1
        }
    }
    
    private func setupPiece(_ cell: ChessBoardCell) {
        if boardMatrix.isEmpty {
            cell.pieceImageView.image = UIImage(named: cell.blackPieces[cellCount].rawValue)
            cell.piece = ChessPiece(pieceCount: checkPiece(cell.blackPieces[cellCount]), currentSpot: (rowCount, cellCount), piceType: PieceColor.black.rawValue)
            cell.isBlackPiece = true
        } else if boardMatrix.count == 1 {
            cell.pieceImageView.image = UIImage(named: BlackPieces.pawn.rawValue)
            cell.piece = ChessPiece(pieceCount: cellCount, currentSpot: (rowCount, cellCount), piceType: PieceColor.black.rawValue)
            cell.isBlackPiece = true
        } else if boardMatrix.count == 6 {
            cell.pieceImageView.image = UIImage(named: WhitePieces.pawn.rawValue)
            cell.piece = ChessPiece(pieceCount: cellCount, currentSpot: (rowCount, cellCount), piceType: PieceColor.white.rawValue)
            cell.isWhitePiece = true
        } else if boardMatrix.count == 7 {
            cell.pieceImageView.image = UIImage(named: cell.whitePieces[cellCount].rawValue)
            cell.piece = ChessPiece(pieceCount: checkWhitePiece(cell.whitePieces[cellCount]), currentSpot: (rowCount, cellCount), piceType: PieceColor.white.rawValue)
            cell.isWhitePiece = true
        }
    }
    
}

extension ChessPlayViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 64
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chessBoardCell", for: indexPath) as! ChessBoardCell
        setupPiece(cell)
        createBoard(cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
