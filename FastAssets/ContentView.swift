//
//  ContentView.swift
//  FastAssets
//
//  Created by A. Zheng (github.com/aheze) on 9/16/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//
    
import Photos
import SwiftUI

struct ContentView: View {
    @State var fetchDuration = ""
    @State var identifiersDuration = ""
    @State var localIdentifiers = [String]()
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Fetch photos") {
                let fetchStopwatch = Stopwatch()
                let fetchRequest = PHAsset.fetchAssets(with: nil)
                self.fetchDuration = fetchStopwatch.getTime()
                
                let identifiersStopwatch = Stopwatch()
                var localIdentifiers = [String]()
                fetchRequest.enumerateObjects { asset, _, _ in
                    localIdentifiers.append(asset.localIdentifier)
                }
                self.identifiersDuration = identifiersStopwatch.getTime()
                self.localIdentifiers = Array(localIdentifiers.prefix(3))
            }
            .buttonStyle(.borderedProminent)
            
            Text("Fetch: \(fetchDuration)")
            Text("Identifiers: \(identifiersDuration)").foregroundColor(.red)
        
            VStack {
                ForEach(localIdentifiers, id: \.self) { localIdentifier in
                    Text(localIdentifier)
                }
            }
            .background(Color.blue.opacity(0.1))
        }
    }
}

class Stopwatch: CustomStringConvertible {
    private let startTime: CFAbsoluteTime
    private var endTime: CFAbsoluteTime?
    
    init() {
        startTime = CFAbsoluteTimeGetCurrent()
    }
    
    var description: String {
        let time = getTime()
        return time
    }
    
    func getTime() -> String {
        endTime = CFAbsoluteTimeGetCurrent()
        if let duration = getDuration() {
            return String(format: "%.5f", duration)
        }
        return "[No Time]"
    }
    
    func getDuration() -> CFAbsoluteTime? {
        if let endTime = endTime {
            return endTime - startTime
        } else {
            return nil
        }
    }
}
