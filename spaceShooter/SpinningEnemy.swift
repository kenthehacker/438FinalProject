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
    var col = UIColor.clear
    var image: UIImage
    var speed = CGFloat(6)
    var alive = true
    var radius: Int = 50
    
    required init(location: CGPoint, size: Int) {
        self.curLoc = location
        self.size = size
        self.image = UIImage(named: "GalagaEnemy1")!
        self.hitBound = CGRect(x: location.x, y: location.y, width: CGFloat(size), height: CGFloat(size))
    }
    
//    init(location: CGPoint, size: Int, radius: Int){
//        self.curLoc = location
//        self.size = size
//        self.radius = radius
//    }
    
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
        let newX = Double(self.curLoc.x) + Double(self.radius)*cos(Double(speed)*Double.pi / 180.0)
        let newY = Double(self.curLoc.y) + Double(self.radius)*sin(Double(speed)*Double.pi / 180.0)
        curLoc = CGPoint(x: newX, y: newY)
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



