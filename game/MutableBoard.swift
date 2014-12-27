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
                _board[i][j] = Square.square(Side.WHITE, 1)
            }
        }
    }
    
    /** A board whose initial contents are copied from BOARD0, but whose
    *  undo history is clear. */
    init(board0: MutableBoard) {
        _board = [[Square]]()
        for var i = 0; i < board0.size(); i++ {
            for var j = 0; j < board0.size(); j++ {
                _board[i][j] = board0.get(r: i + 1, c: j + 1)
            }
        }
    }
    
    /** Clear the board. */
    func clear(n: Int) {
        _board = [[Square]]()
        for var i = 0; i < n; i++ {
            for var j = 0; j < n; j++ {
                _board[i][j] = Square.square(side: Side.WHITE, spots: 1)
            }
        }
    }
    
    /** Copy the board. */
    func copy(board: MutableBoard) {
        _board = [[Square]]()
        for var i = 0; i < board.size(); i++ {
            for var j = 0; j < board.size(); j++ {
                _board[i][j] = board.get(r: i + 1, c: j + 1)
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
        return get(sqNum(r, c))
    }
    
//    /** Returns the Side of the player who would be next to move.  If the
//    *  game is won, this will return the loser (assuming legal position). */
//    Side whoseMove() {
//    return ((numPieces() + size()) & 1) == 0 ? RED : BLUE;
//    }
    
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
        return isLegal(player, sqNum(r, c))
    }
    
    /** Returns true iff it would currently be legal for PLAYER to add a spot
    *  to square #N. */
    func isLegal(player: Side, n: Int) -> Bool {
        var r = row(n)
        var c = col(n)
        return get(r, c).getSide().equals(Side.WHITE) ||
               get(r, c).getSide().equals(player)
    }
    
    /** Returns true iff PLAYER is allowed to move at this point. */
    func isLegal(player: Side) -> Bool {
        if player.equals(self.whoseMove()) {
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
    }


    /** Return number of square that SIDE has.*/
    func numOfSide(side: Side) -> Int {
        var ans = 0
        for var i = 0; i < self.size(); i++ {
            for var j = 0; j < self.size(); j++ {
                var thisSide = self.get(i + 1, j + 1).getSide()
                if side.equals(thisSide) {
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
                ans = ans + self.get(i + 1, j + 1).getSpots()
            }
        }
        return ans
    }

//    
//    /** add spot to R C for player PLAYER. */
//    void addSpot(Side player, int r, int c) {
//    this.markUndo();
//    Side winner = getWinner();
//    if (winner != null) {
//    return;
//    }
//    int spots = super.get(r, c).getSpots() + 1;
//    if (spots > super.neighbors(r, c)) {
//    _board[r - 1][c - 1] = Square.square(player, 1);
//    if (super.exists(r, c - 1)) {
//    addSpot(player, r, c - 1);
//    undoHis.pop();
//    }
//    if (super.exists(r, c + 1)) {
//    addSpot(player, r, c + 1);
//    undoHis.pop();
//    }
//    if (super.exists(r - 1, c)) {
//    addSpot(player, r - 1, c);
//    undoHis.pop();
//    }
//    if (super.exists(r + 1, c)) {
//    addSpot(player, r + 1, c);
//    undoHis.pop();
//    }
//    } else {
//    _board[r - 1][c - 1] = Square.square(player, spots);
//    }
//    announce();
//    }
//    
//    @Override
//    void addSpot(Side player, int n) {
//    int r = super.row(n);
//    int c = super.col(n);
//    addSpot(player, r, c);
//    announce();
//    }
//    
//    @Override
//    void set(int r, int c, int num, Side player) {
//    internalSet(sqNum(r, c), square(player, num));
//    }
//    
//    @Override
//    void set(int n, int num, Side player) {
//    internalSet(n, square(player, num));
//    announce();
//    }
//    
//    @Override
//    void undo() {
//    MutableBoard temp = undoHis.pop();
//    this.internalCopy(temp);
//    }
//    
//    /** Record the beginning of a move in the undo history. */
//    private void markUndo() {
//    MutableBoard temp = new MutableBoard(this);
//    undoHis.push(temp);
//    }
//    
//    /** Set the contents of the square with index IND to SQ. Update counts
//    *  of numbers of squares of each color.  */
//    private void internalSet(int ind, Square sq) {
//    int r = super.row(ind);
//    int c = super.col(ind);
//    _board[r - 1][c - 1] = sq;
//    }
//    
//    /** Notify all Observers of a change. */
//    private void announce() {
//    setChanged();
//    notifyObservers();
//    }
    
}

