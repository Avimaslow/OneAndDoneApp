//
//  logoView.swift
//  OneAndDoneApplication
//
//  Created by Avi Maslow on 2/17/24.
//

import SwiftUI

struct logoView: View {
    var frameWidth: CGFloat
    var body: some View {
        Image("map-logo")
            .resizable()
            .scaledToFit()
            .scaledToFit()
            .scaledToFit()
           .frame(height: frameWidth)
            
    }
}

#Preview {
    logoView(frameWidth: 5)
}
