//
//  GameView.swift
//  spaceShooter
//
//  Created by Kenichi Matsuo on 11/15/21.
//

import UIKit

final class GameView: UIView{
    var mainCharacter = SpaceShip(location: CGPoint(x: 4, y: 4), size: 0)
    var numEnemy = 0
    var isAlive: [Bool] = []
    
    var items: [MovableObject] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    var stars: [MovableObject] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    var enemies: [MovableObject] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    func drawSpace(){
        //self.mainCharacter.draw()
    }
    
    func drawStars(){
        var i = 0
        while stars.count < 50{
            stars.append(ShootingStar(location: CGPoint(x: 0, y: 0), size: 0))
        }
        while i < stars.count{
            stars[i].draw()
            if Int(stars[i].getY()) > screenHeight{
                stars.remove(at: i)
                i = i-1
            }
            i = i + 1
        }
    }
    func drawEnemies() {
        var i = 0
        while i < enemies.count{
            if isAlive[i] {
                enemies[i].draw()
            }
            i = i+1
        }
    }
    
    override func draw(_ rect: CGRect) {
        var i = 0
        while i < items.count{
            items[i].draw()
            if items[i].getY() > 750{
                items.remove(at: i)
                i = i - 1
            }
            
            i = i+1
        }
        self.mainCharacter.draw()
        drawStars()
        drawEnemies()
    }
    
    /// Returns the topmost item, if there is any, at a given point in the view.
    /// - Parameter location: The point within the view to look at.
    /// - Returns: The topmost (last added) item, or `nil` if there is none.
    func itemAtLocation(_ location: CGPoint) -> MovableObject? {
        return items.last { $0.contains(point: location) }
    }
    
    func enemyIsInFront(index: Int) {
        
    }
}

