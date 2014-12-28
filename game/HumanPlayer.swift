//
//  HumanPlayer.swift
//  game
//
//  Created by haoran zhang on 12/28/14.
//  Copyright (c) 2014 haoran zhang. All rights reserved.
//

import Foundation

class HumanPlayer : Player {
    
    /** A new player initially playing COLOR taking manual input of
    *  moves from GAME's input source. */
    override init(game: Game, color: Side) {
        super.init(game: game, color: color)
    }
    

    /** Retrieve moves using getGame().getMove() until a legal one is found and
    *  make that move in getGame().  Report erroneous moves to player. */
    func makeMove() {
        
    }
    
//    void makeMove() {
//    int[] move = this.getGame().getMove();
//    this.getGame().makeMove(move[0], move[1]);
//    }
    
    

}