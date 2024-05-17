//
//  addBathroomView.swift
//  OneAndDoneApplication
//
//  Created by Avi Maslow on 2/26/24.
//
import SwiftUI
import MessageUI

struct AddLocationView: View {
    @State private var name = ""
    @State private var description = ""
    @State private var address = ""
    @State private var latitude: Double = 0
    @State private var longitude: Double = 0
    @State private var websiteURL = ""
    @State private var phoneNum = ""

    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var emailSent = false
    @State private var isShowingMailView = false

    var mailViewParams: MailViewParams {
        MailViewParams(name: name, description: description, address: address, websiteURL: websiteURL, phoneNum: phoneNum)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Location Details")) {
                    TextField("Name", text: $name)
                    TextField("Description", text: $description)
                    TextField("Address", text: $address)
                }

                Section(header: Text("Contact Information")) {
                    TextField("Website URL", text: $websiteURL)
                    TextField("Phone Number", text: $phoneNum)
                }

                Section {
                    Button("Submit") {
                        submitForm()
                    }
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(emailSent ? "Email Sent" : "Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .navigationTitle("Add Location")
        }
        .sheet(isPresented: $isShowingMailView) {
            mailView(emailSent: $emailSent, alertMessage: $alertMessage, mailViewParams: mailViewParams)
                .edgesIgnoringSafeArea(.all)
        }
    }

    private func submitForm() {
        guard MFMailComposeViewController.canSendMail() else {
            alertMessage = "Your device doesn't support email sending."
            showingAlert = true
            return
        }

        isShowingMailView = true
    }
}

struct AddLocationView_Previews: PreviewProvider {
    static var previews: some View {
        AddLocationView()
    }
}

struct MailViewParams {
    let name: String
    let description: String
    let address: String
    let websiteURL: String
    let phoneNum: String
}


    struct mailView: UIViewControllerRepresentable {
        @Binding var emailSent: Bool
        @Binding var alertMessage: String
        let mailViewParams: MailViewParams

        func makeUIViewController(context: Context) -> MFMailComposeViewController {
            let viewController = MFMailComposeViewController()
            viewController.mailComposeDelegate = context.coordinator
            viewController.setToRecipients(["oneanddonehelp@gmail.com"]) // Set your recipient email address
            viewController.setSubject("New Location Submission")

            let body = """
            Name: \(mailViewParams.name)
            Description: \(mailViewParams.description)
            Address: \(mailViewParams.address)
            Website URL: \(mailViewParams.websiteURL)
            Phone Number: \(mailViewParams.phoneNum)
            """

            viewController.setMessageBody(body, isHTML: false)

            return viewController
        }

        func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {
            // Update the view controller if needed
        }

        func makeCoordinator() -> Coordinator {
            Coordinator(emailSent: $emailSent, alertMessage: $alertMessage)
        }

        class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
            @Binding var emailSent: Bool
            @Binding var alertMessage: String

            init(emailSent: Binding<Bool>, alertMessage: Binding<String>) {
                _emailSent = emailSent
                _alertMessage = alertMessage
            }

            func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
                if let _ = error {
                    alertMessage = "Email failed to send. Please try again."
                } else {
                    switch result {
                    case .cancelled:
                        alertMessage = "Email was cancelled."
                    case .failed:
                        alertMessage = "Failed to send email."
                    case .sent:
                        alertMessage = "Email sent successfully! Thank you for your submission."
                        emailSent = true
                    case .saved:
                        alertMessage = "Email saved successfully."
                    @unknown default:
                        break
                    }
                }
                controller.dismiss(animated: true)
            }
        }
    }

    struct MailView_Previews: PreviewProvider {
        static var previews: some View {
            mailView(emailSent: .constant(false), alertMessage: .constant(""), mailViewParams: MailViewParams(name: "", description: "", address: "", websiteURL: "", phoneNum: ""))
        }
    }

