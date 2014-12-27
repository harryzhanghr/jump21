//
//  Player.swift
//  game
//
//  Created by haoran zhang on 12/26/14.
//  Copyright (c) 2014 haoran zhang. All rights reserved.
//

import Foundation


class Player {
    
    /** A Player in GAME, initially playing COLOR. */
    func Player(game: Game, color: Side) {
        _game = game
        _color = color
    }

    
    /** Return the color I am currently playing. */
    func getSide() -> Side {
        return _color
    }
    
    
    /** Return the Game I am currently playing in. */
    func getGame() -> Game {
        return _game
    }
    
    /** Return the Board containing the current position
      *  (read-only).*/
//    func getBoard() -> MutableBoard {
//      return _game.getBoard()
//    }
    
    /** My current color. */
    var _color: Side!
    /** The game I'm in. */
    var _game: Game!
    
    
    
//    /** Ask my game to make my next move.  Assumes that I am of the
//    *  proper color and that the game is not yet won. */
//    abstract void makeMove();
    
}
