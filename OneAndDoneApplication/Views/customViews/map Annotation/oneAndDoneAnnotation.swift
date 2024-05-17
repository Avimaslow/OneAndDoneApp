//
//  oneAndDoneAnnotation.swift
//  OneAndDoneApplication
//
//  Created by Avi Maslow on 2/17/24.
//

import SwiftUI

struct oneAndDoneAnnotation: View {
    var location: OneandDoneLocations
    var body: some View {
        VStack {
            ZStack {
                mapShape()
                    .fill(Color.brandprimary.gradient)
                    .frame(width: 100, height: 70)
                   // .foregroundColor(.brandprimary)
                
                Image(uiImage: location.SquareImage)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .offset(y: -10)
            }
           
            Text(location.name)
                .font(.caption2)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    oneAndDoneAnnotation(location: OneandDoneLocations(record: mockData.location))
}
