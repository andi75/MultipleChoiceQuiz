//
//  ViewController.swift
//  MultipleChoiceQuiz
//
//  Created by Andreas Umbach on 21.09.2015.
//  Copyright © 2015 Andreas Umbach. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var gewinnLabel: UILabel!
    
    @IBOutlet weak var safeWinLabel: UILabel!
    @IBOutlet weak var restzeitLabel: UILabel!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    
    var correctAnswerButton : UIButton? = nil
    
    var questions = [QuizQuestion]()
    var currentQuestion = 0
    var gewinn = [
        50, 100, 200, 300, 500,
        1000, 2000, 4000, 8000, 16000,
        32000, 64000, 128000, 250000, 500000, 1000000
    ]
    var currentSafeWin = 0
    var safePoint = [
        true, false, false, false, true,
        false, false, false, false, true,
        false, false, false, false, false, true
    ]
    
    var hasWon = false
    var restZeit : Int = 0
    
    var timer : NSTimer? = nil
    
    @IBAction func answerClicked(sender: UIButton) {
        timer?.invalidate()
        
        if(sender == correctAnswerButton)
        {
//            print("richtig")
            currentQuestion = currentQuestion + 1
            
            if(currentQuestion == questions.count)
            {
//                print("you win")
                hasWon = true
                performSegueWithIdentifier("YouWinLoseSegue", sender: nil)
            }
            else
            {
//                print("richtig - naechste Frage")

                showQuestion(questions[currentQuestion])
            }
        }
        else
        {
//            print("falsch")
            hasWon = false
            performSegueWithIdentifier("YouWinLoseSegue", sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let winloseVC = segue.destinationViewController as! WinLoseViewController
        winloseVC.hasWon = hasWon
        if(hasWon)
        {
            winloseVC.score = gewinn[currentQuestion]
        }
        else
        {
            winloseVC.score = currentSafeWin
        }
    }
    
    func showQuestion(q: QuizQuestion)
    {
        let randomButtonNumber = arc4random_uniform(4) + 1
        
        switch(randomButtonNumber)
        {
        case 1:
            questionLabel.text = q.question
            answerButton1.setTitle(q.correctAnswer, forState: .Normal)
            answerButton2.setTitle(q.wrongAnswers[0], forState: .Normal)
            answerButton3.setTitle(q.wrongAnswers[1], forState: .Normal)
            answerButton4.setTitle(q.wrongAnswers[2], forState: .Normal)
            correctAnswerButton = answerButton1
        case 2:
            questionLabel.text = q.question
            answerButton1.setTitle(q.wrongAnswers[0], forState: .Normal)
            answerButton2.setTitle(q.correctAnswer, forState: .Normal)
            answerButton3.setTitle(q.wrongAnswers[1], forState: .Normal)
            answerButton4.setTitle(q.wrongAnswers[2], forState: .Normal)
            correctAnswerButton = answerButton2
        case 3:
            questionLabel.text = q.question
            answerButton1.setTitle(q.wrongAnswers[0], forState: .Normal)
            answerButton2.setTitle(q.wrongAnswers[1], forState: .Normal)
            answerButton3.setTitle(q.correctAnswer, forState: .Normal)
            answerButton4.setTitle(q.wrongAnswers[2], forState: .Normal)
            correctAnswerButton = answerButton3
        case 4:
            questionLabel.text = q.question
            answerButton1.setTitle(q.wrongAnswers[0], forState: .Normal)
            answerButton2.setTitle(q.wrongAnswers[1], forState: .Normal)
            answerButton3.setTitle(q.wrongAnswers[2], forState: .Normal)
            answerButton4.setTitle(q.correctAnswer, forState: .Normal)
            correctAnswerButton = answerButton4
        default:
            break
        }
        
        // Gewinnlabel setzen
        gewinnLabel.text = "Ihr Gewinn bisher: \(gewinn[currentQuestion])"
        
        if(safePoint[currentQuestion])
        {
            currentSafeWin = gewinn[currentQuestion]
        }
        safeWinLabel.text = "Sicherer Gewinn: \(currentSafeWin)"
        
        restZeit = 10
        restzeitLabel.text = "\(restZeit)"
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("countdown"), userInfo: nil, repeats: true)
    }
    
    func countdown()
    {
        restZeit--
        print(restZeit)
        if(restZeit == 0)
        {
            timer?.invalidate()
            timer = nil
            
            hasWon = false
            performSegueWithIdentifier("YouWinLoseSegue", sender: nil)
        }
        else
        {
            restzeitLabel.text = "\(restZeit)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        questions = [
            QuizQuestion(
                question: "What is 1 + 1",
                correctAnswer : "2",
                wrongAnswers: ["3", "4", "5"]
            ),
            QuizQuestion(
                question: "What is 1 + 1",
                correctAnswer : "2",
                wrongAnswers: ["3", "4", "5"]
            ),            QuizQuestion(
                question: "What is 1 + 1",
                correctAnswer : "2",
                wrongAnswers: ["3", "4", "5"]
            ),            QuizQuestion(
                question: "What is 1 + 1",
                correctAnswer : "2",
                wrongAnswers: ["3", "4", "5"]
            ),            QuizQuestion(
                question: "What is 1 + 1",
                correctAnswer : "2",
                wrongAnswers: ["3", "4", "5"]
            ),            QuizQuestion(
                question: "What is 1 + 1",
                correctAnswer : "2",
                wrongAnswers: ["3", "4", "5"]
            ),            QuizQuestion(
                question: "What is 1 + 1",
                correctAnswer : "2",
                wrongAnswers: ["3", "4", "5"]
            ),            QuizQuestion(
                question: "What is 1 + 1",
                correctAnswer : "2",
                wrongAnswers: ["3", "4", "5"]
            ),            QuizQuestion(
                question: "What is 1 + 1",
                correctAnswer : "2",
                wrongAnswers: ["3", "4", "5"]
            ),            QuizQuestion(
                question: "What is 1 + 1",
                correctAnswer : "2",
                wrongAnswers: ["3", "4", "5"]
            ),            QuizQuestion(
                question: "What is 1 + 1",
                correctAnswer : "2",
                wrongAnswers: ["3", "4", "5"]
            ),            QuizQuestion(
                question: "What is 1 + 1",
                correctAnswer : "2",
                wrongAnswers: ["3", "4", "5"]
            ),            QuizQuestion(
                question: "What is 1 + 1",
                correctAnswer : "2",
                wrongAnswers: ["3", "4", "5"]
            ),            QuizQuestion(
                question: "What is 1 + 1",
                correctAnswer : "2",
                wrongAnswers: ["3", "4", "5"]
            ),            QuizQuestion(
                question: "Was ist der Schmelzpunkt von Wasser",
                correctAnswer: "273.4 Grad Kelvin",
                wrongAnswers: ["373.4 Grad Kelvin", "0 Grad Fahrenheit", "100 Grad Celsius"]
            )
        ]
        showQuestion(questions[0])
        

    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

