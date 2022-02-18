//
//  File.swift
//  FitPlan
//
//  Created by Mohammad Mainul Islam on 9/3/20.
//  Copyright © 2020 Arcade Studios. All rights reserved.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
public struct PostsListView: View {
    
    @State private var searchText = ""
    
    @ObservedObject var postsData: PostsData
    let dummyLoadingPost = Post(id: nil, link: "https://google.com/", title: Title(rendered: "Loading Posts..."), featuredMediaUrl: "abcd", date: Date())
    
    public var body: some View {
        NavigationView {
            if #available(iOS 15.0, *) {
                List {
                    ForEach(searchResults) { post in
                        PostRowView(with: post)
                    }
                    
                    // Indicates if more posts are available or not
                    if postsData.morePostsAvailable == true {
                        // End of the List Loading View will Appear and
                        //  more posts will be loaded if Available
                        PostRowView(with: dummyLoadingPost)
                            .onAppear {
                                postsData.fetchPosts()
                            }
                    }
                } // If Any Error Appears the User will be Notified with Alert View
                .alert(isPresented: $postsData.networkError.occured) {
                    Alert(title: Text("Error!!!"), // Title
                          message: Text("\(postsData.networkError.description)"), // Error Description
                          dismissButton: .default(Text("OK")))
                }
                .searchable(text: $searchText,placement: .navigationBarDrawer) // Search bar
                .navigationBarTitle("Posts")
            } else {
                // Fallback on earlier versions
                List {
                    ForEach(postsData.posts) { post in
                        PostRowView(with: post)
                    }
                    
                    // Indicates if more posts are available or not
                    if postsData.morePostsAvailable == true {
                        // End of the List Loading View will Appear and
                        //  more posts will be loaded if Available
                        PostRowView(with: dummyLoadingPost)
                            .onAppear {
                                postsData.fetchPosts()
                            }
                    }
                } // If Any Error Appears the User will be Notified with Alert View
                .alert(isPresented: $postsData.networkError.occured) {
                    Alert(title: Text("Error!!!"), // Title
                          message: Text("\(postsData.networkError.description)"), // Error Description
                          dismissButton: .default(Text("OK")))
                }
                .navigationBarTitle("Posts")
            }
        }
        .navigationViewStyle(.stack)

    }
    
    // Search results will contain the filtered posts
    var searchResults: [Post] {
        if searchText.isEmpty {
            return postsData.posts
        } else {
            return postsData.posts.filter {
                guard let title = $0.title?.rendered?.lowercased() else { return false}
                return title.contains(searchText.lowercased())
            }
        }
    }
}

extension PostsListView {
    public init(with data: PostsData) {
        postsData = data
    }
}
