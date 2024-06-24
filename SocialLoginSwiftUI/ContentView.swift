//
//  ContentView.swift
//  SocialLoginSwiftUI
//
//  Created by Rezaul Islam on 8/6/24.
//

import SwiftUI
import AuthenticationServices

struct ContentView: View {
    @State var authStatus : Bool = false
    @StateObject var authHelper = SocialAuthHelper()
    var body: some View {
        VStack(spacing:16) {
            Spacer()
            SignInWithAppleButtonView { authStatus in
                self.authStatus = authStatus
            }

            
            SocialButton(name: "Facebook Login", logo: "f.square", bgColor: .blue){
                authHelper.loginWithFacebook { authStatus in
                    self.authStatus = authStatus
                }
            }
            
            SocialButton(name: "Google Login", logo: "g.circle", bgColor: .red.opacity(0.7)){
                authHelper.signInWithGoogle { authStatus in
                    self.authStatus = authStatus
                }
            }
            Spacer()
            Text(authStatus ? "Auth Status: \(authStatus.description)" : "")
             
        }
        .padding(48)
    }
}



#Preview {
    ContentView()
}
