# FastAssets
Testing repo to get `localIdentifier`s quickly

[`PHFetchResult.enumerateObjects`](https://developer.apple.com/documentation/photokit/phfetchresult/1621006-enumerateobjects) seems to hang at around 0.7 seconds, for 40k photos. I only need each asset's `localIdentifier` so loading all the assets isn't necessary.

Try it out:

1. Copy and paste this code
2. Add a camera permissions string in `Info.plist`

```swift
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
```

Results:

![Result](https://user-images.githubusercontent.com/49819455/190840173-79d5f43f-ad44-4d43-b7fc-6fdf783444d6.png)
