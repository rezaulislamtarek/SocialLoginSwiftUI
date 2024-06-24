//
//  SocialAuthHelper.swift
//  SocialLoginSwiftUI
//
//  Created by Rezaul Islam on 24/6/24.
//

import Foundation
import Firebase
import GoogleSignIn
import FBSDKLoginKit

class SocialAuthHelper : ObservableObject{
    @Published var isLoadingSuccessed = false
    @Published var user: User?
    private var loginManager = LoginManager()
    
    func signInWithGoogle(complited : @escaping (Bool)-> Void ){
        
        guard let clientId = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientId)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: AppUtil.rootViewController){ result, error in
            if error != nil { return }
            guard let user = result?.user, let idToken = user.idToken else { return }
            let accessToken = user.accessToken
            let crediential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
            
            Auth.auth().signIn(with: crediential){ res, error in
                if error != nil {
                    complited(false)
                    return
                }
                guard (res?.user) != nil else {return }
                complited(true)
            }
            
        }
    }
    
    func loginWithFacebook(completion: @escaping (Bool) -> Void) {
            loginManager.logIn(permissions: ["public_profile","email"], from: nil) { result, error in
                if let error = error {
                    print("Failed to login: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
               

                guard let token = AccessToken.current else {
                    print("Failed to get access token")
                    completion(false)
                    return
                }

                let credential = FacebookAuthProvider.credential(withAccessToken: token.tokenString)
                Auth.auth().signIn(with: credential) { result, error in
                    if let error = error {
                        print("Failed to login: \(error.localizedDescription)")
                        completion(false)
                        return
                    }

                    self.user = result?.user
                    print(self.user?.displayName)
                    completion(true)
                }
            }
        }
}


final class AppUtil{
    static var rootViewController : UIViewController{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .init() }
        
        guard let root = screen.windows.first?.rootViewController else { return .init() }
        
        return root
    }
}
