//
//  LeaderboardViewController.swift
//  spaceShooter
//
//  Created by Eric Tseng on 12/2/21.
//

import UIKit
import Firebase
import CoreLocation

class LeaderboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var score: Int = 0
    var username: String?
    var leaderboardArr: [LeaderboardObjects] = []
    
    @IBOutlet weak var leaderTable: UITableView!
    
    // Get username, if nil then generate random user number

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let textAtt = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAtt
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        
        setupTableView()
    }
    
    func setName() {
        let randomNum = Int.random(in: 1001..<10000)
        let alert = UIAlertController(title: "Username for the leaderboard", message: nil, preferredStyle: .alert)
        alert.addTextField()
            
        alert.addAction(UIAlertAction(title: NSLocalizedString("Default name", comment: "cancel"), style: .default, handler: { [self] _ in
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
        ref.child("Users").child(name).setValue(["score": score, "location": Locale.current.regionCode ?? ""])
        fetchData()
    }
    
    func fetchData() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("Users").getData(completion: { [self] error, snapshot in
          guard error == nil else {
            print(error!.localizedDescription)
            return;
          }

            if let snap = snapshot.children.allObjects as? [DataSnapshot]{
                for values in snap{
                    let loc = values.children.allObjects.first as! DataSnapshot
                    let score = values.children.allObjects.last as! DataSnapshot
                    leaderboardArr.append(LeaderboardObjects(username: values.key, score: score.value! as! Int, region: loc.value! as! String))
                }
            }
            leaderTable.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if score > 0 {
            setName()
        }
        fetchData()
    }
    
    /// Initializes table view
    func setupTableView() {
        leaderTable.dataSource = self
        leaderTable.delegate = self
        leaderTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderboardArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = leaderTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.prefersSideBySideTextAndSecondaryText = true
        content.text = "\(leaderboardArr[indexPath.row].username) (\(leaderboardArr[indexPath.row].region))"
        content.textProperties.color = UIColor.white
        content.secondaryText = "Score: \(leaderboardArr[indexPath.row].score)"
        content.secondaryTextProperties.color = UIColor.white
        
        //content.attributedText = NSAttributedString(string: "\(userArray[indexPath.row]) (\(regionArray[indexPath.row]))")
        
        //cell.textLabel!.numberOfLines = 0
        //cell.textLabel!.text = ("\(userArray[indexPath.row])\nRegion: \(regionArray[indexPath.row])")
        cell.contentConfiguration = content
        cell.backgroundColor = UIColor.black
        return cell
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
