//
//  loadingLocationView.swift
//  OneAndDoneApplication
//
//  Created by Avi Maslow on 2/23/24.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var isLoading: Bool


    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()

            VStack {
                Spacer()

                Text("Sorry for the Maintenance")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()

                Text("The app needs some time to load restroom locations. Please be patient and hold on until the locations are loaded.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding()

                Spacer()

                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .brandPrimary))
                        .scaleEffect(2)
                        .padding()
                        .onAppear {
                            // Use a timer to hide the loading screen after 10 seconds
                            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                                isLoading = false
                            }
                        }
                }

                Button("Dismiss") {
                    isLoading = false
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.brandPrimary)
                .cornerRadius(10)
            }
        }
        .opacity(isLoading ? 1 : 0)
       
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(isLoading: .constant(true))
    }
}
