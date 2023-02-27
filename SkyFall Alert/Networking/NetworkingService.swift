//
//  NetworkingService.swift
//  SkyFall Alert
//
//  Created by Bartak, Marek on 24.02.23.
//

import Foundation
import PromiseKit

protocol NetworkingServiceType {
    func request(endpoint: ApiEndpoint) -> Promise<[MeteorResponse]>
}

class NetworkingService {
    
    // MARK: - Decoder
    lazy var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()

    // MARK: - Session Manager
    private var sessionManager: URLSession = {
        URLSession(configuration: URLSessionConfiguration.default)
    }()
    
    // MARK: - Path
    private func createPath(for endpoint: ApiEndpoint) -> URL? {
        URL(string: endpoint.path)
    }
    
    func request(endpoint: ApiEndpoint, returnType: MeteorResponse.Type, completion: @escaping (Swift.Result<[MeteorResponse], ApiError>) -> Void) {
        
        guard let path = createPath(for: endpoint) else {
            completion(.failure(.apiError(messageValue: "Create path failed", status: 4004)))
            return
        }
        
        var request = URLRequest(url: path)
        request.httpMethod = endpoint.method
        
        switch endpoint.authorization {
            case .appToken:
                request.setValue(NetworkingHeader.appToken.headerValue, forHTTPHeaderField: NetworkingHeader.appToken.headerName)
        }
        
        sessionManager.dataTask(with: request) { [unowned self] (data, response, error) in
            if let error = error as NSError? {
                print("Network request failed: \(error)")
                completion(.failure(.apiErrorContent(error: error, content: data, status: nil)))
                return
            }
            
            guard let rawStatusCode = (response as? HTTPURLResponse)?.statusCode, let statusCode = HTTPStatusCode(rawValue: rawStatusCode) else {
                print("Network request failed: Unknown error")
                completion(.failure(.unknownError))
                return
            }
            
            
            guard statusCode.responseType == .success else {
                let content = data != nil ? String(data: data!, encoding: .utf8) : "-"
                print("Network request failed with status: \(statusCode)\nContent: \(String(describing: content))")
                completion(.failure(.apiErrorContent(error: nil, content: data, status: rawStatusCode)))
                return
            }
            
            // For Void responses
            if statusCode.responseType == .success && [MeteorResponse].self == VoidResponse.self {
                print("Network request successful")
                completion(.success([]))
                return
            }
            
            do {
                guard let data = data else {
                    completion(.failure(.apiError(messageValue: "", status: statusCode.rawValue)))
                    return
                }
                let object = try jsonDecoder.decode([MeteorResponse].self, from: data)
                print("Network request successful")

                completion(.success(object))
            } catch let parsingError {
                print("Network request failed with parsing error: \(parsingError)")
                completion(.failure(.parsing(data: data, status: statusCode.rawValue)))
            }
        }.resume()
    }
}

extension NetworkingService: NetworkingServiceType {
    func request(endpoint: ApiEndpoint) -> Promise<[MeteorResponse]> {
        return Promise { [unowned self] resolver in
            self.request(endpoint: endpoint, returnType: MeteorResponse.self) { result in
                switch result {
                    case .success(let object):
                        resolver.fulfill(object)
                    case .failure(let error):
                        resolver.reject(error)
                }
            }
        }
    }
}
