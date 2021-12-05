//
//  LaunchViewController.swift
//  spaceShooter
//
//  Created by Eric Tseng on 12/2/21.
//

import UIKit

/// Main or home screen view controller
class LaunchViewController: UIViewController {

    @IBOutlet weak var play_button: UIButton!
    @IBOutlet weak var leaderboard_button: UIButton!
    @IBOutlet var gameViews: GameView!
    
    var isNewInstance = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        play_button.tintColor = UIColor.white
        leaderboard_button.tintColor = UIColor.white
        self.navigationItem.setHidesBackButton(true, animated: false)
        
    }
}
