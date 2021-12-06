//
//  Bullets.swift
//  spaceShooter
//
//  Created by Kenichi Matsuo on 11/15/21.
//

import Foundation
import UIKit

/// Bullets class for player bullets
class Bullet: MovableObject{
    
    var curLoc: CGPoint
    var size: Int
    var hitBound: CGRect
    var image: UIImage
    var col = UIColor.clear
    var speed = CGFloat(10)
    required init(location: CGPoint, size: Int){
        self.size = size
        self.curLoc = location
        let cgSize = CGFloat(self.size)
        self.image = UIImage(named: "FriendlyBullet")!
        self.hitBound = CGRect(x: location.x, y: location.y, width: cgSize, height: cgSize)
    }
    func getX() -> CGFloat{
        return curLoc.x
    }
    func getY() -> CGFloat{
        return curLoc.y
    }
    
    /// Sets a new speed for the bullet
    func newSpeed(n: Int){
        self.speed = CGFloat(n)
    }
    
    /// Updates location of the bullet
    func updateLocation(newLoc: CGPoint){
        curLoc = CGPoint(x: self.curLoc.x,y: self.curLoc.y-speed)
        self.hitBound = CGRect(x: curLoc.x, y: curLoc.y, width: CGFloat(size), height: CGFloat(size))
    }
    
    /// Determines if a point is contained inside the bullet
    func contains(point: CGPoint) -> Bool{
        let bound = CGRect(x:hitBound.minX-10, y: hitBound.minY-10, width: hitBound.width, height: hitBound.height)
        let bezPath = UIBezierPath(rect: bound)
        return bezPath.contains(point)
    }
    
    /// Draws the bullet
    func draw(){
        self.updateLocation(newLoc: self.curLoc)
        self.image.draw(in: hitBound)
    }
    
    /// Determines if the bullet should still exist on screen
    func isAlive() -> Bool {
        return true
    }
    
    func getHealth() -> Int {
        // do nothing and return 0
        return 0
    }
    
    func getDMG(){
        // do nothing
    }
    
}


