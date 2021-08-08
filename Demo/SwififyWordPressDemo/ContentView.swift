//
//  ContentView.swift
//  iOSPressDemo
//
//  Created by Kazi Miftahul Hoque on 26/4/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        PostsListView(with: PostsData(url: "gadgetanalysis.com"))
    }
}
