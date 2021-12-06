//
//  ViewController.swift
//  spaceShooter
//
//  Created by Kenichi Matsuo on 11/15/21.
//

import UIKit
import AVFoundation

//following are global variables that needs to be accessed by other files and classes
var pewpew: AVAudioPlayer?
var background_music: AVAudioPlayer?
var gameClock: CADisplayLink?
var screenWidth = 370 //theoretical height and width of the screen
var screenHeight = 700
var tick = 0 //tick controls how often bullets are being fired
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
    
    //Level Specific Variables:
    //all of the following specific variables are constantly being updated
    var localLevelTicker = 0
    var toggleShuriken = false
    var numDiagsGenerated = 0
    var numEnemiesGenerated = 0
    var numFormations = 0
    
    var enemySequence = [[Int]]()
    var pauseSpawn = false
    var updatingLevel = true
    var isFightingBoss = false
    
    
    var fastMode = false
    @IBOutlet weak var gameView: GameView!
    //var gameView: GameView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //gameView = GameView(frame: canvas.frame)
        backgroundMusic()
        self.view.backgroundColor = UIColor.black   //sets black for the black background for the shooting star
                                                    // moving background
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        let textAtt = [NSAttributedString.Key.foregroundColor:UIColor.red, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24)]
        navigationController?.navigationBar.titleTextAttributes = textAtt
        self.navigationItem.title = "\(score)"
        
        gameClock = CADisplayLink(target: self, selector: #selector(update))
                                                    //allows for the ticker to increment up
                                                    //logic is used to display how quickly our Level1 and Boss enemy descends
        gameClock?.add(to: .current, forMode: .common)
        
        let tempLocationOfShip = CGPoint(x: 50, y: 700)     //initialises our ship and its location
        let spaceShip = SpaceShip(location: tempLocationOfShip, size: 30)

        let imageName = "SpaceShipGraphic"
        let image = UIImage(named: imageName)
        let life1 = UIImageView(image: image!)

        life1.frame = CGRect(x: 320, y: 750, width: 15, height: 15)
        life1.tag = 33
        gameView.addSubview(life1)

        let imageName2 = "SpaceShipGraphic"
        let image2 = UIImage(named: imageName2)
        let life2 = UIImageView(image: image2!)

        life2.frame = CGRect(x: 340, y: 750, width: 15, height: 15)
        life2.tag = 66
        gameView.addSubview(life2)

        gameView.setNeedsDisplay()
        gameView.mainCharacter = spaceShip

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
            gameView.clearScreen()                          //checks if the game is still playing otherwise go into
                                                            //leaderboard
            gameClock?.remove(from: .current, forMode: .common)
            let gameOverVC = storyboard!.instantiateViewController(withIdentifier: "GameOver") as! GameOver
            gameOverVC.displayScore = score
            navigationController?.pushViewController(gameOverVC, animated: true)
        }
        else{
            if currentLevel == 1{   //runs if the game is over
                fastMode = false
                if updatingLevel{
                    updatingLevel = false
                    var seq = [Int]()
                    seq.append(0)   //for level1 we add the 0-type enemy into the subarray
                    numEnemiesGenerated = 15
                    enemySequence.append(seq)   //then we append that subarray into our enemy sequence
                    
                    //how the game enemies are loaded:
                    /*
                     it is a 2 dimensional LinkedList; each inner array is a 'sub-wave' of enemies
                     each enemies inside of a subwave is generated concurrently
                     the enemies in different subwaves are not
                     the entire linkedlist is considered to be a single wave or level
                     
                     with increasing levels the difficulty will rise
                     */
                    
                }
                infLevel()
            }
            else if currentLevel <= 2 {
                if updatingLevel{
                    numEnemiesGenerated = 0
                    enemySequence = []  //clears enemy sequence and other necessary variables
                    localLevelTicker = 0
                    updatingLevel = false
                    fastMode = false    //fast shoot powerup off
                    let n = currentLevel+3
                    for _ in 1...n{ //n
                        var seq = [Int]()
                        let enemyNumber = 3+currentLevel-2
                        for _ in 1...enemyNumber{       //controls numbr of enemies based on diffuclty
                            let random = Int.random(in: 1..<100)
                            if random > 50{
                                var zz = Int.random(in: 0..<4)
                                if zz == 0 && seq.contains(0){      //we only want one instance of the 0-type enemy
                                    zz = 1
                                }
                                seq.append(zz)
                                if zz == 0{
                                    numEnemiesGenerated = numEnemiesGenerated + 15  //keeps track of number of
                                                                                    //enemies we have left to kill
                                }else{
                                    numEnemiesGenerated = numEnemiesGenerated + 1
                                }
                            }
                        }
                        if seq.count == 0{                                  //if we didnt add enemy we brute force
                                                                            //add a random one
                            let tempVar = Int.random(in: 0..<3)
                            seq.append(tempVar)
                            if tempVar == 0{
                                numEnemiesGenerated = numEnemiesGenerated + 15
                            }else{
                                numEnemiesGenerated = numEnemiesGenerated + 1
                            }
                        }
                        enemySequence.append(seq)
                    }
                    print("level "+String(currentLevel))
                    print(enemySequence)
                    
                    
                }
                infLevel()
            }
            else{                           //while it looks like a replica of the above, the difference is
                                            //we can add the boss baby class, and different bullet types
                if updatingLevel{
                    enemySequence = []
                    localLevelTicker = 0
                    updatingLevel = false
                    fastMode = false
                    numEnemiesGenerated = 0
                    let n = currentLevel+3
                    for _ in 1...n{
                        var seq = [Int]()
                        let enemyNumber = 3+currentLevel-2
                        for _ in 1...enemyNumber{
                            let random = Int.random(in: 1..<100)
                            if random > 50{
                                var zz = Int.random(in: 0..<4)
                                if zz == 0 && seq.contains(0){
                                    zz = 1
                                }
                                seq.append(zz)
                                if zz == 0{
                                    numEnemiesGenerated = numEnemiesGenerated + 15
                                }else{
                                    numEnemiesGenerated = numEnemiesGenerated + 1
                                }
                            }
                        }
                        if seq.count == 0{
                            let tempVar = Int.random(in: 0..<3)
                            seq.append(tempVar)
                            if tempVar == 0{
                                numEnemiesGenerated = numEnemiesGenerated + 15
                            }else{
                                numEnemiesGenerated = numEnemiesGenerated + 1
                            }
                        }
                        enemySequence.append(seq)
                    }
                    let bossSeq = [4]
                    enemySequence.append(bossSeq)
                    
                    numEnemiesGenerated += 1
                    
                }
                if numEnemiesGenerated == 0{
                    gameView.mainCharacter.takeDamage(hp: 10000)
                }
                infLevel()
            }
            
            
        }
    }
    
    //all of the levels ->
    func infLevel(){                //the beauty of this method is that we can have infinite levels and we do
                                    //the parametres of what enemies to have is based off of the difficulty
        tick += 1
        bulletTimer += 1
        enemyBulletTimer += 1
        addBullet()
        scaledShootBullets()
        scaledDidGetHit()
        shootBullets()
        if (toggleShuriken){
            shurikenBullet()
        }
        didGetHit()
        
        if !pauseSpawn{
            if localLevelTicker < enemySequence.count{
                
                let j = enemySequence[localLevelTicker]
                for i in j{                     //we know what enemy to generated from our sequence
                    if i == 0{
                        createEnemyFormation()
                    }
                    if i == 1{
                        createDiagEnemy()
                    }
                    if i == 2{
                        createZigZagEnemy()
                        
                    }
                    if i == 3{
                        //spin Enemy
                        createSpinEnemy()
                        
                    }
                    if i == 4{
                        isFightingBoss = true
                        createBossBaby()
                        toggleShuriken = true
                        //boss baby
                    }
                }
            }else{
                numEnemiesGenerated = 0
                toggleShuriken = false
            }
            pauseSpawn = true
        }else{
            if gameView.scaledEnemies.count == 0{
                var tempCount = 0
                for i in gameView.isAlive{
                    if i == true{
                        tempCount += 1
                    }
                }
                if tempCount == 0 {
                    pauseSpawn = false
                    localLevelTicker += 1
                    
                }
                
            }
        }
        
        if numEnemiesGenerated == 0{
            
            currentLevel += 1
            updatingLevel = true
        }
        
        gameView.setNeedsDisplay()
    }

    func scaledShootBullets(){                              //generates bullets from the scalable enemies
        scaledEnemyBulletTimer = scaledEnemyBulletTimer+1
        if scaledEnemyBulletTimer > 40{
            scaledEnemyBulletTimer = 0
        }
        if scaledEnemyBulletTimer == 0{
            for i in gameView.scaledEnemies{
                let random = Int.random(in: 0..<100)
                if random > 50{
                    let loc = CGPoint(x: i.getX(), y: i.getY())
                    let bullet = EnemyBullet(location: loc, size: 40)
                    gameView.enemyMagazine.append(bullet)
                }
            }
        }
        
    }
    func shurikenBullet(){                              //shoots bullets in a shuriken formation
        scaledEnemyBulletTimer = scaledEnemyBulletTimer+1
        if scaledEnemyBulletTimer > 30{
            scaledEnemyBulletTimer = 0
        }
        if scaledEnemyBulletTimer == 0{
            for i in gameView.scaledEnemies{
                let random = Int.random(in: 0..<100)
                if random > 76{
                    let loc = CGPoint(x: i.getX()+CGFloat(43), y: i.getY()+CGFloat(17))
                    var theta = 0.0
                    while theta < Double.pi * 2{        //we go around in a circle and generate bullets
                        theta = Double.pi/7 + theta
                        let speedX = 5.0*cos(theta)
                        let speedY = 5.0*sin(theta)
                        let bullet = ShurikenBullet(location: loc, size: 15)
                        bullet.setSpeedX(n: CGFloat(speedX))
                        bullet.setSpeedY(n: CGFloat(speedY))
                        gameView.bossMagazine.append(bullet)
                    }
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
    
    func addBullet(){                       //adds bullet in front of the sprite that we are talking about
        if fastMode{
            if bulletTimer > 10 && isPlaying{   //adds bullet based on time
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
    //following enemy creation methods generates a single enemy other than the enemy formation which creates
    // an nxm matrix of enemies
    func createEnemyFormation() {
        tick = 0
        gameView.enemies = []
        gameView.numEnemy = 0
        let x_loc = [55, 110, 165, 225, 280]
        let y_loc = [-20, -60, -100]
        for j in 0..<3 {
            for i in 0..<5 {
                gameView.numEnemy = gameView.numEnemy + 1
                let location = CGPoint(x: x_loc[i], y: y_loc[j])
                let enemy = L1Enemy(location: location, size: 30)
                gameView.enemies.append(enemy)
            }
        }
        let isAlive: [Bool] = [Bool](repeating: true, count: gameView.numEnemy)
        gameView.isAlive = isAlive
    }
    //revert the changes
    func createDiagEnemy(){
        let tempDiag = DiagEnemy(location: CGPoint(x: Int.random(in: 350..<700), y: 0), size: 45)
        gameView.scaledEnemies.append(tempDiag)
    }
    func createZigZagEnemy(){
        let randY = Int.random(in: 0..<200)
        let spawnPoint = CGPoint(x: 0, y: randY)
        let tempZigZag = ZigZagEnemy(location: spawnPoint, size: 45)
        gameView.scaledEnemies.append(tempZigZag)
    }
    func createSpinEnemy(){
        let randX = Int.random(in: 20..<screenWidth-30)
        let spawnPoint = CGPoint(x: randX, y: 60)
        let tempSpinEnemy = SpinningEnemy(location: spawnPoint, size: 45)
        gameView.scaledEnemies.append(tempSpinEnemy)
    }
    func createBossBaby(){
        let spawnPoint =  CGPoint(x: screenWidth/2, y: 10)
        let tempBossBaby = BossBaby(location: spawnPoint, size: 100)
        gameView.scaledEnemies.append(tempBossBaby)
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
    
    //shoots bullets for enemies in formation
    func shootBullets() {
        if gameView.isAlive.count > 0{
            if enemyBulletTimer > 40{
                enemyBulletTimer = 0
            }
            if enemyBulletTimer == 0{
                //let locations = [55, 110, 165, 225, 280]
                let random = Int.random(in: 0..<5)

                var shootingEnemy = random
                
                switch random {     //the following is specific for the enemy formation
                                    //it picks a random enemy to fire from
                                    //we dont want the bullets to be fired from the rear enemies in the formation
                                    //so we pick one from the front rows
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
                let enemy = EnemyBullet(location: location, size: 40)
                gameView.enemyMagazine.append(enemy)
                
            }
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
    //for the rest of the enemies we check if our enemy got hit
    func scaledDidGetHit(){
        for bullet in gameView.items{
            let temp = CGPoint(x: bullet.getX(), y: bullet.getY())
            let t = gameView.scaledCheckKillEnemy(loc: temp)    //important method to taking out health values from boss enemy
            numEnemiesGenerated -= t
            
        }
    }
    //following method checks if our enemies got hit by our bullet for the l1 enemy class
    func didGetHit(){
        var enemyNumber = 0
        for enemy in gameView.enemies{
            var bulletNumber = 0
            for bullet in gameView.items{
                if enemy.contains(point: CGPoint(x: bullet.getX() + 10, y: bullet.getY())) && gameView.isAlive[enemyNumber]{
                    
                    if Int.random(in: 1..<100) >= 90{
                        gameView.upgrades.append(UpgradeDrop(location: CGPoint(x: bullet.getX() + 10, y: bullet.getY()), size: 30))
                    }
                    
                    numEnemiesGenerated -= 1
                    
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
        //determiens how our main character gets damaged
        //also important to taking out the health image icons from bottom right corner of the screen
        for (index, enemyBullet) in gameView.enemyMagazine.enumerated(){
            if enemyBullet.contains(point: gameView.mainCharacter.getPoint()){
                let isAlive = gameView.mainCharacter.takeDamage(hp: enemyBullet.getDamage())
                gameView.enemyMagazine.remove(at: index)
                
                if let viewWithTag = gameView.viewWithTag(33) {
                        viewWithTag.removeFromSuperview()
                        gameView.setNeedsDisplay()
                    }

                else if let viewWithTag = gameView.viewWithTag(66) {
                    viewWithTag.removeFromSuperview()
                    gameView.setNeedsDisplay()

                }
                break
            }
        }
        
        for (index, bb) in gameView.bossMagazine.enumerated(){
            if bb.contains(point: gameView.mainCharacter.getPoint()){
                let isAlive = gameView.mainCharacter.takeDamage(hp: 10)
                gameView.bossMagazine.remove(at: index)
                
                if let viewWithTag = gameView.viewWithTag(33) {
                        viewWithTag.removeFromSuperview()
                        gameView.setNeedsDisplay()
                    }

                else if let viewWithTag = gameView.viewWithTag(66) {
                    viewWithTag.removeFromSuperview()
                    gameView.setNeedsDisplay()

                }
                break
            }
            
        }
        //following helps us gets us the png health indicator on the bottom right corner of the screen
        //to rise in value when we collect the powerups
        for i in gameView.upgrades{
            if gameView.mainCharacter.contains(point: i.curLoc){
                if i.upgrade == .healthBoost{
                    if let viewWithTag = gameView.viewWithTag(33), let viewWithTag2 = gameView.viewWithTag(66){
                        }
                    else if let viewWithTag = gameView.viewWithTag(66) {
                        gameView.mainCharacter.healthBoost(n: 10)
                        let imageName = "SpaceShipGraphic"
                        let image = UIImage(named: imageName)
                        let life1 = UIImageView(image: image!)

                        life1.frame = CGRect(x: 320, y: 750, width: 15, height: 15)
                        life1.tag = 33
                        gameView.addSubview(life1)
                    }
                    else {
                        gameView.mainCharacter.healthBoost(n: 10)
                        let imageName2 = "SpaceShipGraphic"
                        let image2 = UIImage(named: imageName2)
                        let life2 = UIImageView(image: image2!)

                        life2.frame = CGRect(x: 340, y: 750, width: 15, height: 15)
                        life2.tag = 66
                        gameView.addSubview(life2)
                    }
                    
                }
                else if i.upgrade == .fasterFire{
                    fastMode = true
                }
            }
        }
    }
    

}


