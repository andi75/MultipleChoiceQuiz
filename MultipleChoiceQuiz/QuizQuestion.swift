//
//  QuizQuestion.swift
//  MultipleChoiceQuiz
//
//  Created by Andreas Umbach on 21.09.2015.
//  Copyright © 2015 Andreas Umbach. All rights reserved.
//

import Foundation

struct QuizQuestion
{
    var question : String
    var correctAnswer : String
    var wrongAnswers : [String]
}

class QuizQuestionFactory
{
    func getQuestions() -> [QuizQuestion]
    {
        let questions = [
            QuizQuestion(question: "What is 1 + 1",
                correctAnswer : "2",
                wrongAnswers: ["3", "4", "5"]),
            QuizQuestion(question: "Is this sentence false?",
                correctAnswer : "it's undecidable",
                wrongAnswers: ["true", "false", "it's unknown"]),
            
        ]
        return questions
    }
}
