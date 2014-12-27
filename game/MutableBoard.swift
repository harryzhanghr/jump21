//
//  MutableBoard.swift
//  game
//
//  Created by haoran zhang on 12/26/14.
//  Copyright (c) 2014 haoran zhang. All rights reserved.
//

import Foundation
import UIKit

class MutableBoard {
    
    /** Instance variable to store all the information about the boards. */
    var _board: [[Square]]!
    
//    /** Store the undo history of the board. */
//    private Stack<MutableBoard> undoHis = new Stack<MutableBoard>();
    
    /** An N x N board in initial configuration. */
    init(n: Int) {
        _board = [[Square]]()
        for var i = 0; i < n; i++ {
            for var j = 0; j < n; j++ {
                _board[i][j] = Square.square(Side.WHITE, spots: 1)
            }
        }
    }
    
    /** A board whose initial contents are copied from BOARD0, but whose
    *  undo history is clear. */
    init(board0: MutableBoard) {
        _board = [[Square]]()
        for var i = 0; i < board0.size(); i++ {
            for var j = 0; j < board0.size(); j++ {
                _board[i][j] = board0.get(i + 1, c: j + 1)
            }
        }
    }
    
    /** Clear the board. */
    func clear(n: Int) {
        _board = [[Square]]()
        for var i = 0; i < n; i++ {
            for var j = 0; j < n; j++ {
                _board[i][j] = Square.square(Side.WHITE, spots: 1)
            }
        }
    }
    
    /** Copy the board. */
    func copy(board: MutableBoard) {
        _board = [[Square]]()
        for var i = 0; i < board.size(); i++ {
            for var j = 0; j < board.size(); j++ {
                _board[i][j] = board.get(i + 1, c: j + 1)
            }
        }
    }
    
//    /** Copy the contents of BOARD into me, without modifying my undo
//    *  history.  Assumes BOARD and I have the same size. */
//    private void internalCopy(MutableBoard board) {
//    for (int i = 0; i < board.size(); i++) {
//    for (int j = 0; j < board.size(); j++) {
//    _board[i][j] = board.get(i + 1, j + 1);
//    }
//    }
//    }
    
    /** The size of the board.*/
    func size() -> Int {
        return _board.count
    }

    /** Get nth square. */
    func get(n: Int) -> Square {
        var r = row(n)
        var c = col(n)
        return _board[r - 1][c - 1]
    }
    
    /** Returns the contents of the square at row R, column C
      *  1 <= R, C <= size (). */
    func get(r: Int, c: Int) -> Square {
        return get(sqNum(r, c: c))
    }
    
    /** Returns the Side of the player who would be next to move.  If the
      *  game is won, this will return the loser (assuming legal position). */
    func whoseMove() -> Side {
        if ((numPieces() + size()) & 1) == 0 {
            return Side.RED
        }
        return Side.BLUE
    }
    
    /** Return true iff row R and column C denotes a valid square. */
    func exists(r: Int, c: Int) -> Bool {
        return 1 <= r && r <= self.size() && 1 <= c && c <= self.size()
    }
    
    /** Return true iff S is a valid square number. */
    func exists(s: Int) -> Bool {
        var n = self.size()
        return 0 <= s && s <= (n * n)
    }

    
    /** Return the row number for square #N. */
    func row(n: Int) -> Int {
        return n / self.size() + 1
    }
    
    /** Return the column number for square #N. */
    func col(n: Int) -> Int {
        return n % self.size() + 1
    }
    
    /** Return the square number of row R, column C. */
    func sqNum(r: Int, c: Int) -> Int {
        return (c - 1) + (r - 1) * self.size()
    }
    
    /** Returns true iff it would currently be legal for PLAYER to add a spot
    to square at row R, column C. */
    func isLegal(player: Side, r: Int, c: Int) -> Bool {
        return isLegal(player, n: sqNum(r, c: c))
    }
    
    /** Returns true iff it would currently be legal for PLAYER to add a spot
    *  to square #N. */
    func isLegal(player: Side, n: Int) -> Bool {
        var r = row(n)
        var c = col(n)
        var temp: Square = get(r, c: c)
        return temp.getSide() == Side.WHITE || temp.getSide() == player
    }
    
