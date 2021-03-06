//
//  ShootingStar.swift
//  spaceShooter
//
//  Created by Kenichi Matsuo on 11/15/21.
//

import Foundation
import UIKit

/// Draws the shooting star background
class ShootingStar: MovableObject{
    
    let speed = 5
    var curLoc: CGPoint
    var width = 3
    var height = 15
    var star : CGRect
    var colFloat : CGFloat
    required init(location: CGPoint, size: Int) {
        let randY = CGFloat(Int.random(in: -800..<0))
        curLoc = CGPoint(x: CGFloat(Int.random(in: 0..<screenWidth)), y: randY)
        self.colFloat = CGFloat(Float.random(in: 0.1..<0.8))
        self.star = CGRect(x: curLoc.x, y: curLoc.y, width: CGFloat(width), height: CGFloat(height))
    }
    func isAlive() -> Bool {
        return true
    }
    func getX() -> CGFloat {
        return curLoc.x
    }
    
    func getY() -> CGFloat {
        return curLoc.y
    }
    
    /// Updates location of the stars
    func updateLocation(newLoc: CGPoint) {
        self.curLoc = CGPoint(x: self.curLoc.x,y: self.curLoc.y+CGFloat(speed))
        self.star = CGRect(x: curLoc.x, y: curLoc.y, width: CGFloat(width), height: CGFloat(height))
    }
    
    func contains(point: CGPoint) -> Bool {
        return true
    }
    
    /// Draws the stars using bezier paths
    func draw(){
        self.updateLocation(newLoc: curLoc)
        let colorWithAlpha = UIColor.white.withAlphaComponent(self.colFloat)
        colorWithAlpha.setFill()
        let bezPath = UIBezierPath(rect: self.star)
        bezPath.fill()
    }
    
    func getHealth() -> Int {
        // do nothing
        return 0
    }
    func getDMG(){
        // do nothing
    }
}
