//
//  ZigZagEnemy.swift
//  spaceShooter
//
//  Created by Kenichi Matsuo on 12/4/21.
//

import Foundation
import UIKit
class ZigZagEnemy: MovableObject{
    
    var alive = true
    required init(location: CGPoint, size: Int) {
        <#code#>
    }
    
    func getX() -> CGFloat {
        <#code#>
    }
    
    func getY() -> CGFloat {
        <#code#>
    }
    
    func updateLocation(newLoc: CGPoint) {
        <#code#>
    }
    
    func contains(point: CGPoint) -> Bool {
        <#code#>
    }
    
    func draw() {
        <#code#>
    }
    
    func isAlive() -> Bool {
        return self.alive
    }
    
    
    
}


