//
//  GameView.swift
//  spaceShooter
//
//  Created by Kenichi Matsuo on 11/15/21.
//

import UIKit

final class GameView: UIView{
    var items: [MovableObject] = [] {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        
        for item in items {
            item.draw()
        }
    }
    
    /// Returns the topmost item, if there is any, at a given point in the view.
    /// - Parameter location: The point within the view to look at.
    /// - Returns: The topmost (last added) item, or `nil` if there is none.
    func itemAtLocation(_ location: CGPoint) -> MovableObject? {
        return items.last { $0.contains(point: location) }
    }
}

