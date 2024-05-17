//
//  locationMapViewModel.swift
//  OneAndDoneApplication
//
//  Created by Avi Maslow on 2/17/24.
//

import MapKit
import SwiftUI
import CloudKit
extension locationMapView {
    @Observable
      final class LocationMapViewModel: NSObject, CLLocationManagerDelegate  {
         var isShowingDetailView = false
         var alertItem: AlertItem?
         var showLookAround = false
         var cameraPosition: MapCameraPosition = .region(.init(center: CLLocationCoordinate2D(latitude: 40.7580, longitude: -73.9855), latitudinalMeters: 1200, longitudinalMeters: 1200))
         var route: MKRoute?
         var lookAround: MKLookAroundScene? {
              didSet{
                  if let _ = lookAround {
                    showLookAround = true
                  }
              }
          }
        
        let devicelocationManager = CLLocationManager()
        
        override init() {
            super.init()
            devicelocationManager.delegate = self
            //CHANGED // CHANGEDDDD
            requestLocationPermission()
        }
          
          // CHANGEDDDD
          func requestLocationPermission() {
                 devicelocationManager.requestWhenInUseAuthorization()
             }
        
        func requestAllowOnceLocationPerm() {
            devicelocationManager.requestLocation()
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let currentLocation = locations.last else { return }
            
            withAnimation {
              //  region = MKCoordinateRegion(center: currentLocation.coordinate, span:  MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                
                cameraPosition = .region(.init(center: currentLocation.coordinate, latitudinalMeters: 1200, longitudinalMeters: 1200))
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("did fail with error")
        }
          @MainActor
        func getLocation(for locationFactory: locationFactory) {
            Task {
                do {
                    locationFactory.locations = try await cloudKitFactory.getLocations()
                } catch {
                    alertItem = AlertContext.unableToGetLocation
                }
            }
            
        }
          @MainActor
        @ViewBuilder func createLocationDetailView(for location: OneandDoneLocations, in sizeCategory: ContentSizeCategory) -> some View {
                   if sizeCategory >= .accessibilityMedium {
                       LocationDetailView(viewModel : locationDetailViewModel(location: location)).embedInScrollView()
                   } else {
                       LocationDetailView(viewModel: locationDetailViewModel(location: location))
                   }
               }
          @MainActor
          func getlookAround(for location: OneandDoneLocations){
              Task {
                  let request = MKLookAroundSceneRequest(coordinate: location.location.coordinate)
                  lookAround = try? await request.scene
              }
              
          }
          @MainActor
          func GetDirections(to location: OneandDoneLocations) {
              guard let userlocation = devicelocationManager.location?.coordinate else { return }
              let destination = location.location.coordinate
              
              let request = MKDirections.Request()
              request.source = MKMapItem(placemark:  .init(coordinate: userlocation))
              request.destination = MKMapItem(placemark: .init(coordinate: destination))
              request.transportType = .walking
              
              Task {
                  let direction = try? await MKDirections(request: request).calculate()
                  route = direction?.routes.first
              }
          }
        }
    }

