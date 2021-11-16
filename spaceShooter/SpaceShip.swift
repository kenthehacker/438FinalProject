//
//  SpaceShip.swift
//  spaceShooter
//
//  Created by Kenichi Matsuo on 11/15/21.
//

import Foundation
import UIKit
class SpaceShip{
    var curLoc: CGPoint
    var health: Int
    var size: Int
    let hitBound: CGRect
    var col = UIColor.red
    init(location: CGPoint, size:Int){
        col.setFill()
        self.health = 100
        self.curLoc = location
        self.size = size
        let cgSize = CGFloat(self.size)
        self.hitBound = CGRect(x: location.x, y: location.y, width: cgSize, height: cgSize)
        
    }
    func getX() -> CGFloat{
        return self.curLoc.x
    }
    func getY() -> CGFloat{
        return self.curLoc.y
    }
    func updateLocation(newLoc: CGPoint){
        self.curLoc = newLoc
    }
    func contains(point: CGPoint) -> Bool{
        return true
    }
    func draw(){
        //UIColor.red.setFill()
        
        let bezPath = UIBezierPath(rect: self.hitBound)
        
        //bezPath.stroke()
        //bezPath.fill()
    }
}
