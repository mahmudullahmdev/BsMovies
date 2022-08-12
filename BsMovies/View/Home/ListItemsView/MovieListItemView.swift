//
//  MovieListItemView.swift
//  BsMovies
//
//  Created by Mahmudullah on 12/8/22.
//

import SwiftUI

struct MovieListItemView: View {
    let item: MovieModel
    let proxy: GeometryProxy?
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(Color(UIColor.systemGray3))
                .frame(height: 1)
            HStack {
                if #available(iOS 15.0, *) {
                    AsyncImage(url: URL(string: "\(Api.IMAGE_BASEURL)\(item.poster_path ?? "")")){image in
                        image.resizable()
                    } placeholder: {
                        Image(systemName: "photo.fill")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(.gray)

                    }
                    .frame(width: (proxy?.size.width ?? 0.0)/3, height: (proxy?.size.width ?? 0.0)/2)
                } else {
                    // Fallback on earlier versions
             
                    if let data = try? Data(contentsOf: URL(string: "\(Api.IMAGE_BASEURL)\(item.poster_path ?? "")")!) {
                        Image(uiImage: ((UIImage(data: data) ?? UIImage(systemName: "photo.fill"))!) )
                            .resizable()
                            .frame(width: (proxy?.size.width ?? 0.0)/3, height: (proxy?.size.width ?? 0.0)/2)
                    }
                
                    
                }
                
                VStack(alignment:.leading, spacing: 10) {
                    Text(item.title ?? "")
                        .font(.title3)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                    Text(item.overview ?? "")
                        .font(.body)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .padding(.all, 10)
    }
}

//struct MovieListItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieListItemView()
//    }
//}
