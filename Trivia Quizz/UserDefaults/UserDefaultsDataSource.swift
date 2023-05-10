//
//  UserDefaultsWorker.swift
//  Trivia Quizz
//
//  Created by Gabriel Oliveira Borges on 09/05/23.
//

import Foundation

class UserDefaultsDataSource {
    static let shared = UserDefaultsDataSource()
    private let TOKEN_KEY = "TOKEN_KEY"
    private let defaults = UserDefaults.standard
    private let openTriviaAPI = OpenTriviaAPI.shared
    
    func getToken() -> String? {
        let decoder = JSONDecoder()
        
        guard let dataUserToken = defaults.object(forKey: TOKEN_KEY) as? Data else {
            return nil
        }
        
        guard let userToken = try? decoder.decode(GameScreenModel.FetchToken.UserToken.self, from: dataUserToken) else {
            return nil
        }
        
        if userToken.isTokenValid {
            return userToken.token
        } else {
            self.deleteUserToken()
        }
        return nil
    }
    
    func saveToken(_ userToken: GameScreenModel.FetchToken.UserToken) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(userToken) {
            defaults.set(encoded, forKey: TOKEN_KEY)
        }
    }

    private func deleteUserToken() {
        defaults.set(nil, forKey: TOKEN_KEY)
    }
}
