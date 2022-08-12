//
//  HomeResources.swift
//  BsMovies
//
//  Created by Mahmudullah on 12/8/22.
//

import Foundation

struct GetMoviesResource: APIResource {
    var params: [String:Any]?
    var method: String?
    typealias ModelType = GetMoviesWrapper
    var methodPath: String {
        return Api.getListOfMovies
    }
}

