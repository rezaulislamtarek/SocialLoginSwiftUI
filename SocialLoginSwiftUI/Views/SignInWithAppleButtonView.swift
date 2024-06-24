//
//  SignInWithAppleButtonView.swift
//  SocialLoginSwiftUI
//
//  Created by Rezaul Islam on 24/6/24.
//

import SwiftUI
import AuthenticationServices

struct SignInWithAppleButtonView: View {
    var res : (Bool)-> Void
    var body: some View {
        SignInWithAppleButton(.signUp) { request in
            request.requestedScopes = [.fullName, .email]
        } onCompletion: { result in
            switch result {
            case .success(let authorization):
                if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                    _ = appleIDCredential.user
                    _ = appleIDCredential.fullName
                    _ = appleIDCredential.email
                    res(true)
                }
            case .failure(let error):
                print("Error \(error)")
                res(false)
            }
        }
        .frame(height: 50)
    }
}

#Preview {
    SignInWithAppleButtonView(res: {_ in })
}
