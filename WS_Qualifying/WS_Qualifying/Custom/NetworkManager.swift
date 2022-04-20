//
//  NetworkManager.swift
//  WS_Qualifying
//
//  Created by Илья Абросимов on 20.04.2022.
//

import Foundation
import Alamofire

enum Key: String {
    case accessToken, refreshToken, nickname
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private let baseURL = "http://62.113.103.113/api/"
    private let defaults = UserDefaults.standard
    private var accessToken: String? {
        defaults.string(forKey: Key.accessToken.rawValue)
    }
    
    private init() {}
    
    func login(body: LoginEncodable,
               onSuccess: @escaping () -> Void,
               onError: @escaping (Error) -> Void) {
        
        AF.request(baseURL + "auth/login",
                   method: .post,
                   parameters: body,
                   encoder: JSONParameterEncoder.default)
        .validate().responseData { response in
            switch response.result {
            case .success(let data):
                if let decodedData = try? JSONDecoder().decode(Tokens.self, from: data) {
                    print(decodedData.accessToken, decodedData.refreshToken)
                    self.defaults.set(decodedData.accessToken.token, forKey: Key.accessToken.rawValue)
                    self.defaults.set(decodedData.refreshToken.token, forKey: Key.refreshToken.rawValue)
                    self.defaults.set(body.nickname, forKey: Key.nickname.rawValue)
                    self.defaults.synchronize()
                    onSuccess()
                }
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    func refresh(complition: @escaping (Bool) -> Void) {
        let refresh = Refresh(refreshToken: defaults.string(forKey: Key.refreshToken.rawValue) ?? "")
        AF.request(baseURL + "auth/token/refresh",
                   method: .post,
                   parameters: refresh,
                   encoder: JSONParameterEncoder.default,
                   interceptor: self).validate().responseData { response in
            switch response.result {
            case .success(let data):
                if let decodedData = try? JSONDecoder().decode(Tokens.self, from: data) {
                    self.defaults.set(decodedData.accessToken, forKey: Key.accessToken.rawValue)
                    self.defaults.set(decodedData.refreshToken, forKey: Key.refreshToken.rawValue)
                    self.defaults.synchronize()
                    complition(true)
                } else {
                    complition(false)
                }
            case .failure:
                complition(false)
            }
        }
    }
    
    func getGames(onSuccess: @escaping ([GamePreview]) -> Void,
                  onError: @escaping (Error) -> Void) {
        AF.request(baseURL + "games",
                   method: .get,
                   interceptor: self).validate().responseData { response in
            switch response.result {
            case .success(let data):
                if let decodedData = try? JSONDecoder().decode([GamePreview].self, from: data) {
                    onSuccess(decodedData)
                } else {
                    print(String(describing: data))
                }
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    func getRecords(onSuccess: @escaping ([Record]) -> Void,
                    onError: @escaping (Error) -> Void) {
        AF.request(baseURL + "games/95f01bd2-bfce-11ec-9d64-0242ac120002/results",
                   method: .get,
                   interceptor: self).validate().responseData { response in
            switch response.result {
            case .success(let data):
                if let decodedData = try? JSONDecoder().decode([Record].self, from: data) {
                    onSuccess(decodedData)
                } else {
                    print(String(describing: data))
                }
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    func postPoints(body: Points,
                    onSuccess: @escaping () -> Void,
                    onError: @escaping (Error) -> Void) {
        AF.request(baseURL + "games/95f01bd2-bfce-11ec-9d64-0242ac120002/results",
                   method: .post,
                   parameters: body,
                   encoder: JSONParameterEncoder.default,
                   interceptor: self).validate().responseData { response in
            switch response.result {
            case .success:
                onSuccess()
            case .failure(let error):
                onError(error)
            }
        }
    }
}

extension NetworkManager: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        guard let token = accessToken else {
            completion(.success(urlRequest))
            return
        }
        
        let bearerToken = "Bearer \(token)"
        request.setValue(bearerToken, forHTTPHeaderField: "Authorization")
        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard request.retryCount < 2 else {
            completion(.doNotRetry)
            return
        }
        
        refresh { success in
            success ? completion(.retry) : completion(.doNotRetry)
        }
    }
}
