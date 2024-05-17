//
//  LocationDetailView.swift
//  OneAndDoneApplication
//
//  Created by Avi Maslow on 1/13/24.
//

import SwiftUI
import MessageUI
struct LocationDetailView: View {
    
    @Bindable var viewModel: locationDetailViewModel
    @Environment(\.sizeCategory) var sizeCategory
    @State private var isShowingMailView = false
    // @Environment(\.requestReview) var requestReview
    // @State private var tapRequest = 0
    var body: some View {
        ScrollView(showsIndicators: false) {
          
                VStack(spacing: 0) {
                    BannerImageView(image: viewModel.location.bannerImage)
                        .frame(height: 100)
                    
                    VStack(spacing: 16) {
                        AddressHStack(address: viewModel.location.address)
                            .padding(.horizontal)
                            .padding(.horizontal)
                            .padding(.horizontal)
                        DescriptionView(text: viewModel.location.description)
                            .padding(.horizontal)
                            .padding(.horizontal)
                            .padding()
                        ActionButtonHStack(viewModel: viewModel)
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                  
                }
                
                VStack {
                    Spacer()
                    HStack {
                        ForEach(0..<7) { _ in
                            Image(systemName: "toilet")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 22, height: 22)
                                .padding()
                                .foregroundColor(.brandPrimary)
                        }
                    }
                    
                    Text("Code required usually means the code will be on the receipt. If the information is not up to date, or you think something is important to note, please don't hesitate to send us an email!")
                         .minimumScaleFactor(0.75)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal)
                        .padding(.horizontal)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.gray.opacity(0.1))
                                .padding()
                        )
                        .padding()
                    
                    Button(action: {
                        isShowingMailView.toggle()
                    }) {
                        Label("Send Email", systemImage: "paperplane.fill")
                            .font(.headline)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    .sheet(isPresented: $isShowingMailView) {
                        MailView(isShowing: $isShowingMailView)
                    }
                    .padding()
                    Button(action: {
                           // Open Instagram
                           if let instagramURL = URL(string: "https://www.instagram.com/aviwilldoit?igsh=MTIxb2t4ZWhqNXB3eg%3D%3D&utm_source=qr") {
                               if UIApplication.shared.canOpenURL(instagramURL) {
                                   UIApplication.shared.open(instagramURL)
                               } else {
                                   // Handle if Instagram app is not installed
                                   // You can open the Instagram website or show an alert
                                   print("Instagram app not installed.")
                               }
                           }
                       }) {
                           Label("Reach us on Instagram", systemImage: "camera.fill")
                               .font(.headline)
                               .padding()
                               .foregroundColor(.white)
                               .background(Color.blue)
                               .cornerRadius(8)
                       }
                       .padding()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle(viewModel.location.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    




  struct LocationDetailView_Previews: PreviewProvider {
      static var previews: some View {
          NavigationView {
              LocationDetailView(viewModel: locationDetailViewModel(location: OneandDoneLocations(record: mockData.location)))
          }
      }
  }
      
      
      fileprivate struct BannerImageView: View {
          
          var image: UIImage
          
          var body: some View {
              Image(uiImage: image)
                  .resizable()
                  .scaledToFill()
                  .frame(height: 100)
                  .accessibilityHidden(true)
          }
      }
      
      
      fileprivate struct AddressHStack: View {
          
          var address: String
          
          var body: some View {
              HStack {
                  
                  Label(address, systemImage: "mappin.and.ellipse")
                  
                      .font(.caption)
                      .foregroundColor(.black)
                  
                  Spacer()
              }
              .padding(.horizontal)
          }
      }
      
      
      fileprivate struct DescriptionView: View {
          
          var text: String
          
          var body: some View {
              Text(text)
                  .minimumScaleFactor(0.75)
                  .fixedSize(horizontal: false, vertical: true)
                  .padding(.horizontal)
          }
      }
fileprivate struct ActionButtonHStack: View {
       
    var viewModel: locationDetailViewModel
       
       var body: some View {
           HStack(spacing: 20) {
               Button {
                   viewModel.getDirectionsToLocation()
               } label: {
                   locationActionButton(color: .brandPrimary, imageName: "location.fill")
                   
               }
               .accessibilityLabel(Text("Get directions"))
               
               Link(destination: URL(string: viewModel.location.websiteURL)!, label: {
                   locationActionButton(color: .brandPrimary, imageName: "network")
               })
               .accessibilityRemoveTraits(.isButton)
               .accessibilityLabel(Text("Go to website"))
               
               Button {
                   viewModel.callLocation()
               } label: {
                   locationActionButton(color: .brandPrimary, imageName: "phone.fill")
               }
               .accessibilityLabel(Text("Call location"))
               
           }
           .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
           .background(Color(.secondarySystemBackground))
           .clipShape(Capsule())
       }
   }

fileprivate struct locationActionButton: View {
       
       var color: Color
       var imageName: String
       
       var body: some View {
           ZStack {
               Circle()
                   .foregroundColor(color)
                   .frame(width: 60, height: 60)
               
               Image(systemName: imageName)
                   .resizable()
                   .scaledToFit()
                   .foregroundColor(.white)
                   .frame(width: 22, height: 22)
               
           }
       }
   }

fileprivate struct FullScreenBlackTransparencyView: View {
       
       var body: some View {
           Color(.black)
               .ignoresSafeArea()
               .opacity(0.9)
               .transition(AnyTransition.opacity.animation(.easeOut(duration: 0.35)))
               .zIndex(1)
               .accessibilityHidden(true)
       }
   }

struct MailView: UIViewControllerRepresentable {
   @Binding var isShowing: Bool

   func makeUIViewController(context: Context) -> MFMailComposeViewController {
       let viewController = MFMailComposeViewController()
       viewController.mailComposeDelegate = context.coordinator
       viewController.setToRecipients(["oneanddonehelp@gmail.com"]) // Set your recipient email address
       viewController.setSubject("Feedback from the App / Location Update")
       
       // Customize the email body with the specified content
       let emailBody = """
           Restroom location:
           Does the restroom require a code:
           If so, what's the new code:
           """
       viewController.setMessageBody(emailBody, isHTML: false)
       
       return viewController
   }

   func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}

   func makeCoordinator() -> Coordinator {
       return Coordinator(isShowing: $isShowing)
   }

   class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
       @Binding var isShowing: Bool

       init(isShowing: Binding<Bool>) {
           _isShowing = isShowing
       }

       func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
           isShowing = false
       }
   }
}
