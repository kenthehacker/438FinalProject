//
//  SpaceShip.swift
//  spaceShooter
//
//  Created by Kenichi Matsuo on 11/15/21.
//

import Foundation
import UIKit
class SpaceShip: MovableObject{
    var curLoc: CGPoint
    var health: Int
    var size: Int
    var hitBound: CGRect
    var col = UIColor.white
    required init(location: CGPoint, size:Int){
        self.health = 100
        self.curLoc = location
        self.size = size
        let cgSize = CGFloat(self.size)
        self.hitBound = CGRect(x: location.x - (cgSize/2), y: location.y, width: cgSize, height: cgSize)
        
    }
    func getX() -> CGFloat{
        return self.curLoc.x
    }
    func getY() -> CGFloat{
        return self.curLoc.y
    }
    
    func updateLocation(newLoc: CGPoint){
        self.curLoc = newLoc
        let cgSize = CGFloat(size)
        let hardY = CGFloat(700)
        var hardX = curLoc.x
        if curLoc.x < 0{
            hardX = CGFloat(0)
        }
        if curLoc.x > 370{
            hardX = CGFloat(370-self.size)
        }
        self.hitBound = CGRect(x: hardX - (cgSize/2), y: hardY, width: cgSize, height: cgSize)
     
    }
    func contains(point: CGPoint) -> Bool{
        let bound = CGRect(x:hitBound.minX-10, y: hitBound.minY-10, width: hitBound.width+20, height: hitBound.height+20)
        let bezPath = UIBezierPath(rect: bound)
        return bezPath.contains(point)
    }
    func draw(){
        col.setFill()
        let bezPath = UIBezierPath(rect: self.hitBound)
        bezPath.fill()
    }
    
    func takeDamage(hp: Int) -> Bool{
        self.health = self.health-hp
        if self.health < 0{
            return false
        }
        return true
        //if it returns false then we have to restart the game
    }
    func healthBoost(n: Int){                   //if we got the superhealth boost we'll just increment health by 100
        self.health = self.health + 10
        if self.health > 100{
            self.health = 100
        }
    }
    
}
g
