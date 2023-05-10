//
//  GameModel.swift
//  Trivia Quizz
//
//  Created by Gabriel Oliveira Borges on 27/04/23.
//

import Foundation

struct GameScreenModel {
    struct FetchQuestions {
        struct Request {
            private let baseURL = "https://opentdb.com/api.php"
            var category: Category?
            var amount: Int
            var difficulty: Difficulty?
            var type: QuestionType?
            
            struct Category {
                var name: String
                var id: Int
            }
            enum Difficulty: String {
                case easy = "easy"
                case medium = "medium"
                case hard = "hard"
            }
            
            enum QuestionType: String {
                case trueFalse = "boolean"
                case multipleChoise = "multiple"
            }
            
            func getUrl() -> String {
                var url = baseURL
                
                url += "?amount=\(self.amount)"
                
                if let category = self.category {
                    url += "&category=\(category.id)"
                }
                if let difficulty = self.difficulty {
                    url += "&difficulty=\(difficulty.rawValue)"
                }
                
                if let type = self.type {
                    url += "&type=\(type)"
                }
                
                return url
            }
        }
        
        struct Response: Codable {
            let responseCode: Int
            let results: [Result]
            
            struct Result: Codable {
                let category: String
                let type: String
                let difficulty: String
                let question: String
                let correctAnswer: String
                let incorrectAnswers: [String]
                
                enum CodingKeys: String, CodingKey {
                    case category
                    case type
                    case difficulty
                    case question
                    case correctAnswer = "correct_answer"
                    case incorrectAnswers = "incorrect_answers"
                }
            }
            
            enum CodingKeys: String, CodingKey {
                case responseCode = "response_code"
                case results
            }
            
            func toViewModel() -> ViewModel {
                let questions: [FetchQuestions.ViewModel.Question] = self.results.map { question in
                    ViewModel.Question(
                        title: question.question,
                        category: question.category,
                        correctAnswer: question.correctAnswer,
                        answers: question.incorrectAnswers
                    )
                }
                let viewModel = ViewModel(questions: questions)
                
                return viewModel
            }
        }

        struct ViewModel {
            var questionIndex = 0
            var questions: [Question]
            
            struct Question {
                var title: String
                var category: String
                var correctAnswer: String
                var answers: [String]
            }
        }
    }
}
