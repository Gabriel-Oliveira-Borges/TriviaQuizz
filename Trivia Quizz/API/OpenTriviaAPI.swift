//
//  OpenTriviaAPI.swift
//  Trivia Quizz
//
//  Created by Gabriel Oliveira Borges on 08/05/23.
//

import Foundation

class OpenTriviaAPI {
    static let shared = OpenTriviaAPI()
    var userToken: String?
    private let session = URLSession.shared
    
    
    func getToken() async -> Result<Data, Error> {
        let request = GameScreenModel.FetchToken.Request()
        if let url = URL(string: request.url) {
            return await callAPI(url: url)
        }
        print("Error getting url from GameModel.FetchQuestions.Request")
        return Result.failure(URLError(URLError.Code.badURL))
    }
    
    func getQuestions(request: GameScreenModel.FetchQuestions.Request) async -> Result<Data, Error> {
        if let url = URL(string: request.getUrl(token: userToken)) {
            return await callAPI(url: url)
        }
        print("Error getting url from GameModel.FetchQuestions.Request")
        return Result.failure(URLError(URLError.Code.badURL))
    }
    
    private func callAPI(url: URL) async -> Result<Data, Error> {
        do {
            print("Hitting \(url.absoluteString)")
            let (data, _) = try await session.data(from: url)
            return  Result.success(data)
        } catch {
            return Result.failure(error)
        }
    }
}
