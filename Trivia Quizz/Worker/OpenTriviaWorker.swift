//
//  OpenTriviaWorker.swift
//  Trivia Quizz
//
//  Created by Gabriel Oliveira Borges on 08/05/23.
//

import Foundation

class OpenTriviaWorker {
    private let api = OpenTriviaAPI.shared
    private let userDefaults = UserDefaultsDataSource.shared
    
    init() {
        self.dealTokenization()
    }
    
    func fetchQuestions(request: GameScreenModel.FetchQuestions.Request) async -> Result<GameScreenModel.FetchQuestions.Response, Error> {
        guard let rawResponse = try? await api.getQuestions(request: request).get() else {
            return Result.failure(URLError.Code.badURL as! Error)
        }
        
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(GameScreenModel.FetchQuestions.Response.self, from: rawResponse)
            return Result.success(response)
        } catch {
            print("Erro: \(error)")
            return Result.failure(URLError.Code.cannotDecodeContentData as! Error)
        }
    }
    
    private func dealTokenization() {
        Task {
            if let userToken = userDefaults.getToken() {
                api.userToken = userToken
            } else {
                
                api.userToken = await self.getUserToken()?.token
            }
        }
    }
    
    private func getUserToken() async -> GameScreenModel.FetchToken.UserToken? {
        guard let rawResponse = try? await api.getToken().get() else {
            print("Error getting token")
            return nil
        }
        
        let decoder = JSONDecoder()
        
        do {
            let response = try decoder.decode(GameScreenModel.FetchToken.Response.self, from: rawResponse)
            
            if response.responseCode != 0 {
                return nil
            }
            let userToken = response.toUserToken()
            userDefaults.saveToken(userToken)
            
            return userToken
        } catch {
            print("Error decoding token")
            return nil
        }
    }
}
