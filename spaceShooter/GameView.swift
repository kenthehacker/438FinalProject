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
    var bossHealth = 100
    //following arrays contains all of the movable objects
    //we seperated some into different arrays because they have different methods that
    //cant necessarily be accessed all of the same time
    var upgrades: [UpgradeDrop] = []{
        didSet {
            setNeedsDisplay()
        }
    }
    var enemyMagazine: [EnemyBullet] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    var bossMagazine: [ShurikenBullet] = []{
        didSet {
            setNeedsDisplay()
        }
    }
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
    var scaledEnemies: [MovableObject] = [] {           //accomidates all of the different enemies
        didSet{
            setNeedsDisplay()
        }
    }
    
    
    
    //generates the shooting star formation
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
    //generates all of the enemy objects
    func drawEnemies() {
        var i = 0
        while i < enemies.count{
            if isAlive[i] {
                enemies[i].draw()
            }
            i = i+1
        }
        
        //all of the non-level 1 enemies can be drawn here -> 
        i = 0
        while i < scaledEnemies.count{
            scaledEnemies[i].draw()
            if !scaledEnemies[i].isAlive(){
                scaledEnemies.remove(at: i)
                i = i - 1
            }
            i = i + 1
        }
        
    }
    //checks if the enemy got killed or if its health is decreased
    func scaledCheckKillEnemy(loc: CGPoint) -> Int{
        var i = 0
        var counter = 0
        while i < scaledEnemies.count{
            if scaledEnemies[i].contains(point: loc){
                scaledEnemies[i].getDMG()
                if scaledEnemies[i].getHealth() <= 0{
                    scaledEnemies.remove(at: i)
                    i = i-1
                    counter += 1
                }
            }
            i += 1
        }
        return counter
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
        i = 0
        while i < enemyMagazine.count{
            enemyMagazine[i].draw()
            if enemyMagazine[i].getY() > 750{
                enemyMagazine.remove(at: i)
                i = i - 1
            }
            
            i = i+1
        }
        i = 0
        while i < upgrades.count{
            upgrades[i].draw()
            if upgrades[i].getY() > 750{
                upgrades.remove(at: i)
                i = i - 1
            }
            i = i+1
        }
        i = 0
        while i < bossMagazine.count{
            bossMagazine[i].draw()
            if bossMagazine[i].getY() > 750 || bossMagazine[i].getX() < -40 || bossMagazine[i].getY() < -10 || bossMagazine[i].getX() > 400{
                bossMagazine.remove(at: i)
                i = i - 1
            }
            
            i = i+1
        }
        self.mainCharacter.draw()
        drawStars()
        overlaySpaceShip()
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
    //creates sprite over spaceship
    func overlaySpaceShip() {
        if let image = UIImage(named: "SpaceShipGraphic") {
            let imageView = UIImageView(image: image)
            imageView.frame = self.mainCharacter.hitBound
            imageView.tag = 999
            if let viewWithTag = self.viewWithTag(999) {
                viewWithTag.removeFromSuperview()
            }
            self.addSubview(imageView)
        }
    }
    func clearScreen(){
        upgrades = []
        enemyMagazine = []
        items = []
        stars = []
        enemies = []
        
        for v in self.subviews{
            v.removeFromSuperview()
            //removes all of the subviews
        }
        setNeedsDisplay()
    }
}

