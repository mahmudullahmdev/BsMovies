//
//  ContentView.swift
//  BsMovies
//
//  Created by Mahmudullah on 12/8/22.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    var body: some View {
        NavigationView {
            if #available(iOS 15.0, *) {
                VStack {
                    GeometryReader { proxy in
                        ScrollView(.vertical,showsIndicators: false) {
                            
                            if self.viewModel.movieList.count > 0 {
                                LazyVStack {
                                    ForEach(0..<self.viewModel.movieList.count, id: \.self){ index in
                                        let item = self.viewModel.movieList[index]
                                        MovieListItemView(item: item, proxy: proxy)
                                        
                                    }
                                }
                            } else {
                                LazyVStack {
                                    ForEach(0..<10){ index in
                                        MovieListEmptyView()
                                            .frame(width: proxy.size.width, height: proxy.size.width/2)
                                    }
                                }
                            }
                            
                            
                        }
                        
                        
                    }
                    
                }
                .navigationTitle("Movie List")
                .onAppear{
                    self.viewModel.queryString = "Marvel"
                    Task {
                        await self.viewModel.getMoviesList()
                        self.viewModel.queryString = ""
                    }
                }
                .searchable(text: self.$viewModel.queryString, prompt: "Search movies..")
                .onChange(of: self.viewModel.queryString){newQuery in
                    self.viewModel.queryString = newQuery
                    Task{
                        await self.viewModel.getMoviesList()
                    }
                }
            } else {
                // Fallback on earlier versions
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
