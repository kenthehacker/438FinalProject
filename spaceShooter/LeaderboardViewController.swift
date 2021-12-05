//
//  LeaderboardViewController.swift
//  spaceShooter
//
//  Created by Eric Tseng on 12/2/21.
//

import UIKit
import Firebase
import CoreLocation

class LeaderboardViewController: UIViewController {
    
    var score: Int = 0
    var username: String?
    // Get username, if nil then generate random user number
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let textAtt = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAtt
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        
        data()
        
        let locale = Locale.current
        print(locale.regionCode ?? "")
    }
    
    func data(){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("test").child(Locale.current.regionCode ?? "").setValue(1) // value = score
    }
    
    func fetchData() {
        
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
