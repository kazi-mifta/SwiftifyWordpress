import Foundation

class NetworkManager {
    
    class func request<T: Codable>(baseURL : String, completion: @escaping (Result<T , Error>) -> ()) {
        
        // Construction of URL
        var components = URLComponents()
        components.scheme = "https"
        components.host = baseURL
        components.path = "/wp-json/wp/v2/posts"
        components.queryItems = []
        
        guard let url = components.url else { return }
        
        // Adding additional components to the request. eg - Headers, Body etc
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            
            guard error == nil else {
                completion(.failure(error!))
                print(error?.localizedDescription ?? "Unknown Error")
                return
            }
            
            guard response != nil, let data = data else { return }
            data.printJSON()// debug purpose
            
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
