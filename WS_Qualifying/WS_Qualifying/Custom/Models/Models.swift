//
//  Models.swift
//  WS_Qualifying
//
//  Created by Илья Абросимов on 20.04.2022.
//

import Foundation

struct LoginEncodable: Codable {
    let nickname: String
}

struct Tokens: Codable {
    let accessToken: Token
    let refreshToken: Token
}

struct Refresh: Codable {
    let refreshToken: String
}

struct Token: Codable {
    let token: String
    let expiresIn: Int
}

struct GamePreview: Codable {
    let id: String
    let title: String
    let previewUrl: String
}

struct Record: Codable {
    let id: String
    let points: Int
    let userNickname: String
}

struct Points: Codable {
    let points: Int
}
