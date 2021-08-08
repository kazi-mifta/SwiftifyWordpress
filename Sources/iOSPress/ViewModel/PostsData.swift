//
//  PostsData.swift
//  iOSPressDemo
//
//  Created by Kazi Miftahul Hoque on 8/8/21.
//

import Foundation
import Combine
import SwiftUI

public class PostsData: ObservableObject {
    
    public init(url: String){
        baseURL = url
    }
    
    let baseURL: String
    @Published var posts = [Post]()
    // Tuple to Display Error when occured
    @Published var networkError = (occured:false, description: "")
    // Tells if all records have been loaded. (Used to hide/show Loading activity)
    var morePostsAvailable = true
    // Tracks last page loaded. Used to load next page (current + 1)
    var currentPage = 0
    
    func fetchPosts() {
        NetworkManager.request(baseUrl: baseURL,pageNo: currentPage + 1 ) { [weak self]
            (result: Result<[Post], Error>) in
            switch result {
            case .success(let response):
                self?.currentPage += 1
                // Posts are added to Array Page by Page untill last Page is Reached
                self?.posts.append(contentsOf: response)
                if response.count < 10 {    // Limit of records per page (10)
                    self?.morePostsAvailable = false
                }
            case .failure(let error):
                if let error = error as? APIError {
                    self?.networkError.occured = true
                    self?.networkError.description = error.localizedDescription
                }
            }
        }
    }
}
