//
//  Game.swift
//  Criss Cross
//
//  Created by Pet Minuta on 04/01/2017.
//  Copyright © 2017 Pet Minuta. All rights reserved.
//

import UIKit

enum Player {
    case X
    case O
}

enum TileState {
    case occupied(Player)
    case empty
}

enum Result {
    case win(Player)
    case tie
    
    func toString() -> String {
        switch self {
        case .win(Player.X):
            return "Xwins"
        case .win(Player.O):
            return "Owins"
        default:
            return "tied"
        }
    }
}

class Game: NSObject {
    
    private var state = Array(repeating: Array(repeating: TileState.empty, count: 3), count: 3)
    var currentPlayer: Player
    
    init(player: Int) {
        if player == 0 {
            self.currentPlayer = Player.X
        } else {
            self.currentPlayer = Player.O
        }
    }
    
    var result: Result? {
        get {
            var empty = 0
            var hitsXHorizontal = 0
            var hitsXVertical = 0
            var hitsOHorizontal = 0
            var hitsOVertical = 0
            for i in 0...2 {
                hitsXHorizontal = 0
                hitsXVertical = 0
                hitsOHorizontal = 0
                hitsOVertical = 0
                for j in 0...2 {
                    switch self.state[i][j] {
                    case .occupied(Player.X):
                        hitsXHorizontal += 1
                    case .occupied(Player.O):
                        hitsOHorizontal += 1
                    default:
                        empty += 1
                        
                    }
                    switch self.state[j][i] {
                    case .occupied(Player.X):
                        hitsXVertical += 1
                    case .occupied(Player.O):
                        hitsOVertical += 1
                    default:
                        break
                    }
                    if hitsOHorizontal == 3 || hitsOVertical == 3 {
                        return .win(Player.O)
                    } else if hitsXHorizontal == 3 || hitsXVertical == 3{
                        return .win(Player.X)
                    }
                }
            }
            if  empty == 0{
                return .tie
            }
            
            var hitsMainXDiagonal = 0
            var hitsAntiXDiagonal = 0
            
            var hitsMainODiagonal = 0
            var hitsAntiODiagonal = 0
            
            for i in 0...2 {
                switch self.state[i][i] {
                    case .occupied(Player.X):
                        hitsMainXDiagonal += 1
                    case .occupied(Player.O):
                        hitsMainODiagonal += 1
                    default:
                        break
                    
                }
                switch self.state[2 - i][i] {
                case .occupied(Player.X):
                    hitsAntiXDiagonal += 1
                case .occupied(Player.O):
                    hitsAntiODiagonal += 1
                default:
                    break
                }

            }
            
            if hitsMainODiagonal == 3 || hitsAntiODiagonal == 3 {
                return .win(Player.O)
            } else if hitsMainXDiagonal == 3 || hitsAntiXDiagonal == 3{
                return .win(Player.X)
            }
            
            return nil
        }
            
    }
    
    
    func nextMove(row: Int, col: Int) -> String{
        switch self.state[row][col]{
        case .empty:
            state[row][col] = TileState.occupied(self.currentPlayer)
            if let currentResult = self.result {
                return currentResult.toString()
            }
            let currentPlayer = String(describing: self.currentPlayer)
            changeCurrentPlayer()
            return currentPlayer
        default:
            return "again"
        }
    }

    func changeCurrentPlayer() {
        if currentPlayer == Player.O {
            currentPlayer = Player.X
        } else {
            currentPlayer = Player.O
        }
    }
}



