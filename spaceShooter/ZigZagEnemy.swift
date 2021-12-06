//
//  ZigZagEnemy.swift
//  spaceShooter
//
//  Created by Kenichi Matsuo on 12/4/21.
//

import Foundation
import UIKit
class ZigZagEnemy: MovableObject{
    
    var curLoc: CGPoint
    var health: Int = 100
    var size: Int
    var hitBound: CGRect
    var col = UIColor.clear
    var image: UIImage
    var speed = CGFloat(6)
    var alive = true
    required init(location: CGPoint, size: Int) {
        self.curLoc = location
        self.size = size
        self.image = UIImage(named: "GalagaEnemy4")!
        self.hitBound = CGRect(x: location.x, y: location.y, width: CGFloat(size), height: CGFloat(size))
    }
    
    func getX() -> CGFloat {
        return self.curLoc.x
    }
    
    func getY() -> CGFloat {
        return self.curLoc.y
    }
    
    func updateLocation(newLoc: CGPoint) {
        if Int(self.getX()) > screenWidth{ //if we hit the bounds then we flip direction
            self.speed = self.speed * -1
            self.curLoc = CGPoint(x: CGFloat(screenWidth) - CGFloat(5), y: curLoc.y) //we shift by 5 units to prevent the object from getting stuck
        }
        if Int(self.getX()) < 0{
            self.speed = self.speed * -1
            self.curLoc = CGPoint(x: 0 + CGFloat(5), y: curLoc.y) //we shift by 5 units to prevent the object from getting stuck
        }
        self.curLoc = CGPoint(x: curLoc.x+CGFloat(speed), y: curLoc.y)
        self.hitBound = CGRect(x: curLoc.x, y: curLoc.y, width: CGFloat(size), height: CGFloat(size))
    }
    
    func contains(point: CGPoint) -> Bool {
        let bound = CGRect(x:hitBound.minX, y: hitBound.minY, width: hitBound.width+20, height: hitBound.height+20)
        let bezPath = UIBezierPath(rect: bound)
        return bezPath.contains(point)
    }
    
    func draw() {
        updateLocation(newLoc: curLoc)
        self.image.draw(in: hitBound)
    }
    
    
    func isAlive() -> Bool {
        return self.alive
    }
    
    
    
}


