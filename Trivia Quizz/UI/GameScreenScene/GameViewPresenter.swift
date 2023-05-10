//
//  GameViewPresenter.swift
//  Trivia Quizz
//
//  Created by Gabriel Oliveira Borges on 04/05/23.
//

import Foundation

protocol GameViewPresenterLogic {
    func changeText(newText: String)
    
    func onQuestionChange(_ question: GameScreenModel.FetchQuestions.ViewModel.Question)
}

class GameViewPresenter: GameViewPresenterLogic {
    var view: GameScreenViewLogic? = nil
    
    func changeText(newText: String) {
        view?.onTextChange(newText: newText)
    }
    
    func onQuestionChange(_ question: GameScreenModel.FetchQuestions.ViewModel.Question) {
//        TODO:
    }
}
