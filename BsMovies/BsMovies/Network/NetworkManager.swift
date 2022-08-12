//
//  NetworkManager.swift
//  BsMovies
//
//  Created by Mahmudullah on 12/8/22.
//

import Foundation

protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) -> ModelType?
    func execute() async -> Self.ModelType?
}

extension NetworkRequest {
    fileprivate func load(_ url: URLRequest) async -> Self.ModelType? {
        return await withCheckedContinuation { continuation in
            let task = URLSession.shared.dataTask(with: url) { [weak self] (data, _ , _) -> Void in
                guard let decodedData = self?.decode(data!) else {
                    return continuation.resume(returning: nil)
                }
                return continuation.resume(returning: decodedData)
            }
            task.resume()
        }
    }
}

class APIRequest<Resource: APIResource> {
    let resource: Resource
    init(resource: Resource) {
        self.resource = resource
    }
}

extension APIRequest: NetworkRequest {
    func decode(_ data: Data) -> Resource.ModelType? {
        let decoder = JSONDecoder()
        do {
            let wrapper = try decoder.decode(Resource.ModelType.self, from: data)
            return wrapper
        }
        catch let err {
            print("Failed to decode JSON \(err)")
            return nil
        }
    }
    func execute() async -> Resource.ModelType? {
        return  await load(resource.request)
    }
}
protocol APIResource {
    associatedtype ModelType: Decodable
    var methodPath: String {get}
    var method: String? {get}
    var params: [String:Any]? {get}
}
extension APIResource {
    var request: URLRequest {
        var components = URLComponents(string: Api.BASE_URL)!
        components.path = methodPath
        var queryItems = [URLQueryItem]()
        for (key, value) in params ?? [:] {
            queryItems.append(URLQueryItem(name: "\(key)", value: "\(value)"))
        }
        components.queryItems = queryItems
        var request = URLRequest(url: (components.url!))
        request.httpMethod = method
        return request
    }
}
