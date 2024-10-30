//
//  ContentView.swift
//  HoneycombLayout
//

import SwiftUI

struct ContentView: View {
    
    let items: [String] = Array(0...19).map { "\($0)" }
    
    var body: some View {
        VStack {
            HoneycombView(items: items, itemsPerOddRow: 4, itemsPerEvenRow: 6)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
