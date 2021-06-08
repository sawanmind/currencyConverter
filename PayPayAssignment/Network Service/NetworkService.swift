//
//  NetworkService.swift
//  PayPayAssignment
//

//

import Foundation

typealias NetworkResponse = Swift.Result<Data,NetworkError>

class NetworkService: NSObject {
    
    enum METHOD:String {
        case get = "GET"
        case post = "POST"
    }
    
    private var session: URLSession
    
    override init() {
        self.session = URLSession(configuration: URLSessionConfiguration.default)
        super.init()
    }
    
    func request(payload:[String:Any]? = nil,query:[URLQueryItem]? = nil,endpoint:String,method:METHOD, result:@escaping (NetworkResponse) -> Void) {
     
        var urlComponent = URLComponents(string: NSEndpoint.get(endpoint))
        
        // Here, I am assuming that access key is required for all request.
        var queryItems = [URLQueryItem(name: "access_key", value: Config.apiKey)]
        
        if let _query = query {
            queryItems.append(contentsOf: _query)
            urlComponent?.queryItems = queryItems
        }else {
            urlComponent?.queryItems = queryItems
        }
        
        guard let url = urlComponent?.url else {
            result(.failure(.badURL))
            return
        }
        
        switch method {
        
        case .get:
            self.get(url, result)
        case .post:
            self.post(payload, url, result)

        }
    }
    
    private func get(_ url: URL, _ result: @escaping(NetworkResponse) -> Void) {
        let urlRequest = URLRequest(url: url)
        
        let task = self.session.dataTask(with: urlRequest) { (data, response, error) in
            
            guard error == nil else {
                result(.failure(.responseError(error?.localizedDescription)))
                return
            }
            
            guard let responseData = data else {
                result(.failure(.dataNotFound))
                return
            }
            
            result(.success(responseData))
        }
        task.resume()
    }
    
    private func post(_ payload:[String:Any]? = nil, _ url: URL, _ result: @escaping(NetworkResponse) -> Void) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = METHOD.post.rawValue
        
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: payload as Any, options: [])
        } catch {
            result(.failure(.failedToConvertPayloadToData(error.localizedDescription)))
            return
        }
        
        
        let task = self.session.dataTask(with: urlRequest) { (data, response, error) in
            
            guard error == nil else {
                result(.failure(.responseError(error?.localizedDescription)))
                return
            }
            
            guard let responseData = data else {
                result(.failure(.dataNotFound))
                return
            }
            
            result(.success(responseData))
        }
        task.resume()
    }
    
}
