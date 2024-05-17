//
//  SwiftUIView.swift
//  OneAndDoneApplication
//
//  Created by Avi Maslow on 2/23/24.
//

import SwiftUI

struct loadView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .opacity(0.9)
                .ignoresSafeArea()
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .brandPrimary))
                .scaleEffect(2)
                .offset(y: -40)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        loadView()
    }
}
