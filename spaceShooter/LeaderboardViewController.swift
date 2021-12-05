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

        //setName()
        fetchData()
    }
    
    func setName() {
        let randomNum = Int.random(in: 1001..<10000)
        let alert = UIAlertController(title: "Username for the leaderboard", message: nil, preferredStyle: .alert)
        alert.addTextField()
            
        alert.addAction(UIAlertAction(title: NSLocalizedString("Default name", comment: "cancel"), style: .default, handler: { [self, unowned alert] _ in
            self.username = "User \(randomNum)"
            data(name: username!, score: score)
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Confirm name", comment: "set name"), style: .default, handler: { [self, unowned alert] _ in
            let answer = alert.textFields![0]
            self.username = answer.text
            data(name: username ?? "User \(randomNum)", score: score)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func data(name: String, score: Int){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        //ref.child(name).child(Locale.current.regionCode ?? "").setValue(score) // value = score
        ref.child("Users").child(name).setValue(["score": score, "location": Locale.current.regionCode ?? ""])
    }
    
    func fetchData() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("Users").getData(completion:  { error, snapshot in
          guard error == nil else {
            print(error!.localizedDescription)
            return;
          }

        if let snap = snapshot.children.allObjects as? [DataSnapshot]{
            for (index, val) in snap.enumerated(){
                print("values")
                //print(val)
                print(val.key)
                print(val.value!)
                print(type(of: val.value!))
                //print(val.value)

            }
        }
          //let userName = snapshot.value as? String ?? "Unknown";
        });
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
