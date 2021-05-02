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
    public init(baseUrl: String) {
        self.url = baseUrl
    }
    
    @State var posts: [Post] = []
    @State var isLoading = true
    @State var showingAlert = false
    @State var alertMessage = ""
    
    var url:String
    public var body: some View {
        NavigationView {
            ZStack {
                List(posts) { (post) in
                    PostRowView(post: post)
                        .padding(.vertical,4)
                }
                .onAppear(perform: loadPosts)
                .navigationBarTitle("Posts")
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Error !!!"), message: Text(alertMessage), dismissButton: .default(Text("Okay")))
                }
                // Spinner will be shown until post fetching is completed
                Spinner(isAnimating: isLoading, style: .large, color: .darkGray)
                
            }
            
        }
    }
    
    func loadPosts() {
        NetworkManager.request(baseUrl: self.url ) {
            (result: Result<[Post], Error>) in
            switch result {
            case .success(let response):
                self.posts = response
                self.isLoading = false
            case .failure(let error):
                print(error)
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
                self.isLoading = false
            }
        }
    }
}
