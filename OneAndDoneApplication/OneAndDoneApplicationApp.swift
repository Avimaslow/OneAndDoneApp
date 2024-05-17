//
//  OneAndDoneApplicationApp.swift
//  OneAndDoneApplication
//
//  Created by Avi Maslow on 2/17/24.
//

import SwiftUI

@main
struct OneAndDoneApplicationApp: App {
    let LocationFactory = locationFactory()
    
    var body: some Scene {
        WindowGroup {
            appTabView() .environmentObject(LocationFactory)
        }
    }
}
