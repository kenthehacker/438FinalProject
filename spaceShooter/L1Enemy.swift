//
//  L1Enemy.swift
//  spaceShooter
//
//  Created by Kenichi Matsuo on 11/15/21.
//

import Foundation
import UIKit
class L1Enemy: MovableObject{
    func isAlive() -> Bool {
        return self.alive
    }
    
    var health = 100
    var alive = true
    var curLoc: CGPoint
    var size: Int
    var hitBound: CGRect
    var enemyBulletTicker = 0
    var col = UIColor.white
    var stopMove = false
    
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
        if tick < 75 {
            curLoc = CGPoint(x: self.curLoc.x,y: self.curLoc.y+2)
        }else{
            self.stopMove = true
        }
        self.hitBound = CGRect(x: curLoc.x, y: curLoc.y, width: CGFloat(size), height: CGFloat(size))
    }
    
    func contains(point: CGPoint) -> Bool {
        let bound = CGRect(x:hitBound.minX, y: hitBound.minY, width: hitBound.width, height: hitBound.height)
        let bezPath = UIBezierPath(rect: bound)
        let center = bezPath.contains(point)
        
        let boundLeft = CGRect(x:hitBound.minX - 10, y: hitBound.minY, width: hitBound.width, height: hitBound.height)
        let bezPathLeft = UIBezierPath(rect: boundLeft)
        let leftCorner = bezPathLeft.contains(point)
        
        let boundRight = CGRect(x:hitBound.minX + 10, y: hitBound.minY, width: hitBound.width, height: hitBound.height)
        let bezPathRight = UIBezierPath(rect: boundRight)
        let rightCorner = bezPathRight.contains(point)
        
        if center || rightCorner || leftCorner {
            return true
        }
        return false
    }
    
    func draw() {
        col.setFill()
        self.updateLocation(newLoc: self.curLoc)
        let bezPath = UIBezierPath(rect: self.hitBound)
        bezPath.fill()
        enemyBulletTicker = enemyBulletTicker + 1
        
    }
    
    
}