    /** Returns true iff PLAYER is allowed to move at this point. */
    func isLegal(player: Side) -> Bool {
        if player == self.whoseMove() {
            return true
        }
        return false;
    }

    /** Returns the winner of the current position, if the game is over,
    *  and otherwise null. */
    func getWinner() -> Side? {
        var max = size() * size()
        if self.numOfSide(Side.BLUE) == max {
            return Side.BLUE
        } else if self.numOfSide(Side.RED) == max {
            return Side.RED
        }
        return nil
    }


    /** Return number of square that SIDE has.*/
    func numOfSide(side: Side) -> Int {
        var ans = 0
        for var i = 0; i < self.size(); i++ {
            for var j = 0; j < self.size(); j++ {
                var thisSide = self.get(i + 1, c: j + 1).getSide()
                if side == thisSide {
                    ans = ans + 1
                }
            }
        }
        return ans
    }
    

    /** Return total number of spots on board. */
    func numPieces() -> Int {
        var ans = 0
        for var i = 0; i < self.size(); i++ {
            for var j = 0; j < self.size(); j++ {
                ans = ans + self.get(i + 1, c: j + 1).getSpots()
            }
        }
        return ans
    }


    
    /** Returns the number of neighbors of the square at row R, column C. */
    func neighbors(r: Int, c: Int) -> Int {
        var s: Int = size()
        var n: Int = 0
        if r > 1 {
            n += 1
        }
        if c > 1 {
            n += 1
        }
        if r < s {
            n += 1
        }
        if c < s {
            n += 1
        }
        return n
    }
    
    

    /** Returns the number of neighbors of square #N. */
    func neighbors(n: Int) -> Int {
        return neighbors(row(n), c: col(n))
    }

    
    
    /** add spot to R C for player PLAYER. */
    func addSpot(player: Side, r: Int, c: Int) {
        self.markUndo()
        var winner: Side? = getWinner()
        if winner != nil {
            return
        }
        var spots: Int = get(r, c: c).getSpots() + 1;
        if spots > neighbors(r, c: c) {
            _board[r-1][c-1] = Square.square(player, spots: 1)
            if exists(r, c: c - 1) {
                addSpot(player, r: r, c: c - 1)
//                undoHis.pop()
            }
            if exists(r, c: c + 1) {
                addSpot(player, r: r, c: c + 1)
//                undoHis.pop()
            }
            if exists(r - 1, c: c) {
                addSpot(player, r: r - 1, c: c)
//                undoHis.pop()
            }
            if exists(r + 1, c: c) {
                addSpot(player, r: r + 1, c: c)
//                undoHis.pop()
            }
        } else {
            _board[r-1][c-1] = Square.square(player, spots: spots)
        }
    } 
    
    
    /** add using square number.*/
    func addSpot(player: Side, n: Int) {
        var r: Int = row(n)
        var c: Int = col(n)
        addSpot(player, r: r, c: c)
    }

    /** Set the square at row R, column C to NUM spots (0 <= NUM), and give
    *  it color PLAYER if NUM > 0 (otherwise, white).  Clear the undo
    *  history. */
    func set(r: Int, c: Int, num: Int, player: Side) {
        internalSet(sqNum(r, c: c), sq: Square(side: player, spots: num))
    }

    /** Set using square number. */
    func set(n: Int, num: Int, player: Side) {
        internalSet(n, sq: Square(side: player, spots: num))
    }

    
    func undo() {
        
    }
//    @Override
//    void undo() {
//    MutableBoard temp = undoHis.pop();
//    this.internalCopy(temp);
//    }
//    
    
    func markUndo() {
        
    }
//    /** Record the beginning of a move in the undo history. */
//    private void markUndo() {
//    MutableBoard temp = new MutableBoard(this);
//    undoHis.push(temp);
//    }
//    
    
    
    
    /** Set the contents of the square with index IND to SQ. Update counts
    *  of numbers of squares of each color.  */
    func internalSet(ind: Int, sq: Square) {
        var r: Int = row(ind)
        var c: Int = col(ind)
        _board[r-1][c-1] = sq
    }
    
    


    
}

