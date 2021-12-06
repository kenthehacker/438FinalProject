//
//  BossBaby.swift
//  spaceShooter
//
//  Created by Kenichi Matsuo on 12/4/21.
//

import Foundation
import UIKit

class BossBaby:MovableObject{ // Boss battle for game
    func isAlive() -> Bool {
        return self.alive
    }
    var health = 200
    var alive = true
    var curLoc: CGPoint
    var size: Int
    var hitBound: CGRect
    var col = UIColor.clear
    var image: UIImage
    var speed = CGFloat(10)
    var stopMove = false
    
    required init(location: CGPoint, size: Int) { //initialize variables for the boss
        self.curLoc = location
        self.size = size
        self.image = UIImage(named: "GalagaBoss")!
        let cgSize = CGFloat(self.size)
        self.hitBound = CGRect(x: location.x, y: location.y, width: cgSize, height: cgSize)
    }
    
    func getX() -> CGFloat {
        return self.curLoc.x
    }
    
    func getY() -> CGFloat {
        return self.curLoc.y
    }
    
    func updateLocation(newLoc: CGPoint) { //allows boss to enter for a bit before it can be hit, updates its location and hitbox
        
        if tick < 75 {  //when the boss level happens you should reset the number of ticks 
            curLoc = CGPoint(x: self.curLoc.x,y: self.curLoc.y+2)
        }else{
            self.stopMove = true
        }
        self.hitBound = CGRect(x: curLoc.x, y: curLoc.y, width: CGFloat(size), height: CGFloat(size))
    }
    
    func contains(point: CGPoint) -> Bool{ //update bezier path hitbox
        let bound = CGRect(x:hitBound.minX-10, y: hitBound.minY-10, width: hitBound.width+20, height: hitBound.height+20)
        let bezPath = UIBezierPath(rect: bound)
        return bezPath.contains(point)
    }
    func draw(){ //draw the image over hitbox
        self.updateLocation(newLoc: self.curLoc)
        self.image.draw(in: hitBound)
    }
    func takeDamage(n: Int){ //decrease boss health
        self.health = self.health - n
    }
    func getHealth() -> Int { //give the boss health
        return self.health
    }
    func getDMG(){ //needed because of protocol in gameview, have to have because health reduction in master protocol, never used
        self.health = self.health - 10
    }
}

