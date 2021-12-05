//
//  LeaderboardObjects.swift
//  spaceShooter
//
//  Created by Eric Tseng on 12/5/21.
//

import Foundation
import UIKit

/// Contains objects for leaderboard
class LeaderboardObjects {
    var username: String
    var score: Int
    var region: String
    
    init (username: String, score: Int, region: String) {
        self.username = username
        self.score = score
        self.region = region
    }
}
