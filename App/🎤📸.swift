//
//  🎤📸.swift
//  🎤📸
//
//  Created by Daniele Bernardi on 10/24/20.
//

import SwiftUI

@main
struct 🎤📸: App {
    var body: some Scene {
        WindowGroup {
          ContentView().onOpenURL(perform: { url in
            UIApplication.shared.open(url)
          })
        }
    }
}
