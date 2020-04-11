//
//  ChessPieceMovement.swift
//  ChessBotProject
//
//  Created by Edward O'Neill on 4/10/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import Foundation

class PieceMovementManager {
    

    func whitePawnMovement(_ cell: ChessBoardCell, _ mtx: [[ChessBoardCell]]) {
        guard let piece = cell.piece else { return }
        let currentSpot = piece.currentSpot
        
        if !mtx[currentSpot.0 - 1][currentSpot.1].isBlackPiece && !cell.moved && !mtx[currentSpot.0 - 2][currentSpot.1].isBlackPiece {
            let cell1 = mtx[currentSpot.0 - 1][currentSpot.1]
            let cell2 = mtx[currentSpot.0 - 2][currentSpot.1]
            
            cell1.backgroundColor = .red
            cell1.piece = ChessPiece(pieceCount: 0, currentSpot: (currentSpot.0 - 1, currentSpot.1), pieceType: "space")
            cell2.piece = ChessPiece(pieceCount: 0, currentSpot: (currentSpot.0 - 2, currentSpot.1), pieceType: "space")
            cell2.backgroundColor = .red
            cell1.alpha = 0.7
            cell2.alpha = 0.7
        } else if !mtx[currentSpot.0 - 1][currentSpot.1].isBlackPiece {
            let cell1 = mtx[currentSpot.0 - 1][currentSpot.1]
            cell1.backgroundColor = .red
            cell1.piece = ChessPiece(pieceCount: 0, currentSpot: (currentSpot.0 - 1, currentSpot.1), pieceType: "space")
            cell1.alpha = 0.7
        }
        
        if currentSpot.1 != 7 && mtx[currentSpot.0 - 1][currentSpot.1 + 1].isBlackPiece {
            let cell1 = mtx[currentSpot.0 - 1][currentSpot.1 + 1]
            cell1.backgroundColor = .red
            cell1.piece = ChessPiece(pieceCount: 0, currentSpot: (currentSpot.0 - 1, currentSpot.1 + 1), pieceType: "space")
            cell1.alpha = 0.7
        }
        
        if currentSpot.1 != 0 && mtx[currentSpot.0 - 1][currentSpot.1 - 1].isBlackPiece {
            let cell1 = mtx[currentSpot.0 - 1][currentSpot.1 - 1]
            cell1.backgroundColor = .red
            cell1.piece = ChessPiece(pieceCount: 0, currentSpot: (currentSpot.0 - 1, currentSpot.1 - 1), pieceType: "space")
            cell1.alpha = 0.7
        }
        
        cell.pieceSelected = true
    }
    
    func blackPawnMovement(_ cell: ChessBoardCell, _ mtx: [[ChessBoardCell]]) {
        guard let piece = cell.piece else { return }
        let currentSpot = piece.currentSpot
        
        if !mtx[currentSpot.0 + 1][currentSpot.1].isWhitePiece && !cell.moved && !mtx[currentSpot.0 + 2][currentSpot.1].isBlackPiece {
            let cell1 = mtx[currentSpot.0 + 1][currentSpot.1]
            let cell2 = mtx[currentSpot.0 + 2][currentSpot.1]
            
            cell1.backgroundColor = .red
            cell1.piece = ChessPiece(pieceCount: 0, currentSpot: (currentSpot.0 + 1, currentSpot.1), pieceType: "space")
            cell2.piece = ChessPiece(pieceCount: 0, currentSpot: (currentSpot.0 + 2, currentSpot.1), pieceType: "space")
            cell2.backgroundColor = .red
            cell1.alpha = 0.7
            cell2.alpha = 0.7
        } else if !mtx[currentSpot.0 + 1][currentSpot.1].isWhitePiece {
            let cell1 = mtx[currentSpot.0 + 1][currentSpot.1]
            cell1.backgroundColor = .red
            cell1.piece = ChessPiece(pieceCount: 0, currentSpot: (currentSpot.0 + 1, currentSpot.1), pieceType: "space")
            cell1.alpha = 0.7
        }
        
        if currentSpot.1 != 7 && mtx[currentSpot.0 + 1][currentSpot.1 + 1].isWhitePiece {
            let cell1 = mtx[currentSpot.0 + 1][currentSpot.1 + 1]
            cell1.backgroundColor = .red
            cell1.piece = ChessPiece(pieceCount: 0, currentSpot: (currentSpot.0 + 1, currentSpot.1 + 1), pieceType: "space")
            cell1.alpha = 0.7
        }
        
        if currentSpot.1 != 0 && mtx[currentSpot.0 + 1][currentSpot.1 - 1].isWhitePiece {
            let cell1 = mtx[currentSpot.0 + 1][currentSpot.1 - 1]
            cell1.backgroundColor = .red
            cell1.piece = ChessPiece(pieceCount: 0, currentSpot: (currentSpot.0 + 1, currentSpot.1 - 1), pieceType: "space")
            cell1.alpha = 0.7
        }
        
        cell.pieceSelected = true
    }
    
    func whiteRookMovement(_ cell: ChessBoardCell, _ mtx: [[ChessBoardCell]]) {
        
    }
    
    func blackRookMovement(_ cell: ChessBoardCell, _ mtx: [[ChessBoardCell]]) {
        
    }
    
    func whiteKnightMovement(_ cell: ChessBoardCell, _ mtx: [[ChessBoardCell]]) {
        
    }
    
    func blackKnightMovement(_ cell: ChessBoardCell, _ mtx: [[ChessBoardCell]]) {
        
    }
    
    func whiteBishopMovement(_ cell: ChessBoardCell, _ mtx: [[ChessBoardCell]]) {
        
    }
    
    func blackBishopMovement(_ cell: ChessBoardCell, _ mtx: [[ChessBoardCell]]) {
        
    }
    
    func whiteQueenMovement(_ cell: ChessBoardCell, _ mtx: [[ChessBoardCell]]) {
        
    }
    
    func blackQueenMovement(_ cell: ChessBoardCell, _ mtx: [[ChessBoardCell]]) {
        
    }
    
    func whiteKingMovement(_ cell: ChessBoardCell, _ mtx: [[ChessBoardCell]]) {
        
    }
    
    func blackKingMovement(_ cell: ChessBoardCell, _ mtx: [[ChessBoardCell]]) {
        
    }
    
    func moveToSelected(_ cell: ChessBoardCell, _ selectedPiece: ChessBoardCell) {
        guard var piece = cell.piece else { return }
        guard let selectedP = selectedPiece.piece else { return }
        
        cell.pieceImageView.image = selectedPiece.pieceImageView.image
        cell.isWhitePiece = selectedPiece.isWhitePiece
        cell.isBlackPiece = selectedPiece.isBlackPiece
        piece.pieceCount = selectedP.pieceCount
        piece.pieceType = selectedP.pieceType
        cell.piece = piece
        cell.moved = true
        selectedPiece.pieceImageView.image = nil
        selectedPiece.isWhitePiece = false
        selectedPiece.isBlackPiece = false
        selectedPiece.piece = nil
        
    }
    
}
