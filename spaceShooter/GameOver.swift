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
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameOverLabel.textColor = UIColor.white
        scoreLabel.textColor = UIColor.white
        score.textColor = UIColor.white
        score.text = String(displayScore)
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    /// Navigates user to leaderboard screen
    @IBAction func leaderboard_button(_ sender: UIButton) {
        let leaderboardVC = storyboard!.instantiateViewController(withIdentifier: "LeaderboardViewController") as! LeaderboardViewController
        leaderboardVC.score = self.displayScore
        if counter > 0 {
            leaderboardVC.visited = true
        }
        counter += 1
        navigationController?.pushViewController(leaderboardVC, animated: true)
    }
    
    /// Returns user to home
    @IBAction func rth_button(_ sender: UIButton) {
        let launchVC = storyboard!.instantiateViewController(withIdentifier: "LaunchViewController") as! LaunchViewController
        navigationController?.pushViewController(launchVC, animated: true)
    }
}
