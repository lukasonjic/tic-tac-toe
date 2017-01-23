//
//  ViewController.swift
//  Criss Cross
//
//  Created by Pet Minuta on 04/01/2017.
//  Copyright © 2017 Pet Minuta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var game: Game? = nil
    
    @IBOutlet weak var gameState: UILabel!
    
    @IBOutlet var boardButtons: [UIButton]!
    
    @IBOutlet weak var resetButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.newGame()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func titleButtonTap(_ sender: UIButton) {
        let tag = sender.tag
        let row = tag / 10 - 1
        let col = tag % 10 - 1
        if let currentPlayer = self.game?.currentPlayer {
            if let endOrContinue = self.game?.nextMove(row: row, col: col) {
                if endOrContinue != "again" {
                    sender.setTitle(String(describing: currentPlayer), for: .normal)
                    switch endOrContinue {
                    case "tied":
                        gameState.text = "Igra je završena (Izjednačeno je!)"
                        prepareNewGame()
                    case "Xwins":
                        gameState.text = "Igra je završena (Igrač X je pobijedio!)"
                        prepareNewGame()
                    case "Owins":
                        gameState.text = "Igra je završena (Igrač O je pobijedio!)"
                        prepareNewGame()
                    default:
                        changeGameStateButton()
                    }
                }
            }
        }
    }

    
    @IBAction func resetGame(_ sender: UIButton) {
        for button in boardButtons {
            button.setTitle("", for: .normal)
        }
        if sender.currentTitle == "Nova igra" {
            resetButton.setTitle("Reset", for: .normal)
        }
        self.newGame()
    }

    func newGame () {
        var player: Int = 0
        player = Int(arc4random_uniform(2))
        if player == 0 {
            gameState.text = "Na redu je igrač X."
        } else {
            gameState.text = "Na redu je igrač O."
        }
        for button in boardButtons {
            button.isEnabled = true
        }
        self.game = Game(player: player)
    }
    
    func changeGameStateButton() {
        if ((gameState.text?.range(of: "X")) != nil) {
            gameState.text = "Na redu je igrač O."
        } else {
            gameState.text = "Na redu je igrač X"
        }
    }
    
    func prepareNewGame() {
        resetButton.setTitle("Nova igra", for: .normal)
        for button in boardButtons {
            button.isEnabled = false
        }
    }
    
}

