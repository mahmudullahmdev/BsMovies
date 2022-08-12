//
//  HomeViewModel.swift
//  BsMovies
//
//  Created by Mahmudullah on 12/8/22.
//

import Foundation
class HomeViewModel: ObservableObject {
    @Published var movieList: [MovieModel] = []
    @Published  var queryString: String = "Marvel"

    
    
    func getMoviesList() async {
        let params: [String: Any] = [
            "api_key": CommonOperations.shared.getApiKey(),
            "query": self.queryString
        ]
        let resource = GetMoviesResource(params: params, method: "GET")
        let request = APIRequest(resource: resource)
        let response = await request.execute()
        if response?.results.count ?? 0 > 0 {
            DispatchQueue.main.async {
                self.movieList = response?.results ?? []
            }
            
        }
    }
}
