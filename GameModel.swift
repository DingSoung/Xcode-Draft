//
//  GameModel.swift
//  2048
//
//  Created by 丁松 on 14-6-27.
//  Copyright (c) 2014年 丁松. All rights reserved.
//

import Foundation

class GameModel{
    var dimension:Int = 0
    //4*4 = 16
    var tiles:Array<Int>
    
    init(dimension:Int){
        self.dimension = dimension
        self.tiles = Array<Int>(count:self.dimension * self.dimension, repeatedValue:0)
    }
    
    func setPosition(row:Int, col:Int, value:Int) -> Bool {
        assert(row >= 0 && row < dimension)
        assert(col >= 0 && col < dimension)
        var index = self.dimension * row + col
        var val = tiles[index]
        if(val > 0){
            println("Position is used")
            return false
        }
        tiles[index] = value
        return true
    }
    
    func emptyPosition() -> Int[] {
        var emptytiles = Array<Int>()
        var index:Int
        for i in 0..(dimension * dimension) {
            if (tiles[i] == 0) {
                emptytiles += i
            }
        }
        return emptytiles
    }
    
    func isFull() -> Bool {
        if (emptyPosition().count == 0) {
            return true
        }
        return false
    }
}