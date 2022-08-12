//
//  MoviesModel.swift
//  BsMovies
//
//  Created by Mahmudullah on 12/8/22.
//

import Foundation

struct GetMoviesWrapper: Codable {
    var results: [MovieModel] = []
    
    enum CodingKeys: CodingKey {
        case results
    }
}

struct MovieModel: Codable {
    var id: Int?
    var overview: String?
    var poster_path: String?
    var title: String?
    
    enum CodingKeys: CodingKey {
        case id, overview, poster_path, title
    }
}
