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
        RoundedRectangle(cornerRadius: 25.0, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
            .stroke(.black, lineWidth: 1)
            .frame(height: 44)
             
            .overlay(alignment:.center) {
                SignInWithAppleButton(.continue) { request in
                    request.requestedScopes = [.fullName, .email]
                } onCompletion: { result in
                    switch result {
                    case .success(let authorization):
                        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                            let user = appleIDCredential.user
                            let fullName = appleIDCredential.fullName
                            let email = appleIDCredential.email
                             
                            res(true)
                        }
                    case .failure(let error):
                        print("Error \(error)")
                        res(false)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .signInWithAppleButtonStyle(.white)
                //.buttonStyle(PlainButtonStyle())
                .font(Font.custom("Lovelo_Black", size: 22))
                .frame(height: 44)
            }
    }
}

#Preview {
    SignInWithAppleButtonView(res: {_ in })
}
