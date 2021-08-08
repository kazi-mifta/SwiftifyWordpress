//
//  PostView.swift
//  FitPlan
//
//  Created by Mohammad Mainul Islam on 9/3/20.
//  Copyright © 2020 Arcade Studios. All rights reserved.
//

import Foundation
import SwiftUI
import SafariServices
import SDWebImageSwiftUI

struct PostRowView: View {
    let postImageUrl: String?
    let postTitle: String
    let postPublishDate: String
    let postUrl: String?
    
    @State private var presentingSafariView = false
    
    var body: some View {
        HStack(spacing: 20.0) {
            // if there is no featured media is nil then ImageView won't be created___
            postImageUrl.map { url in
                WebImage(url: URL(string: url))
                    .resizable()
                    .placeholder(Image("placeholder"))
                    .indicator(.activity) // Activity Indicator
                    .transition(.fade(duration: 0.5)) // Fade Transition with duration
                    .scaledToFit()
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 10.0, x: 4.0, y: 4.0)
                    .frame(width: 110, height: 100, alignment: .center)
            }
            VStack(alignment: .leading) {
                Text("\(postTitle)")
                    .font(.headline)
                Text("Date : \(postPublishDate)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
            }
        }.onTapGesture {
            presentingSafariView = postTitle == "Loading..." ? false : true
        }
        .safariView(isPresented: $presentingSafariView) {
            SafariView(url: URL(string: postUrl!)!,configuration: SafariView.Configuration(
                entersReaderIfAvailable: false,
                barCollapsingEnabled: true
            )
            )
            .dismissButtonStyle(.done)
        }
    }
}

extension PostRowView {
    init(with post: Post) {
        postImageUrl = post.featuredMediaUrl
        postTitle = post.title?.rendered ?? ""
        postPublishDate = post.date?.toString(format: "dd MMM, yyyy") ?? ""
        postUrl = post.link
    }
}

extension Date {
    func toString(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
