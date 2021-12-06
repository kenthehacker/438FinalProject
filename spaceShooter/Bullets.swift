//
//  Bullets.swift
//  spaceShooter
//
//  Created by Kenichi Matsuo on 11/15/21.
//

import Foundation
import UIKit

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
    func newSpeed(n: Int){
        self.speed = CGFloat(n)
    }
    func getX() -> CGFloat{
        return curLoc.x
    }
    func getY() -> CGFloat{
        return curLoc.y
    }
    func updateLocation(newLoc: CGPoint){
        curLoc = CGPoint(x: self.curLoc.x,y: self.curLoc.y-speed)
        self.hitBound = CGRect(x: curLoc.x, y: curLoc.y, width: CGFloat(size), height: CGFloat(size))
    }
    func contains(point: CGPoint) -> Bool{
        let bound = CGRect(x:hitBound.minX-10, y: hitBound.minY-10, width: hitBound.width, height: hitBound.height)
        let bezPath = UIBezierPath(rect: bound)
        return bezPath.contains(point)
    }
    func draw(){
        self.updateLocation(newLoc: self.curLoc)
        self.image.draw(in: hitBound)
    }
    func isAlive() -> Bool {
        return true
    }
    func getHealth() -> Int {
        return 0
    }
    func getDMG(){
        
    }
    
}


