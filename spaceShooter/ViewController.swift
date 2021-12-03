//
//  ViewController.swift
//  spaceShooter
//
//  Created by Kenichi Matsuo on 11/15/21.
//

import UIKit

var gameClock: CADisplayLink?
var screenWidth = 370
var screenHeight = 700
var tick = 0
class ViewController: UIViewController, UIGestureRecognizerDelegate {
    var currentLevel = 1
    var beganTouchyTouchy = false
    var isPlaying = false
    var bulletTimer = 0
    var enemyBulletTimer = 0
    var currentLocation:CGPoint?
    @IBOutlet weak var gameView: GameView!
    //var gameView: GameView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //gameView = GameView(frame: canvas.frame)
        self.view.backgroundColor = UIColor.black
        gameClock = CADisplayLink(target: self, selector: #selector(update))
        gameClock?.add(to: .current, forMode: .common)
        
        let meap = CGPoint(x: 50, y: 700)
        let spaceShit = SpaceShip(location: meap, size: 30)
        
        //gameView.items.append(spaceShit)
        gameView.mainCharacter = spaceShit
        startLevel1()
        // Do any additional setup after loading the view.
    }
    
    @objc func update(){
        //print("tick \(tick)")
        tick += 1
        bulletTimer += 1
        enemyBulletTimer += 1
        
        addBullet()
        shootBulletsLevelOne()
        didGetHit()
        
        gameView.setNeedsDisplay()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = (touches.first)!.location(in: gameView) as CGPoint
        currentLocation = touchPoint
        if gameView.mainCharacter.contains(point: touchPoint){
            gameView.mainCharacter.updateLocation(newLoc: touchPoint)
            beganTouchyTouchy = true
        }
        
        isPlaying = true
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = (touches.first)!.location(in: gameView) as CGPoint
        currentLocation = touchPoint
        if beganTouchyTouchy{
            gameView.mainCharacter.updateLocation(newLoc: touchPoint)
        }
        
    
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isPlaying = false
        beganTouchyTouchy = false
    }
    
    func addBullet(){
        if bulletTimer > 25 && isPlaying{
            bulletTimer = 0
            let tempLocation = CGPoint(x: gameView.mainCharacter.getX() - 10, y: 690)
            let tempBullet = Bullet(location: tempLocation, size: 20)
            gameView.items.append(tempBullet)
        }
    }
    
    func startLevel1() {
        createEnemiesLevelOne()
    }
    
    func createEnemiesLevelOne() {
        let x_loc = [55, 110, 165, 225, 280]
        let y_loc = [-20, -60, -100]
        for j in 0..<3 {
            for i in 0..<5 {
                
                gameView.numEnemy = gameView.numEnemy + 1
                let location = CGPoint(x: x_loc[i], y: y_loc[j])
                let enemy = L1Enemy(location: location, size: 20)
                gameView.enemies.append(enemy)
            }
        }
        let isAlive: [Bool] = [Bool](repeating: true, count: gameView.numEnemy)
        gameView.isAlive = isAlive
    }
    
    func shootBulletsLevelOne() {
        if enemyBulletTimer > 40{
            enemyBulletTimer = 0
        }
        if enemyBulletTimer == 0{
            //let locations = [55, 110, 165, 225, 280]
            let random = Int.random(in: 0..<5)

            var shootingEnemy = random
            
            switch random {
            case 0:
                if !gameView.isAlive[10] {
                    return
                }
                shootingEnemy = getEnemyShooting(index: 0)
            case 1:
                if !gameView.isAlive[11] {
                    return
                }
                shootingEnemy = getEnemyShooting(index: 1)
            case 2:
                if !gameView.isAlive[12] {
                    return
                }
                shootingEnemy = getEnemyShooting(index: 2)
            case 3:
                if !gameView.isAlive[13] {
                    return
                }
                shootingEnemy = getEnemyShooting(index: 3)
            case 4:
                if !gameView.isAlive[14] {
                    return
                }
                shootingEnemy = getEnemyShooting(index: 4)
            default:
                return
            }
            let location = CGPoint(x: (Int)(gameView.enemies[shootingEnemy].getX()), y: (Int)(gameView.enemies[shootingEnemy].getY()) + 40)
            let enemy = EnemyBullet(location: location, size: 20)
            gameView.items.append(enemy)
        }
    }
    
    func getEnemyShooting(index:Int) -> Int {
        var shootingEnemy = 0
        if !gameView.isAlive[index]{
            if gameView.isAlive[index + 5]{
                shootingEnemy = index + 5
            } else if gameView.isAlive[index + 10] {
                shootingEnemy = index + 10
            }
        } else {
            shootingEnemy = index
        }
        
        return shootingEnemy
    }
    
    func didGetHit(){
        var enemyNumber = 0
        for enemy in gameView.enemies{
            var bulletNumber = 0
            for bullet in gameView.items{
                if enemy.contains(point: CGPoint(x: bullet.getX() + 10, y: bullet.getY())) && gameView.isAlive[enemyNumber]{
                    gameView.isAlive[enemyNumber] = false
                    gameView.items.remove(at: bulletNumber)
                    return
                }
                bulletNumber += 1
            }
            enemyNumber += 1
        }
        
    }
    

}

