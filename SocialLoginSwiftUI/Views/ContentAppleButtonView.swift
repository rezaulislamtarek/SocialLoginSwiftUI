//
//  SigninWithAppleCustomButton.swift
//  SocialLoginSwiftUI
//
//  Created by Rezaul Islam on 27/6/24.
//

import SwiftUI
import Foundation
import FirebaseAuth
import AuthenticationServices
import CryptoKit




struct ContentAppleButtonView: View {
    @StateObject var viewModel = SignInWithAppleViewModel()
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            
            CustomSignInWithAppleButton {
                viewModel.handleAppleSignIn()
            }
            
            Spacer()
            
            Text("Auth Status: \(viewModel.authStatus.description)")
        }
        .padding(48)
    }
}

#Preview {
    ContentAppleButtonView()
}


struct CustomSignInWithAppleButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            HStack {
                Image(systemName: "applelogo")
                    .font(.headline)
                Text("Sign in with Apple")
                    .font(.headline)
                    .bold()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .frame(height: 50)
    }
}


class SignInWithAppleViewModel: NSObject, ObservableObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    @Published var authStatus: Bool = false
    
    func handleAppleSignIn() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let user = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            print("User: \(user) Full Name: \(String(describing: fullName)) Email: \(String(describing: email))")
            authStatus = true
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Authorization failed: \(error.localizedDescription)")
        authStatus = false
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.windows.first!
    }
}
