//
//  Square.swift
//  game
//
//  Created by haoran zhang on 12/26/14.
//  Copyright (c) 2014 haoran zhang. All rights reserved.
//

import Foundation

class Square {
    
    /** A Square on the initial board. */
    let initial: Square = Square(side: Side.WHITE, spots: 1)
    
    /** The Side occupying this Square. */
    var _side: Side!
    
    /** The number of spots in this Square. */
    var _spots: Int!
    /** A new Square occupied by SIDE and containing SPOTS spots. This is
    *  private, since clients will use .square to avoid creation of
    *  redundant objects. */
    init(side: Side, spots: Int) {
        _side = side
        _spots = spots
    }
    
    /** Return a (unique) Square controlled by SIDE with SPOTS spots on it.
    *  We memoize the creation of Squares to save time, since they are
    *  immutable objects.  As a special case, when SPOTS is 0 or SIDE
    *  is WHITE, returns the value of INITIAL. */
    class func square(side: Side, spots: Int) -> Square {
        return Square(side: side, spots: spots)
    }
    
    /** Return the Side controlling this Square. */
    func getSide() -> Side {
        return _side
    }

    /** Return the number of spots for this Square. */
    func getSpots() -> Int {
        return _spots
    }


}