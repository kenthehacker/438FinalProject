//
//  BossBaby.swift
//  spaceShooter
//
//  Created by Kenichi Matsuo on 12/4/21.
//

import Foundation
import UIKit

class BossBaby:MovableObject{
    func isAlive() -> Bool {
        return self.alive
    }
    var health = 100
    var alive = true
    var curLoc: CGPoint
    var size: Int
    var hitBound: CGRect
    var col = UIColor.clear
    var image: UIImage
    var speed = CGFloat(10)
    var stopMove = false
    required init(location: CGPoint, size: Int) {
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
    
    func updateLocation(newLoc: CGPoint) {
        
        //TODO: just like level1 enemy have it come down after a certain number of ticks dont let it take hit damage until it has finished descending
        if tick < 75 {  //when the boss level happens you should reset the number of ticks 
            curLoc = CGPoint(x: self.curLoc.x,y: self.curLoc.y+2)
        }else{
            self.stopMove = true
        }
        self.hitBound = CGRect(x: curLoc.x, y: curLoc.y, width: CGFloat(size), height: CGFloat(size))
    }
    
    func contains(point: CGPoint) -> Bool{
        let bound = CGRect(x:hitBound.minX-10, y: hitBound.minY-10, width: hitBound.width+20, height: hitBound.height+20)
        let bezPath = UIBezierPath(rect: bound)
        return bezPath.contains(point)
    }
    func draw(){
        col.setFill()
        self.updateLocation(newLoc: self.curLoc)
        self.image.draw(in: hitBound)
        let bezPath = UIBezierPath(rect: self.hitBound)
        bezPath.fill()
        
    }
    func takeDamage(n: Int){
        self.health = self.health - n
    }
    
}

