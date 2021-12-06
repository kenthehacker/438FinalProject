//
//  MovableObject.swift
//  spaceShooter
//
//  Created by Kenichi Matsuo on 11/15/21.
//

import Foundation
import UIKit

protocol MovableObject {
    //defines methods for movable object protocol
    //everything that moves is an extension of this protocol
    init(location: CGPoint, size: Int)
    func getX() -> CGFloat
    func getY() -> CGFloat
    func updateLocation(newLoc: CGPoint)
    func contains(point: CGPoint) -> Bool
    func draw()
    func isAlive() -> Bool
    func getHealth() -> Int
    func getDMG()
}
