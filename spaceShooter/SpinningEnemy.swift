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
    var health: Int
    var size: Int
    var hitBound: CGRect
    var col = UIColor.blue
    var speed = CGFloat(6)
    var alive = true
    var radius: Int
    required init(location: CGPoint, size: Int) {
        self.curLoc = location
        self.size = size
    }
    init(location: CGPoint, size: Int, radius: Int){
        self.curLoc = location
        self.size = size
        self.radius = radius
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
        let newX = self.curLoc.x + cos(Double(speed)*Double.pi / 180.0)
        let newY = self.curLoc.y + sin(Double(speed)*Double.pi / 180.0)
        curLoc = CGPoint(x: newX, y: newY)
    }
    
    func contains(point: CGPoint) -> Bool {
        let bound = CGRect(x:hitBound.minX, y: hitBound.minY, width: hitBound.width+20, height: hitBound.height+20)
        let bezPath = UIBezierPath(rect: bound)
        return bezPath.contains(point)
    }
    func draw() {
        col.setFill()
        let bezPath = UIBezierPath(rect: self.hitBound)
        bezPath.fill()
    }
    
    
    func isAlive() -> Bool{
        return self.alive
    }
    
    
}



