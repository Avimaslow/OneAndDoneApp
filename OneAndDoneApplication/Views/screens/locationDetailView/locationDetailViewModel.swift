//
//  locationDetailViewModel.swift
//  OneAndDoneApplication
//
//  Created by Avi Maslow on 2/17/24.
//

import Foundation
import SwiftUI
import MapKit
import CloudKit


    @MainActor @Observable 
final class locationDetailViewModel {
        
        var alertItem: AlertItem?
        var isLoading = false
        let columns = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
        
        @ObservationIgnored var location: OneandDoneLocations
        
        init(location: OneandDoneLocations) {
            self.location = location }
        
        func getDirectionsToLocation() {
            let placemark = MKPlacemark(coordinate: location.location.coordinate)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = location.name
            
            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking])
        }
        
        func callLocation() {
            guard let url = URL(string: "tel://\(location.phoneNum)") else {
                alertItem = AlertContext.invalidPhoneNum
                return
            }
            UIApplication.shared.open(url)
        }
    private func showLoadingView() { isLoading = true }
    private func hideLoadingView() { isLoading = false }
    }


       
