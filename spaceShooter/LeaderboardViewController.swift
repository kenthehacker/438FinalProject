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
    var visited: Bool = false
    
    @IBOutlet weak var leaderTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let textAtt = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAtt
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        setupTableView()
    }
    
    /// Alert popup for user to enter username, or default to random username
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
    
    /// Sends name, score, region to Firebase database
    func data(name: String, score: Int){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("Users").child(name).setValue(["score": score, "location": Locale.current.regionCode ?? ""])
        leaderboardArr.removeAll()
        leaderTable.reloadData()
        fetchData()
    }
    
    /// Gets data from Firebase
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
            leaderboardArr.sort {
                $0.score > $1.score
            }
            leaderTable.reloadData()
        })
    }
    
    /// Loads table when view about to appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if score > 0 && visited == false{
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
    
    /// Formats table and cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = leaderTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.prefersSideBySideTextAndSecondaryText = true
        content.text = "\(leaderboardArr[indexPath.row].username) (\(leaderboardArr[indexPath.row].region))"
        content.textProperties.color = UIColor.white
        content.secondaryText = "Score: \(leaderboardArr[indexPath.row].score)"
        content.secondaryTextProperties.color = UIColor.white
        cell.contentConfiguration = content
        cell.backgroundColor = UIColor.black
        return cell
    }
}
