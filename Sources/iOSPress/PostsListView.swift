//
//  File.swift
//  FitPlan
//
//  Created by Mohammad Mainul Islam on 9/3/20.
//  Copyright © 2020 Arcade Studios. All rights reserved.
//

import Foundation
import SwiftUI

@available(iOS 13.0)
public struct PostsListView: View {
    public init(baseUrl: String) {
        self.url = baseUrl`
    }
    @State var posts: [Post] = []
    var url:String
    public var body: some View {
        NavigationView {
            List(posts) { (post) in
                PostRowView(post: post)
                    .padding(.vertical,4)
            }
            .onAppear(perform: loadPosts)
            .navigationBarTitle("Posts")
        }
    }
    
    func loadPosts() {
        NetworkManager.request(baseUrl: self.url ) {
            (result: Result<[Post], Error>) in
            switch result {
            case .success(let response):
                self.posts = response
            case .failure(let error):
                print(error)
            }
        }
    }
}
