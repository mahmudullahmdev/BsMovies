//
//  MovieListEmptyView.swift
//  BsMovies
//
//  Created by Mahmudullah on 12/8/22.

import SwiftUI

struct MovieListEmptyView: View {
    var body: some View {
        GeometryReader { proxy in
            HStack {
                Color(UIColor.systemGray5)
                    .frame(width: proxy.size.width/3, height: proxy.size.width/2)
                
                VStack(alignment:.leading, spacing: 10) {
                   Rectangle()
                        .foregroundColor(Color(UIColor.systemGray5))
                        .frame(width: proxy.size.width/1.8, height: proxy.size.width/9)
                        .cornerRadius(10)
                    Rectangle()
                         .foregroundColor(Color(UIColor.systemGray5))
                         .frame(width: proxy.size.width/1.8, height: proxy.size.width/9)
                         .cornerRadius(10)
                    Rectangle()
                         .foregroundColor(Color(UIColor.systemGray5))
                         .frame(width: proxy.size.width/1.8, height: proxy.size.width/9)
                         .cornerRadius(10)
                    
                }
            }
            .padding(.all, 10)
        }
    }
}

struct MovieListEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListEmptyView()
    }
}
