//
//  GameView.swift
//  spaceShooter
//
//  Created by Kenichi Matsuo on 11/15/21.
//

import UIKit

final class GameView: UIView{
    var mainCharacter = SpaceShip(location: CGPoint(x: 4, y: 4), size: 0)
    
    var items: [MovableObject] = [] {
        didSet {
            setNeedsDisplay()
        }
    }

    func drawSpace(){
        //self.mainCharacter.draw()
    }
    
    
    override func draw(_ rect: CGRect) {
        var i = 0
        while i < items.count{
            items[i].draw()
            if items[i].getY()<0{
                items.remove(at: i)
                i = i - 1
            }
            i = i+1
        }
        self.mainCharacter.draw()
        
    }
    
    /// Returns the topmost item, if there is any, at a given point in the view.
    /// - Parameter location: The point within the view to look at.
    /// - Returns: The topmost (last added) item, or `nil` if there is none.
    func itemAtLocation(_ location: CGPoint) -> MovableObject? {
        return items.last { $0.contains(point: location) }
    }
}

