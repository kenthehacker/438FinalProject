//
//  LeaderboardViewController.swift
//  spaceShooter
//
//  Created by Eric Tseng on 12/2/21.
//

import UIKit
import Firebase

class LeaderboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let textAtt = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAtt
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        
        data()
    }
    
    func data(){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("test").setValue(1)
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
