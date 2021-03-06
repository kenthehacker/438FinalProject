//
//  DiagEnemy.swift
//  spaceShooter
//
//  Created by Kenichi Matsuo on 12/4/21.
//

import Foundation
import UIKit
class DiagEnemy:MovableObject{ //Level 2 enemies
    
    var curLoc: CGPoint
    var health: Int = 100
    var size: Int
    var hitBound: CGRect
    var col = UIColor.clear
    var image: UIImage
    var speed = CGFloat(2)
    var alive = true
    
    required init(location: CGPoint, size: Int) { //initialize lvl 2 enemies
        self.curLoc = location
        self.size = size
        self.image = UIImage(named: "GalagaEnemy2")! //get image
        self.hitBound = CGRect(x: location.x, y: location.y, width: CGFloat(size), height: CGFloat(size))
    }
    func getX() -> CGFloat{
        return self.curLoc.x
    }
    func isAlive() -> Bool {
        return self.alive
    }
    
    func getY() -> CGFloat{
        return self.curLoc.y
    }
    func getPoint() -> CGPoint{ //get location
        return self.curLoc
    }
    
    func updateLocation(newLoc: CGPoint) { //update the location and edit the speed of the enemy
        if self.curLoc.x<0{
            self.curLoc = CGPoint(x: 1, y: self.curLoc.y)
            self.speed = self.speed * -1
        }
        if self.curLoc.x > CGFloat(screenWidth){
            self.curLoc = CGPoint(x: CGFloat(screenWidth-5), y: self.curLoc.y)
            self.speed = self.speed * -1
        }
        self.curLoc = CGPoint(x: self.curLoc.x - self.speed, y: self.curLoc.y+self.speed)
        
        //moves enemy object in diagonal
        self.hitBound = CGRect(x: curLoc.x, y: curLoc.y, width: CGFloat(size), height: CGFloat(size))
    }
    
    func contains(point: CGPoint) -> Bool { //check if a bullet hits the enemy
        let bound = CGRect(x:hitBound.minX, y: hitBound.minY, width: hitBound.width+20, height: hitBound.height+20)
        let bezPath = UIBezierPath(rect: bound)
        return bezPath.contains(point)
    }
    
    func draw() { //prints image
        self.updateLocation(newLoc: curLoc)
        self.image.draw(in: hitBound)
    }
    
    func getHealth() -> Int {
        return 0
    }
    func getDMG(){
        
    }
}
