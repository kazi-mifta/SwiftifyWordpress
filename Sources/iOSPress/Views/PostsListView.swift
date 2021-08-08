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
    
    @ObservedObject var postsData: PostsData
    let dummyLoadingPost = Post(id: nil, link: "https://google.com/", title: Title(rendered: "Loading Posts..."), featuredMediaUrl: "abcd", date: Date())
    
    public var body: some View {
        NavigationView {
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
}

extension PostsListView {
    public init(with data: PostsData) {
        postsData = data
    }
}
