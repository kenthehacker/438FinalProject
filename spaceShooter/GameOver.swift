//
//  GameOver.swift
//  spaceShooter
//
//  Created by Eric Tseng on 12/4/21.
//

import UIKit

class GameOver: UIViewController {

    @IBOutlet weak var score: UILabel!
    var displayScore: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        score.text = String(displayScore)
        self.navigationItem.setHidesBackButton(true, animated: false)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func leaderboard_button(_ sender: UIButton) {
    }
    
    @IBAction func play_button(_ sender: UIButton) {
    }
    
    
    @IBAction func rth_button(_ sender: UIButton) {
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
