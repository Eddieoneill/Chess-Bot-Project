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
    private var selectedCell: ChessBoardCell?
    private var boardCells = [ChessBoardCell]()
    private var boardMatrix = [[ChessBoardCell]]()
    private let movementManager = PieceMovementManager()
    private var turnCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chessBoard.backgroundColor = .systemGray6
        view = chessBoard
        //view.backgroundColor = .systemGray6
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
        
        cell.backgroundColor = .black
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
            cell.pieceImageView.backgroundColor = .white
        } else {
            cell.pieceImageView.backgroundColor = .gray
        }
    }

    private func createRowTypeTwo(_ cell: ChessBoardCell) {
        if cellCount % 2 == 0 {
            cell.pieceImageView.backgroundColor = .gray
        } else {
            cell.pieceImageView.backgroundColor = .white
        }
    }
    
    private func checkPiece(_ cell: ChessBoardCell) -> Int {
        guard let piece = cell.piece else { return 0 }
        var seen = false
        
        for newCell in boardCells {
            guard let newPiece = newCell.piece else { continue }
            
            if piece.pieceType == newPiece.pieceType {
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
            let pieceType = cell.blackPieces[cellCount].rawValue
            cell.pieceImageView.image = UIImage(named: pieceType)
            cell.piece = ChessPiece(pieceCount: checkPiece(cell), currentSpot: (rowCount, cellCount), pieceType: pieceType)
            cell.isBlackPiece = true
        } else if boardMatrix.count == 1 {
            let pieceType = BlackPieces.pawn.rawValue
            cell.pieceImageView.image = UIImage(named: pieceType)
            cell.piece = ChessPiece(pieceCount: cellCount, currentSpot: (rowCount, cellCount), pieceType: pieceType)
            cell.isBlackPiece = true
        } else if boardMatrix.count == 6 {
            let pieceType = WhitePieces.pawn.rawValue
            cell.pieceImageView.image = UIImage(named: pieceType)
            cell.piece = ChessPiece(pieceCount: cellCount, currentSpot: (rowCount, cellCount), pieceType: pieceType)
            cell.isWhitePiece = true
        } else if boardMatrix.count == 7 {
            let pieceType = cell.whitePieces[cellCount].rawValue
            cell.pieceImageView.image = UIImage(named: cell.whitePieces[cellCount].rawValue)
            cell.piece = ChessPiece(pieceCount: checkPiece(cell), currentSpot: (rowCount, cellCount), pieceType: pieceType)
            cell.isWhitePiece = true
        }
    }
    
    private func changePawn(_ cell: ChessBoardCell, _ isWhite: Bool) {
        let title = "Your pawn has reached the end"
        let message = "Please select the piece you want your pawn to become"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let rookAction = UIAlertAction(title: "Rook", style: .default) { (alertAction) in
            var type = ""
            if isWhite {
                type = WhitePieces.rook.rawValue
            } else {
                type = BlackPieces.rook.rawValue
            }
            cell.pieceImageView.image = UIImage(named: type)
            cell.piece?.pieceType = type
        }
        let knightAction = UIAlertAction(title: "Knight", style: .default) { (alertAction) in
            var type = ""
            if isWhite {
                type = WhitePieces.knight.rawValue
            } else {
                type = BlackPieces.knight.rawValue
            }
            cell.pieceImageView.image = UIImage(named: type)
            cell.piece?.pieceType = type
        }
        let bishopAction = UIAlertAction(title: "Bishop", style: .default) { (alertAction) in
            var type = ""
            if isWhite {
                type = WhitePieces.bishop.rawValue
            } else {
                type = BlackPieces.bishop.rawValue
            }
            cell.pieceImageView.image = UIImage(named: type)
            cell.piece?.pieceType = type
        }
        let queenAction = UIAlertAction(title: "Queen", style: .default) { (alertAction) in
            var type = ""
            if isWhite {
                type = WhitePieces.queen.rawValue
            } else {
                type = BlackPieces.queen.rawValue
            }
            cell.pieceImageView.image = UIImage(named: type)
            cell.piece?.pieceType = type
        }
        
        alertController.addAction(rookAction)
        alertController.addAction(knightAction)
        alertController.addAction(bishopAction)
        alertController.addAction(queenAction)
        present(alertController, animated: true)
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
        guard let cell = collectionView.cellForItem(at: indexPath) as? ChessBoardCell else { return }
        
        if cell.isBlackPiece && turnCounter % 2 == 0 {
            guard let piece = cell.piece else { return }
            cell.resetBoardBackGround(boardMatrix)
            print(piece.pieceType)
            switch piece.pieceType {
            case BlackPieces.pawn.rawValue:
                movementManager.blackPawnMovement(cell, boardMatrix)
            case BlackPieces.knight.rawValue:
                movementManager.blackKnightMovement(cell, boardMatrix)
            case BlackPieces.rook.rawValue:
                movementManager.blackRookMovement(cell, boardMatrix)
            case BlackPieces.bishop.rawValue:
                movementManager.blackBishopMovement(cell, boardMatrix)
            case BlackPieces.queen.rawValue:
                movementManager.blackQueenMovement(cell, boardMatrix)
            case BlackPieces.king.rawValue:
                movementManager.blackKingMovement(cell, boardMatrix)
            default:
                print("couldn't figure out what piece you selected")
                return
            }
        } else if cell.isWhitePiece && turnCounter % 2 != 0 {
            guard let piece = cell.piece else { return }
            cell.resetBoardBackGround(boardMatrix)
            print(piece.pieceType)
            switch piece.pieceType {
            case WhitePieces.pawn.rawValue:
                movementManager.whitePawnMovement(cell, boardMatrix)
            case WhitePieces.knight.rawValue:
                movementManager.whiteKnightMovement(cell, boardMatrix)
            case WhitePieces.rook.rawValue:
                movementManager.whiteRookMovement(cell, boardMatrix)
            case WhitePieces.bishop.rawValue:
                movementManager.whiteBishopMovement(cell, boardMatrix)
            case WhitePieces.queen.rawValue:
                movementManager.whiteQueenMovement(cell, boardMatrix)
            case WhitePieces.king.rawValue:
                movementManager.whiteKingMovement(cell, boardMatrix)
            default:
                print("couldn't figure out what piece you selected")
                return
            }
        } else if cell.backgroundColor == .red {
            guard let selectedCell = selectedCell else { return }
            var player = ""
            
            movementManager.moveToSelected(cell, selectedCell)
            cell.resetBoardBackGround(boardMatrix)
            turnCounter += 1
            if turnCounter % 2 == 0 {
                player = "Player1"
            } else {
                player = "Player2"
            }
            showAlert(title: "\(player)'s turn", message: "Please select your move")
        }
        
        if cell.isWhitePiece {
            guard let piece = cell.piece else { return }
            
            if piece.pieceType == WhitePieces.pawn.rawValue && piece.currentSpot.0 == 0 {
                changePawn(cell, true)
            }
        } else if cell.isBlackPiece {
            guard let piece = cell.piece else { return }
            
            if piece.pieceType == BlackPieces.pawn.rawValue && piece.currentSpot.0 == 7 {
                changePawn(cell, false)
            }
        }
        
        selectedCell = cell
        
    }
}
