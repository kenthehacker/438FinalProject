//
//  L1Enemy.swift
//  spaceShooter
//
//  Created by Kenichi Matsuo on 11/15/21.
//

import Foundation
import UIKit
class L1Enemy: MovableObject{
    var health = 100
    var curLoc: CGPoint
    var size: Int
    var hitBound: CGRect
    var col = UIColor.red
    required init(location: CGPoint, size: Int) {
        self.curLoc = location
        self.size = size
        self.hitBound = CGRect(x: curLoc.x, y: curLoc.y, width: CGFloat(size), height: CGFloat(size))
    }
    
    func getX() -> CGFloat {
        return curLoc.x
    }
    
    func getY() -> CGFloat {
        return curLoc.y
    }
    
    func updateLocation(newLoc: CGPoint) {
        //TODO
        //enemy should descend in a formation and descend based tick speed
    }
    
    func contains(point: CGPoint) -> Bool {
        return true
    }
    
    func draw() {
        //TODO
    }
    
    
    
    
}



