//
//  ShurikenBullet.swift
//  spaceShooter
//
//  Created by Kenichi Matsuo on 12/4/21.
//

import Foundation
import UIKit

/// Managaes the shuriken bullet type for enemy
class ShurikenBullet: MovableObject{
    var curLoc: CGPoint
    var size: Int
    var hitBound: CGRect
    var col = UIColor.white
    var speedY = CGFloat(10)
    var speedX = CGFloat(10)
    var image: UIImage
    required init(location: CGPoint, size: Int) {
        self.size = size
        self.curLoc = location
        let cgSize = CGFloat(self.size)
        self.image = UIImage(named: "ShurikenBullet")!
        self.hitBound = CGRect(x: location.x, y: location.y, width: cgSize, height: cgSize)
    }
    
    func getX() -> CGFloat {
        return self.curLoc.x
    }
    func setSpeedY(n: CGFloat){
        self.speedY = n
    }
    func setSpeedX(n: CGFloat){
        self.speedX = n
    }
    func getY() -> CGFloat {
        return self.curLoc.y
    }
    
    /// Updates location of the bullet
    func updateLocation(newLoc: CGPoint) {
        curLoc = CGPoint(x: self.curLoc.x+speedX ,y: self.curLoc.y+speedY)
        self.hitBound = CGRect(x: curLoc.x, y: curLoc.y, width: CGFloat(size), height: CGFloat(size))
    }
    
    /// Determines if point is contained inside the bullet
    func contains(point: CGPoint) -> Bool{
        let bound = CGRect(x:hitBound.minX-10, y: hitBound.minY-10, width: hitBound.width+20, height: hitBound.height+20)
        let bezPath = UIBezierPath(rect: bound)
        return bezPath.contains(point)
    }
    
    /// Draws the bullet
    func draw(){
        self.updateLocation(newLoc: self.curLoc)
        self.image.draw(in: hitBound)
    }
    
    func isAlive() -> Bool {
        return true
    }
    
    func getHealth() -> Int {
        // do nothing
        return 0
    }
    func getDMG(){
        // do nothing
    }
}



