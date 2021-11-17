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
        return true
    }
    
    func draw() {
        col.setFill()
        self.updateLocation(newLoc: self.curLoc)
        let bezPath = UIBezierPath(rect: self.hitBound)
        bezPath.fill()
        enemyBulletTicker = enemyBulletTicker + 1
        
    }
    
    
    
    
}



