//
//  Game.swift
//  game
//
//  Created by haoran zhang on 12/26/14.
//  Copyright (c) 2014 haoran zhang. All rights reserved.
//

import Foundation

class Game {
    
    var _playing: Bool!
    var _board: MutableBoard!
    var _exit: Int!
    var red: Player!
    var blue: Player!
    
    /** Instantiate a new game. */
    init(boardSize: Int) {
        _board = MutableBoard(n: boardSize)
        _exit = -1
        _playing = false
        setManual(Side.RED)
        setManual(Side.BLUE)
    }
    
    func setManual(color: Side) {
        if color == Side.RED {
            red = HumanPlayer(game: self, color: color)
        }
        if color == Side.BLUE{
            blue = HumanPlayer(game: self, color: color)
        }
    }
    
    
    /** Return true iff there is a game in progress. */
    func gameInProgress() -> Bool {
        return _playing
    }
    
    /** Add a spot to R C, if legal to do so. */
    func makeMove(r: Int, c: Int) {
        //assert
        _board.addSpot(_board.whoseMove(), r: r, c: c)
    }
    
    /** Add a spot to square #N, if legal to do so. */
    func makeMove(n: Int) {
        //assert
        _board.addSpot(_board.whoseMove(), n: n)
    }

    /** Check whether we are playing and there is an unannounced winner.
      *  If so, announce and stop play. */
    func checkForWin() -> Side? {
        var winner: Side?
        winner = _board.getWinner()
        if winner != nil {
            _playing = false
            return winner!
        }
        return nil
    }
    
    /** Stop any current game and clear the board to its initial
      *  state. */
    func clear() {
        _board.clear(_board.size())
        _playing = false
    }
    
    
    /** Stop any current game and set the board to an empty N x N board
      *  with numMoves() == 0.  Requires 2 <= N <= 10. */
    func setSize(n: Int) {
        _board.clear(n)
        _playing = false
    }
}