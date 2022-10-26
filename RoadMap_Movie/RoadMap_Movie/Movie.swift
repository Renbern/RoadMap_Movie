// Movie.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель фильмов
struct Results: Codable {
    var results: [Movies]
}

/// Модель
struct Movies: Codable {
    let id: Int
    let title: String
    let mark: Double
    let poster: String
    let overview: String

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case mark = "vote_average"
        case poster = "poster_path"
        case overview
    }
}
