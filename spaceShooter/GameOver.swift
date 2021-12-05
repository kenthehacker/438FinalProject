//
//  GameOver.swift
//  spaceShooter
//
//  Created by Eric Tseng on 12/4/21.
//

import UIKit

class GameOver: UIViewController {

    @IBOutlet weak var gameOverLabel: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var displayScore: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameOverLabel.textColor = UIColor.white
        scoreLabel.textColor = UIColor.white
        score.textColor = UIColor.white
        
        score.text = String(displayScore)
        self.navigationItem.setHidesBackButton(true, animated: false)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func leaderboard_button(_ sender: UIButton) {
        let leaderboardVC = storyboard!.instantiateViewController(withIdentifier: "LeaderboardViewController") as! LeaderboardViewController
        leaderboardVC.score = self.displayScore
        navigationController?.pushViewController(leaderboardVC, animated: true)
    }
    
    @IBAction func play_button(_ sender: UIButton) {
        let playVC = storyboard!.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        playVC.createEnemiesL1()
        playVC.backgroundMusic()
        playVC.gameView.mainCharacter.health = 200
        playVC.gameView.numEnemy = 0
        gameClock = CADisplayLink(target: self, selector: #selector(playVC.update))
        gameClock?.add(to: .current, forMode: .common)
        navigationController?.pushViewController(playVC, animated: true)
    }
    
    @IBAction func rth_button(_ sender: UIButton) {
        let launchVC = storyboard!.instantiateViewController(withIdentifier: "LaunchViewController") as! LaunchViewController
        navigationController?.pushViewController(launchVC, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
