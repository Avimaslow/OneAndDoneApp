//
//  locationCell.swift
//  OneAndDoneApplication
//
//  Created by Avi Maslow on 2/17/24.
//

import SwiftUI

struct locationCell: View {
    var location: OneandDoneLocations
    var body: some View {
        
                HStack {
                    Image(uiImage: location.SquareImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .padding(.vertical, 8)
                    
                    VStack {
                        Text(location.name)
                            .font(.title2)
                            .fontWeight(.thin)
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                            .padding(.leading)
                    }
                }
            }
        }

#Preview {
    locationCell(location: OneandDoneLocations(record: mockData.location))
}
