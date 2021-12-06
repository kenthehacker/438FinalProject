//
//  EnemyBullets.swift
//  spaceShooter
//
//  Created by Kenichi Matsuo on 11/16/21.
//

import Foundation

import UIKit

/// Class for enemy bullet functionality
class EnemyBullet: MovableObject{
    var curLoc: CGPoint
    var size: Int
    var hitBound: CGRect
    var col = UIColor.clear
    let speed = CGFloat(10)
    var healthDamage = 10
    var image: UIImage
    required init(location: CGPoint, size: Int){
        self.size = size
        self.curLoc = location
        let cgSize = CGFloat(self.size)
        image = UIImage(named: "EnemyBullet")!
        self.hitBound = CGRect(x: location.x, y: location.y, width: cgSize, height: cgSize)
    }
    func isAlive() -> Bool {
        return true
    }
    
    func getDamage() -> Int{
        return self.healthDamage
    }
    func getX() -> CGFloat{
        return curLoc.x
    }
    func getY() -> CGFloat{
        return curLoc.y
    }
    
    /// Sets a new damage amount for the bullet
    func setNewDamage(n: Int){
        self.healthDamage = n
    }
    
    /// Updates location of the enemy bullet
    func updateLocation(newLoc: CGPoint){
        curLoc = CGPoint(x: self.curLoc.x,y: self.curLoc.y+speed)
        self.hitBound = CGRect(x: curLoc.x, y: curLoc.y, width: CGFloat(size), height: CGFloat(size))
    }
    
    /// Determines if a point is inside an enemy bullet
    func contains(point: CGPoint) -> Bool{
        let bound = CGRect(x:hitBound.minX-10, y: hitBound.minY-10, width: hitBound.width+20, height: hitBound.height+20)
        let bezPath = UIBezierPath(rect: bound)
        return bezPath.contains(point)
    }
    
    /// Draws bullet
    func draw(){
        self.image.draw(in: hitBound)
        self.updateLocation(newLoc: self.curLoc)
    }
    
    func getHealth() -> Int {
        // do nothing
        return 0
    }
    
    func getDMG(){
        // do nothing
    }
}
