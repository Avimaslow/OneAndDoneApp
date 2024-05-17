import SwiftUI
import MapKit
import CoreLocationUI
struct locationMapView: View {
   // changedddchanged  CHnaged @EnvironmentObject private var LocationaFactory: locationFactory
    @EnvironmentObject private var LocationaFactory : locationFactory
    @State private var viewModel = LocationMapViewModel()
    @Environment(\.dynamicTypeSize) var dynamicTypeSize

    var body: some View {
        ZStack(alignment: .top) {
            Map(initialPosition: viewModel.cameraPosition) {
                ForEach(LocationaFactory.locations) { location in
                    Annotation(location.name, coordinate: location.location.coordinate) {
                        oneAndDoneAnnotation(location: location)
                            .onTapGesture {
                                LocationaFactory.selectedLocation = location
                                viewModel.isShowingDetailView = true
                            }
                            .contextMenu{
                                Button("Look Around", systemImage: "eyes") {
                                    viewModel.getlookAround(for: location)
                                }
                                Button("Get directions", systemImage: "arrow.triangle.turn.up.right.circle.fill") {
                                    viewModel.GetDirections(to: location)
                                }
                            }
                    }
                    
                    .annotationTitles(.hidden)
                    
                }
                
                UserAnnotation()
                
                if let route = viewModel.route {
                    MapPolyline(route)
                        .stroke(.brandprimary, lineWidth: 8)
                }
            }
            
            .lookAroundViewer(isPresented: $viewModel.showLookAround, initialScene: viewModel.lookAround)
            .tint(.brandSecondary)
            .mapStyle(.standard)
            .mapControls {
                MapCompass()
                MapUserLocationButton()
                MapPitchToggle()
                MapScaleView()
            }
            logoView(frameWidth: 125).shadow(radius: 70)
            
            
            
        }
        .sheet(isPresented: $viewModel.isShowingDetailView) {
            if let selectedLocation = LocationaFactory.selectedLocation {
                NavigationView {
                    LocationDetailView(viewModel: locationDetailViewModel(location: selectedLocation))
                        .toolbar {
                            Button("Dismiss", action:  {viewModel.isShowingDetailView = false }) }
                        
                }
            }
        }

     
       .overlay(alignment: .bottomLeading)  {
           LocationButton(.currentLocation) {
               viewModel.requestAllowOnceLocationPerm()
           }
           .foregroundColor(.white)
           .symbolVariant(.fill)
           .tint(.brandSecondary)
           .labelStyle(.iconOnly)
           .clipShape(Circle())
           .padding(EdgeInsets(top: 0, leading: 20, bottom: 25, trailing: 0))
       }
       .alert(item: $viewModel.alertItem, content: { $0.alert})
            
       .task {
    
            if LocationaFactory.locations.isEmpty{
                viewModel.getLocation(for: LocationaFactory)
            }
        }
    }
}

#Preview {
    locationMapView().environmentObject(locationFactory())
}
