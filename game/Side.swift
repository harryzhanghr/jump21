//
//  Side.swift
//  game
//
//  Created by haoran zhang on 12/26/14.
//  Copyright (c) 2014 haoran zhang. All rights reserved.
//

import Foundation

enum Side {
    case WHITE
    case BLUE
    case RED
    
    func opposite() -> Side {
        switch self {
            case BLUE:
                return RED
            case RED:
                return BLUE
            default:
                return WHITE
        }
    }
    

    /** Return true iff it is legal for the player on my Side to play on
    *  a square belonging to SIDE. */
    func playableSquare(side: Side) -> Bool {
        return side == WHITE || side == self
    }
    
//    /** Return the side named SIDENAME, ignoring case differences (convenience
//    *  method). */
//    static Side parseSide(String sideName) {
//    return valueOf(sideName.toUpperCase());
//    }
//    
//    /** Return my lower-case name. */
//    func toString() -> String {
//        return super.toString().toLowerCase();
//    }
//
//    /** Return my capitalized name (convenience method). */
//    public String toCapitalizedString() {
//    return super.toString().charAt(0) + toString().substring(1);
//    }
    
}