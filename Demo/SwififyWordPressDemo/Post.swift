 import Foundation

struct Title : Codable {
    
    let rendered : String?
    
    enum CodingKeys: String, CodingKey {
        case rendered = "rendered"
    }
    
}

struct Post {
    let id: Int?
    let link: String?
    let title: Title?
    let featuredMediaUrl : String?
    let date: Date?
    
}

extension Post: Codable,Identifiable {
    enum CodingKeys: String, CodingKey {
        case id
        case link
        case title
        case featuredMediaUrl = "jetpack_featured_media_url"
        case date

    }
}
