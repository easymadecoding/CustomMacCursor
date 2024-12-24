import SwiftUI

@main
struct customCursorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(width: 0, height: 0)
                .onAppear{
                    customCursorManager.shared.startCursorEffect()
                }
        }
    }
}
