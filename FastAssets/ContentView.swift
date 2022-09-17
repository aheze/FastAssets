//
//  ContentView.swift
//  FastAssets
//
//  Created by A. Zheng (github.com/aheze) on 9/16/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//
    

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
