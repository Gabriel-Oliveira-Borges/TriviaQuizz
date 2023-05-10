//
//  GameViewInteractor.swift
//  Trivia Quizz
//
//  Created by Gabriel Oliveira Borges on 04/05/23.
//

import Foundation

class GameViewInteractor {
    var presenter: GameViewPresenterLogic? = nil
    private let openTriviaWorker = OpenTriviaWorker()
    
    func fetchQuestions() {
        Task {
            var request = GameScreenModel.FetchQuestions.Request(amount: 1)
            request.category = GameScreenModel.FetchQuestions.Request.Category(name: "General Knowledge", id: 9)
            switch await openTriviaWorker.fetchQuestions(request: request) {
            case .success(let data): print(data); print(data.toViewModel())
            case .failure( _): do {}
            }
        }
    }
}
