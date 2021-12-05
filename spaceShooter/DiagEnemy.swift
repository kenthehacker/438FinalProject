//
//  DiagEnemy.swift
//  spaceShooter
//
//  Created by Kenichi Matsuo on 12/4/21.
//

import Foundation
import UIKit
class DiagEnemy:MovableObject{
    
    var curLoc: CGPoint
    var health: Int = 100
    var size: Int
    var hitBound: CGRect
    var col = UIColor.clear
    var image: UIImage
    var speed = CGFloat(2)
    var alive = true
    required init(location: CGPoint, size: Int) {
        self.curLoc = location
        self.size = size
        self.image = UIImage(named: "GalagaEnemy2")!
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
    func getPoint() -> CGPoint{
        return self.curLoc
    }
    
    func updateLocation(newLoc: CGPoint) {
        self.curLoc = CGPoint(x: self.curLoc.x - self.speed, y: self.curLoc.y+self.speed)
        //moves enemy object in diagonal
        self.hitBound = CGRect(x: curLoc.x, y: curLoc.y, width: CGFloat(size), height: CGFloat(size))
    }
    
    func contains(point: CGPoint) -> Bool {
        let bound = CGRect(x:hitBound.minX, y: hitBound.minY, width: hitBound.width+20, height: hitBound.height+20)
        let bezPath = UIBezierPath(rect: bound)
        return bezPath.contains(point)
    }
    
    func draw() {
        col.setFill()
        self.updateLocation(newLoc: curLoc)
        self.image.draw(in: hitBound)
        let bezPath = UIBezierPath(rect: self.hitBound)
        bezPath.fill()
    }
    
    
}
