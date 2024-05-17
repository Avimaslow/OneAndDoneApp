//
//  ONE&DONEButton.swift
//  OneAndDoneApplication
//
//  Created by Avi Maslow on 2/17/24.
//

import SwiftUI

struct ONEDONEButton: View {
    
    var title: String
    var body: some View {
        Text(title)
            .bold()
            .frame(width:  280, height:  44)
            .background(Color.brandprimary)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}

#Preview {
    ONEDONEButton(title: "test button")
}
