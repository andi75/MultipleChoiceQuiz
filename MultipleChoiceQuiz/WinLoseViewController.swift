//
//  WinLoseViewController.swift
//  MultipleChoiceQuiz
//
//  Created by Andreas Umbach on 22.09.2015.
//  Copyright © 2015 Andreas Umbach. All rights reserved.
//

import UIKit

class WinLoseViewController : UIViewController
{
    @IBOutlet weak var winLoseLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    var score = 0
    var hasWon = false
    
    override func viewDidLoad() {
        scoreLabel.text = "Winnings: \(score)"
        winLoseLabel.text = hasWon ? "You Win!" : "You Lose!"
        
    }
}