//
//  ContentView.swift
//  SocialLoginSwiftUI
//
//  Created by Rezaul Islam on 8/6/24.
//

import SwiftUI
import AuthenticationServices

struct ContentView: View {
    var body: some View {
        VStack(spacing:16) {
            
            SignInWithAppleButton(.signUp) { request in
                request.requestedScopes = [.fullName, .email]
            } onCompletion: { result in
                switch result {
                case .success(let authorization):
                    if let appleIDCrediential = authorization.credential as? ASAuthorizationAppleIDCredential{
                        let userIdentifier = appleIDCrediential.user
                        let fullName = appleIDCrediential.fullName
                        let email = appleIDCrediential.email
                        
                        print("User: \(userIdentifier) Full Name: \(fullName) Email: \(email)")
                        
                    }
                case .failure(let error):
                    print("Error \(error)")
                    
                }
            }
            .frame(height: 50)

            
            SocialButton(name: "Facebook Login", logo: "f.square", bgColor: .blue){
                print("Clicked")
            }
            
            SocialButton(name: "Google Login", logo: "g.circle", bgColor: .red.opacity(0.7)){
                print("Clicked")
            }
            
             
        }
        .padding(48)
    }
}



#Preview {
    ContentView()
}
