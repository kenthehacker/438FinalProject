//
//  ViewController.swift
//  spaceShooter
//
//  Created by Kenichi Matsuo on 11/15/21.
//

import UIKit
import AVFoundation

var pewpew: AVAudioPlayer?
var background_music: AVAudioPlayer?
var gameClock: CADisplayLink?
var screenWidth = 370
var screenHeight = 700
var tick = 0
class ViewController: UIViewController, UIGestureRecognizerDelegate {
    var currentLevel = 1
    let maxLevel = 3
    var playerIsAlive = true
    var beganTouchyTouchy = false
    var isPlaying = false
    var bulletTimer = 0
    var scaledEnemyBulletTimer = 0
    var enemyBulletTimer = 0
    var currentLocation:CGPoint?
    var score = 0
    
    var levelStepCounter = 0
    
    var fastMode = false
    @IBOutlet weak var gameView: GameView!
    //var gameView: GameView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //gameView = GameView(frame: canvas.frame)
        backgroundMusic()
        self.view.backgroundColor = UIColor.black
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        let textAtt = [NSAttributedString.Key.foregroundColor:UIColor.red, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24)]
        navigationController?.navigationBar.titleTextAttributes = textAtt
        self.navigationItem.title = "\(score)"
        
        gameClock = CADisplayLink(target: self, selector: #selector(update))
        gameClock?.add(to: .current, forMode: .common)
        
        let meap = CGPoint(x: 50, y: 700)
        let spaceShip = SpaceShip(location: meap, size: 30)


        gameView.mainCharacter = spaceShip
        
        //REMOVE THIS
        createEnemyFormation()
        
        //originally said start level1()
        // Do any additional setup after loading the view.
    }
    
    @objc func update(){
        //check if the main character is dead
        
        if gameView.mainCharacter.health<=0{
            playerIsAlive = false
        }
        if !playerIsAlive && currentLevel != 666{
            currentLevel = 666      //level 666 is our leader board page
            gameView.clearScreen()
            //we'll need to clear everything on the gameview!!
        }
        else if !playerIsAlive && currentLevel == 666{
            //TODO: put on the leaderboard screen
            gameView.clearScreen()
            gameClock?.remove(from: .current, forMode: .common)
            let gameOverVC = storyboard!.instantiateViewController(withIdentifier: "GameOver") as! GameOver
            gameOverVC.displayScore = score
            navigationController?.pushViewController(gameOverVC, animated: true)
        }
        else{
            if currentLevel == 1{
                level1()
            }
            else if currentLevel == 2{
                level2()
            }else if currentLevel == 3{
                level3()
            }
            
            
        }
    }
    
    //all of the levels ->
    
    func level1(){
        tick += 1
        bulletTimer += 1
        enemyBulletTimer += 1
        addBullet()
        shootBullets()
        didGetHit()
        //check if all of the enemy objects are gone
        var counter = 0
        for i in gameView.isAlive{
            if i == true{
                counter += 1
                
            }
        }
        //REMOVE THIS
        currentLevel = currentLevel+1
        if counter == 0{
            
            currentLevel = currentLevel+1
        }
        
        gameView.setNeedsDisplay()
        
    }
    func level2(){
        var level2Ticker = 0
        var numDiagsGenerated = 0
        tick += 1
        bulletTimer += 1
        enemyBulletTimer += 1
        addBullet()
        scaledShootBullets()
        scaledDidGetHit()   
        shootBullets()
        didGetHit()
        if levelStepCounter == 0{
            createEnemyFormation()
            levelStepCounter += 1
        }
        var counter = 0
        for i in gameView.isAlive{
            if i == true{
                counter += 1
            }
        }
        if counter == 0{
            levelStepCounter += 1
        }
        if levelStepCounter == 2{
            levelStepCounter += 1
            createDiagEnemy()
        }
        
        gameView.setNeedsDisplay()
        
    }
    func level3(){
        
    }
    func level666(){
        
    }
    func scaledShootBullets(){
        scaledEnemyBulletTimer = scaledEnemyBulletTimer+1
        if scaledEnemyBulletTimer > 40{
            scaledEnemyBulletTimer = 0
        }
        if scaledEnemyBulletTimer == 0{
            for i in gameView.scaledEnemies{
                let random = Int.random(in: 0..<100)
                if random > 0{
                    let loc = CGPoint(x: i.getX(), y: i.getY())
                    let bullet = EnemyBullet(location: loc, size: 20)
                    gameView.enemyMagazine.append(bullet)
                }
            }
        }
        
    }
    
    //<- all of the levels
    
    
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
        if fastMode{
            if bulletTimer > 10 && isPlaying{
                bulletTimer = 0
                let tempLocation = CGPoint(x: gameView.mainCharacter.getX() - 10, y: 690)
                let tempBullet = Bullet(location: tempLocation, size: 20)
                playSound()
                if fastMode{
                    tempBullet.newSpeed(n: 20)
                }
                gameView.items.append(tempBullet)
            }
        }else{
            if bulletTimer > 25 && isPlaying{
                bulletTimer = 0
                let tempLocation = CGPoint(x: gameView.mainCharacter.getX() - 10, y: 690)
                let tempBullet = Bullet(location: tempLocation, size: 20)
                playSound()
                gameView.items.append(tempBullet)
            }
        }
    }
    //revert the changes
    func createEnemyFormation() {
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
    //revert the changes
    func createDiagEnemy(){
        //counter == 0
        if true{
            let tempDiag = DiagEnemy(location: CGPoint(x: Int.random(in: 350..<700), y: 0), size: 20)
            
            gameView.scaledEnemies.append(tempDiag)
        }
        //if all of the enemies are dead drop in the swirly enemies
        
        //during and after the l1 enemies, drop in a diag enemy
        
        
    }
    // referenced https://stackoverflow.com/questions/32036146/how-to-play-a-sound-using-swift
    func playSound() {
        guard let url = Bundle.main.url(forResource: "shooting_sound", withExtension: "wav") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            pewpew = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)

            guard let bkz = pewpew else { return }

            bkz.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func backgroundMusic() {
        guard let url = Bundle.main.url(forResource: "spaceSong", withExtension: "wav") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            background_music = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)

            guard let player = background_music else { return }

            player.play()
            player.numberOfLoops = -1

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    func shootBullets() {
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
            gameView.enemyMagazine.append(enemy)
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
    
    func scaledDidGetHit(){
        for bullet in gameView.items{
            let temp = CGPoint(x: bullet.getX(), y: bullet.getY())
            gameView.scaledCheckKillEnemy(loc: temp)
        }
    }
    
    func didGetHit(){
        var enemyNumber = 0
        for enemy in gameView.enemies{
            var bulletNumber = 0
            for bullet in gameView.items{
                if enemy.contains(point: CGPoint(x: bullet.getX() + 10, y: bullet.getY())) && gameView.isAlive[enemyNumber]{
                    
                    if Int.random(in: 1..<100) >= 90{
                        gameView.upgrades.append(UpgradeDrop(location: CGPoint(x: bullet.getX() + 10, y: bullet.getY()), size: 10))
                    }
                    
                    gameView.isAlive[enemyNumber] = false
                    gameView.items.remove(at: bulletNumber)
                    score += 10
                    self.navigationItem.title = "\(score)"
                    return
                }
                bulletNumber += 1
            }
            enemyNumber += 1
        }
        
        for (index, enemyBullet) in gameView.enemyMagazine.enumerated(){
            if enemyBullet.contains(point: gameView.mainCharacter.getPoint()){
                let isAlive = gameView.mainCharacter.takeDamage(hp: enemyBullet.getDamage())
                gameView.enemyMagazine.remove(at: index)
                
                print("player hit, \(gameView.mainCharacter.health)")
                break
            }
        }
        
        for i in gameView.upgrades{
            if gameView.mainCharacter.contains(point: i.curLoc){
                
            //if i.contains(point: gameView.mainCharacter.getPoint()){
                print("FFFF")
                if i.upgrade == .healthBoost{
                    gameView.mainCharacter.healthBoost(n: 10)
                }
                else if i.upgrade == .fasterFire{
                    fastMode = true
                }
                else{
                    gameView.mainCharacter.healthBoost(n: 100)
                }
            }
        }
    }
    

}

