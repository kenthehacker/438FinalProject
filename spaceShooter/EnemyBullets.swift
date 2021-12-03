//
//  EnemyBullets.swift
//  spaceShooter
//
//  Created by Kenichi Matsuo on 11/16/21.
//

import Foundation

import UIKit

class EnemyBullet: MovableObject{
    var curLoc: CGPoint
    var size: Int
    var hitBound: CGRect
    var col = UIColor.white
    let speed = CGFloat(10)
    var healthDamage = 5
    required init(location: CGPoint, size: Int){
        self.size = size
        self.curLoc = location
        let cgSize = CGFloat(self.size)
        self.hitBound = CGRect(x: location.x, y: location.y, width: cgSize, height: cgSize)
    }
    func setNewDamage(n: Int){
        self.healthDamage = n
    }
    func getX() -> CGFloat{
        return curLoc.x
    }
    func getY() -> CGFloat{
        return curLoc.y
    }
    func updateLocation(newLoc: CGPoint){
        curLoc = CGPoint(x: self.curLoc.x,y: self.curLoc.y+speed)
        self.hitBound = CGRect(x: curLoc.x, y: curLoc.y, width: CGFloat(size), height: CGFloat(size))
    }
    func contains(point: CGPoint) -> Bool{
        return true
    }
    func draw(){
        col.setFill()
        self.updateLocation(newLoc: self.curLoc)
        let bezPath = UIBezierPath(rect: self.hitBound)
        bezPath.fill()
        //GameView.items.append(EnemyBullet(location: curLoc, size: 20))
        
    }
}
