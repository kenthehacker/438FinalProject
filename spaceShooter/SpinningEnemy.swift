//
//  SpinningEnemy.swift
//  spaceShooter
//
//  Created by Kenichi Matsuo on 12/4/21.
//

import Foundation
import UIKit
class SpinningEnemy:MovableObject{
    var curLoc: CGPoint
    var health: Int = 100
    var size: Int
    var hitBound: CGRect
    var col = UIColor.white
    var image: UIImage
    var speed = CGFloat(6)
    var rotSpeed = 100
    var alive = true
    var radius: Int = 100
    var theta = 0.0
    var centre: CGPoint
    required init(location: CGPoint, size: Int) {
        self.centre = location
        self.curLoc = location
        self.size = size
        self.image = UIImage(named: "GalagaEnemy1")!
        self.hitBound = CGRect(x: location.x, y: location.y, width: CGFloat(size), height: CGFloat(size))
    }
    
    func getX() -> CGFloat {
        return self.curLoc.x
    }
    
    func getY() -> CGFloat {
        return self.curLoc.y
    }
    func getPoint() -> CGPoint{
        return self.curLoc
    }
    
    func updateLocation(newLoc: CGPoint) {
        theta = theta + Double.pi/Double(rotSpeed)
        let newX = self.centre.x + 1.5*Double(self.radius) * cos(theta)
        let newY = self.centre.y + Double(self.radius) * sin(theta)
        curLoc = CGPoint(x: newX, y: newY)
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
    
    
    func isAlive() -> Bool{
        return self.alive
    }
    
    
}



