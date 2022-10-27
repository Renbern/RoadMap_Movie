// Movies.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель фильмов
struct Results: Decodable {
    var results: [Movies]
}

/// Модель
struct Movies: Decodable {
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

/// Модель детальной информации о фильме
struct Details: Decodable {
    let id: Int
    let title: String
    let mark: Double
    let poster: String?
    let overview: String
    let backdropPath: String
    let budget: Int
    let genres: [Genre]
    let adult: Bool
    let releaseDate: String
    let productionCountries: [Country]
    let tagline: String
    let runtime: Int

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case mark = "vote_average"
        case poster = "poster_path"
        case overview
        case backdropPath = "backdrop_path"
        case budget
        case genres
        case adult
        case releaseDate = "release_date"
        case productionCountries = "production_countries"
        case tagline
        case runtime
    }
}

/// Модель жанра
struct Genre: Decodable {
    let name: String
}

/// Модель
struct Country: Decodable {
    let name: String
}
