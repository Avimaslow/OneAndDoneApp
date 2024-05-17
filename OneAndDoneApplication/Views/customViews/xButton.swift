//
//  xButton.swift
//  OneAndDoneApplication
//
//  Created by Avi Maslow on 2/17/24.
//

import SwiftUI

struct xButton: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 35,height: 35)
                .foregroundColor(.brandprimary)
            Image(systemName: "xmark")
                .foregroundColor(.white)
                .imageScale(.small)
                .frame(width: 40, height: 40)
        }
    }
}

struct xButton_Previews: PreviewProvider {
    static var previews: some View {
        xButton()
    }
}
