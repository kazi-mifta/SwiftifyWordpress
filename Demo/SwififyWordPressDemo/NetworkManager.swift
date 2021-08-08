import Foundation

// Different Type of Error During Network Request
enum APIError: String,Error {
    case noData = "No data received from the server."
    case noResponse = "No response Returned From Server"
    case invalidResponse = "The server response was invalid (unexpected format)"
    case badRequest = "The request was rejected: 400-499"
    case serverError = "Encoutered a server error."
    case parseError = "Error During JSON Parsing"
    case unknown = "Unkown Error During Network Request"
}


class NetworkManager {
    
    class func request<T: Codable>(baseUrl : String,pageNo: Int = 1, completion: @escaping (Result<T , Error>) -> ()) {
        
        // Construction of URL
        var components = URLComponents()
        components.scheme = "https"
        components.host = baseUrl
        components.path = "/wp-json/wp/v2/posts/"
        components.queryItems = [
            URLQueryItem(name: "page", value: "\(pageNo)")
        ]
        
        guard let url = components.url else { return }
        
        // Adding additional components to the request. eg - Headers, Body etc
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            // Error Check
            guard error == nil else {
                completion(.failure(error!))
                print(error?.localizedDescription ?? "Unknown Error during Network Request")
                return
            }
            // Response Check
            guard response != nil, let data = data else {
                completion(.failure(APIError.noResponse))
                print("No response returned from server")
                return
            }
            guard let urlResponse = response as? HTTPURLResponse else {
                completion(.failure(APIError.invalidResponse))
                return
            }
            
            switch urlResponse.statusCode {
            case 200...299:// successful response
                DispatchQueue.main.async {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.standardT)
                    if let responseObject = try? decoder.decode(T.self, from: data) {
                        completion(.success(responseObject))
                    } else {
                        completion(.failure(APIError.parseError))
                    }
                }
            case 400...499:
                return completion(.failure(APIError.badRequest))
            case 500...599:
                return completion(.failure(APIError.serverError))
            default:
                return completion(.failure(APIError.unknown))
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
