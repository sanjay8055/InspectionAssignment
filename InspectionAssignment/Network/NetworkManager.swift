//
//  NetworkManager.swift
//  InspectionAssignment
//
//  Created by Sanjay Raskar on 20/07/24.
//

import Foundation
 
class NetworkManager: NetworkManaging {
    let dataController = DataController.instance

    func fetchData<T: Decodable>(from url: String) async throws -> T {
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        do {
          let (data, response) = try await  URLSession.shared.data(from: url)
          guard let httpResponse = response as? HTTPURLResponse else {
              throw NetworkError.invalidResponse
           }
            if (500..<600).contains(httpResponse.statusCode) {
                throw NetworkError.serverError
            }
            
            guard(200..<300).contains(httpResponse.statusCode) else {
                throw NetworkError.invalidResponse
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            decoder.userInfo[CodingUserInfoKey.managedObjectContext] = dataController.context
            return try decoder.decode(T.self, from: data)
        } catch let error as DecodingError{
            switch error {
            case .keyNotFound(_, _):
                throw NetworkError.keyNotFound
            default:
                throw error
            }
        } catch let urlError as URLError {
            if urlError.code == .notConnectedToInternet {
                throw NetworkError.noInternetConnection
            } else {
                throw urlError
            }
        } catch {
            throw error
        }
    }
    
    func postData<T: Codable>(requestData: T, url: String) async throws -> Bool {
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let encoded = try JSONEncoder().encode(requestData)
            
            let (_, response) = try await URLSession.shared.upload(for: request, from: encoded)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            switch httpResponse.statusCode {
            case 200:
                return true
            case 400:
                throw NetworkError.badRequest
            case 401:
                throw NetworkError.unauthorized
            case (500..<600):
                throw NetworkError.serverError
            default:
                throw NetworkError.invalidResponse
            }
            
        } catch let urlError as URLError {
            if urlError.code == .notConnectedToInternet {
                throw NetworkError.noInternetConnection
            } else {
                throw urlError
            }
        } catch {
            throw error
        }
    }
    
}
