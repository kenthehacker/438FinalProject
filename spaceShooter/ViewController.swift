//
//  ViewController.swift
//  spaceShooter
//
//  Created by Kenichi Matsuo on 11/15/21.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var canvas: GameView!
    var gameView: GameView!
    override func viewDidLoad() {
        super.viewDidLoad()
        gameView = GameView(frame: canvas.frame)
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = (touches.first)!.location(in: gameView) as CGPoint
        for i in 0..<gameView.items.count{
            //set the location
            if gameView.items[i].contains(point: touchPoint){
                gameView.items[i].updateLocation(newLoc: touchPoint)
                
            }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = (touches.first)!.location(in: gameView) as CGPoint
        for i in 0..<gameView.items.count{
            //set the location
            if gameView.items[i].contains(point: touchPoint){
                gameView.items[i].updateLocation(newLoc: touchPoint)
                
            }
        }
    }

}

