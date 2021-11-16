//
//  MovableObject.swift
//  spaceShooter
//
//  Created by Kenichi Matsuo on 11/15/21.
//

import Foundation
import UIKit

protocol MovableObject {
    init(location: CGPoint, size: Int)
    func getX() -> CGFloat
    func getY() -> CGFloat
    func updateLocation(newLoc: CGPoint)
    func contains(point: CGPoint) -> Bool
    func draw()
}
