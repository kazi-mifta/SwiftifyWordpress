import Foundation

class NetworkManager {
    
    class func request<T: Codable>(baseUrl : String, completion: @escaping (Result<T , Error>) -> ()) {
        
        // Construction of URL
        var components = URLComponents()
        components.scheme = "https"
        components.host = baseUrl
        components.path = "/wp-json/wp/v2/posts/"
        components.queryItems = [
            URLQueryItem(name: "per_page", value: "20")
        ]
        
        guard let url = components.url else { return }
        
        // Adding additional components to the request. eg - Headers, Body etc
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
                
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            
            guard error == nil else {
                completion(.failure(error!))
                print(error?.localizedDescription ?? "Unknown Error")
                return
            }
            
            guard response != nil, let data = data else { return }
            
            DispatchQueue.main.async {
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.standardT)// Extension
                
                if let responseObject = try? decoder.decode(T.self, from: data) {
                    completion(.success(responseObject))
                } else {
                    let error = NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey: "response"])
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
}

extension DateFormatter {
    static let standardT: DateFormatter = {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter
    }()

    static let standard: DateFormatter = {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }()

    static let yearMonthDay: DateFormatter = {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
}
