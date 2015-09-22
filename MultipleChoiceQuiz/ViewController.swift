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
    
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    
    var correctAnswerButton : UIButton? = nil
    
    var questions = [QuizQuestion]()
    var currentQuestion = 0
    
    @IBAction func answerClicked(sender: UIButton) {
        if(sender == correctAnswerButton)
        {
            print("richtig")
            currentQuestion = currentQuestion + 1
            
            if(currentQuestion == questions.count)
            {
                print("you win")
            }
            else
            {
                print("richtig - naechste Frage")
                showQuestion(questions[currentQuestion])
            }
        }
        else
        {
            print("falsch")
            
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

