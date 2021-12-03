//
//  LaunchViewController.swift
//  spaceShooter
//
//  Created by Eric Tseng on 12/2/21.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var play_button: UIButton!
    @IBOutlet weak var leaderboard_button: UIButton!
    @IBOutlet var gameViews: GameView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        play_button.tintColor = UIColor.white
        leaderboard_button.tintColor = UIColor.white
        
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
