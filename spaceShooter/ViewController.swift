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
class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var tick = 0
    var isPlaying = false
    var bulletTimer = 0
    var currentLocation:CGPoint?
    @IBOutlet weak var gameView: GameView!
    //var gameView: GameView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //gameView = GameView(frame: canvas.frame)
        
        gameClock = CADisplayLink(target: self, selector: #selector(update))
        gameClock?.add(to: .current, forMode: .common)
        
        let meap = CGPoint(x: 50, y: 700)
        let spaceShit = SpaceShip(location: meap, size: 25)
        
        //gameView.items.append(spaceShit)
        gameView.mainCharacter = spaceShit
        // Do any additional setup after loading the view.
    }
    
    @objc func update(){
        print("tick \(tick)")
        tick += 1
        bulletTimer += 1
        if bulletTimer > 25 && isPlaying{
            bulletTimer = 0
            if isPlaying{
                addBullet()
                print("shot a bullet")
            }
            
        }
        
        gameView.setNeedsDisplay()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = (touches.first)!.location(in: gameView) as CGPoint
        currentLocation = touchPoint
        if gameView.mainCharacter.contains(point: touchPoint){
            gameView.mainCharacter.updateLocation(newLoc: touchPoint)
        }
        
        
        isPlaying = true
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = (touches.first)!.location(in: gameView) as CGPoint
        currentLocation = touchPoint
        if gameView.mainCharacter.contains(point: touchPoint){
            gameView.mainCharacter.updateLocation(newLoc: touchPoint)
        }
        
    
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isPlaying = false
    }
    
    func addBullet(){
        print("making bullet")
        let tempLocation = CGPoint(x: currentLocation!.x, y: 690)
        let tempBullet = Bullet(location: tempLocation, size: 20)
        gameView.items.append(tempBullet)
        
    }
    

}

