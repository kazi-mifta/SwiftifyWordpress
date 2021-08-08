//
//  ContentView.swift
//  SwiftifyWordPressDemo
//
//  Created by Kazi Miftahul Hoque on 9/8/21.
//

import SwiftUI
import iOSPress
struct ContentView: View {
    var body: some View {
        PostsListView(with: PostsData(url: "gadgetanalysis.com")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
