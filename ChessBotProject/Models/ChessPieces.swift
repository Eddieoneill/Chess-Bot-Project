//
//  ChessPieces.swift
//  ChessBotProject
//
//  Created by Edward O'Neill on 4/10/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import Foundation

enum WhitePieces: String {
    case pawn = "WhitePawn"
    case knight = "WhiteKnight"
    case bishop = "WhiteBishop"
    case rook = "WhiteRook"
    case queen = "WhiteQueen"
    case king = "WhiteKing"
}

enum BlackPieces: String {
    case pawn = "BlackPawn"
    case knight = "BlackKnight"
    case bishop = "BlackBishop"
    case rook = "BlackRook"
    case queen = "BlackQueen"
    case king = "BlackKing"
}

enum PieceColor: String {
    case black = "black"
    case white = "white"
}

struct ChessPiece {
    var pieceCount: Int
    var currentSpot: (Int, Int)
    var piceType: String
}
