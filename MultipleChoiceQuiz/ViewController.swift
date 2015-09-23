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
        timer = nil
        
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
        
        restZeit = 60
        restzeitLabel.text = "\(restZeit)"
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("countdown"), userInfo: nil, repeats: true)
    }
    
    func countdown()
    {
        restZeit = restZeit - 1
//        restZeit--
        
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
                question: "Wenn das Wetter gut ist, wird der Bauer bestimmt den Eber, das Ferkel und...?",
                correctAnswer : "...die Sau rauslassen",
                wrongAnswers: ["...einen draufmachen", "...die Nacht durchzechen", "...auf die Kacke hauen"]
            ),
            QuizQuestion(
                question: "Was ist meist ziemlich viel?",
                correctAnswer : "stolze Summe",
                wrongAnswers: ["selbstbewusste Differenz", "arroganter Quotient", "hochmütiges Produkt"]
            ),
            QuizQuestion(
                question: "Wessen Genesung schnell voranschreitet, der erholt sich...?",
                correctAnswer : "...zusehends",
                wrongAnswers: ["...hinguckends", "...anschauends", "...glotzends"]
            ),
            QuizQuestion(
                question: "Natürlich spielten musikalische Menschen auch im...?",
                correctAnswer : "...Ostblock Flöte",
                wrongAnswers: ["...Südpo Saune", "...Nordklari Nette", "..Westsaxo Fon"]
            ),
            QuizQuestion(
                question: "Wobei gibt es keine geregelten Öffnungszeiten?",
                correctAnswer : "Fensterläden",
                wrongAnswers: ["Möbelhäuser", "Teppichgeschäfte", "Baumärkte"]
            ),
            QuizQuestion(
                question: "Was war bereits seit Mai 1969 ein beliebtes Zahlungsmittel im europäischen Raum?",
                correctAnswer : "Eurocheques",
                wrongAnswers: ["Euronoten", "Euroscheine", "Euromünzen"]
            ),
            QuizQuestion(
                question: "Malu Dreyer profitierte Anfang des Jahres von...?",
                correctAnswer : "...Becks Rücktritt",
                wrongAnswers: ["...Oettingers Sattelstange", "...Veltins Fahrradkette", "..Diebels Vorderreifen"]
            ),
            QuizQuestion(
                question: "Woraus besteht in der Regel eine Entourage?",
                correctAnswer : "Freunde & Bekannte",
                wrongAnswers: ["Baguette & Rotwein", "Mascara & Lidschatten", "Sofa & Sessel"]
            ),
            QuizQuestion(
                question: "Was haben die Hollywood-Stars Gosling, Reynolds und Phillippe gemeinsam?",
                correctAnswer : "Vorname Ryan",
                wrongAnswers: ["Ex-Frau Megan Fox", "Geburtsjahr 1978", "irische Staatsbürgerschaft"]
            ),
            
            QuizQuestion(
                question: "Welche beiden Staaten einigten sich Ende 2012 über die Festsetzung eines Grenzverlaufs?",
                correctAnswer : "Dänemark & Kanada",
                wrongAnswers: ["Deutschland & Australien", "Polen & Südafrika", "Österreich & Japan"]
            ),

            
            QuizQuestion(
                question: "Seine drei Weltmeister-Titel erfuhr sich Sebastian Vettel mit Motoren von...?",
                correctAnswer : "Renault",
                wrongAnswers: ["Ferrari", "Mercedes", "Toyota"]
            ),
            
            QuizQuestion(
                question: "Welcher General vertrieb im 19. Jahrhundert die Mexikaner aus dem heutigen US-Bundesstaat Texas?",
                correctAnswer : "Sam Houston",
                wrongAnswers: ["John Denver", "Michael Miami", "Phil A. Delphia"]
            ),
            QuizQuestion(
                question: "Der Text welches dieser berühmten Songs ist ganz offensichtlich an eine Prostituierte gerichtet?",
                correctAnswer : "\"Roxanne\" von The Police",
                wrongAnswers: ["\"Angie\" von den Stones", "Manilows \"Mandy\"", "Jacksons \"Billie Jean\""]
            ),
            QuizQuestion(
                question: "Was soll in bestimmten Abständen nach der sogenannten ABCDE-Regel kontrolliert werden?",
                correctAnswer : "Leberflecken auf der Haut",
                wrongAnswers: ["Komposthaufen im Garten", "Luftdruck der Autoreifen", "Aktienfonds bei der Bank"]
            ),
            QuizQuestion(
                question: "Wer sollte sich mit der \"Zwanzig nach vier\"-Stellung auskennen?",
                correctAnswer: "Kellner",
                wrongAnswers: ["Fahrlehrer", "Karatemeister", "Landschafts-Architekt"]
            )
        ]
        showQuestion(questions[currentQuestion])
    }
}

