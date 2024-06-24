//
//  SocialLoginSwiftUIApp.swift
//  SocialLoginSwiftUI
//
//  Created by Rezaul Islam on 8/6/24.
//

import SwiftUI
import FacebookCore


@main
struct SocialLoginSwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { (url) in
                    
                    let _ = ApplicationDelegate.shared.application(
                        UIApplication.shared,
                        open: url,
                        sourceApplication: nil,
                        annotation: [UIApplication.OpenURLOptionsKey.annotation])
                }
        }
    }
}









