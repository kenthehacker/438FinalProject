//
//  UpgradeDrop.swift
//  spaceShooter
//
//  Created by Kenichi Matsuo on 12/2/21.
//

import Foundation
import UIKit

class UpgradeDrop: MovableObject{
    var curLoc: CGPoint
    var size: Int
    var hitBound: CGRect
    var col = UIColor.clear
    var image: UIImage
    let speed = CGFloat(5)
    
    
    enum upgradeType: CaseIterable {
        case healthBoost
        case fasterFire
        case superHealthBoost
    }
    var upgrade: upgradeType
    
    required init(location: CGPoint, size: Int) {
        self.size = size
        self.curLoc = location
        self.image = UIImage(named: "Upgrade")!
        let cgSize = CGFloat(self.size)
        self.hitBound = CGRect(x: location.x, y: location.y, width: cgSize, height: cgSize)
        self.upgrade = upgradeType.allCases.randomElement() ?? upgradeType.fasterFire   //picks a random enum case
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
    
    func updateLocation(newLoc: CGPoint) {
        curLoc = CGPoint(x: self.curLoc.x,y: self.curLoc.y+speed)
        self.hitBound = CGRect(x: curLoc.x, y: curLoc.y, width: CGFloat(size), height: CGFloat(size))
    }
    
    func contains(point: CGPoint) -> Bool {
        let tempBound = CGRect(x:hitBound.minX-10, y: hitBound.minY-10, width: hitBound.width+20, height: hitBound.height+20)
        let bezPath = UIBezierPath(rect: tempBound)
        return bezPath.contains(point)
    }
    
    func draw() {
        self.updateLocation(newLoc: curLoc)
        self.image.draw(in: hitBound)
    }
    func getHealth() -> Int {
        return 0
    }
    func getDMG(){
        
    }
    
}

