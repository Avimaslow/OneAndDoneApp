//
//  locationListDetailmodel.swift
//  OneAndDoneApplication
//
//  Created by Avi Maslow on 2/17/24.
//

import CloudKit
import SwiftUI
import Observation

extension locationListview {
    
   @MainActor @Observable
    final class LocationListViewModel: ObservableObject {
         var alertItem: AlertItem?
        //var alertItem: AlertItem?

        @ViewBuilder func createLocationDetailView(for location: OneandDoneLocations, in dynamicTypeSize: DynamicTypeSize) -> some View {
            if dynamicTypeSize >= .accessibility3 {
                LocationDetailView(viewModel: locationDetailViewModel(location: location)).embedInScrollView()
            } else {
                LocationDetailView(viewModel: locationDetailViewModel(location: location))
            }
        }
    }
}

