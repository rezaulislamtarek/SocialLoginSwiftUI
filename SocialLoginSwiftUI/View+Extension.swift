//
//  View+Extension.swift
//  SocialLoginSwiftUI
//
//  Created by Rezaul Islam on 8/6/24.
//
 
import SwiftUI

extension View{
    func SocialButton(name: String, logo : String, bgColor: Color, action : @escaping ()->Void ) -> some View{
        Button(action: action, label: {
            HStack{
                Image(systemName: logo)
                Text(name)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .foregroundColor(.white)
            .padding(.horizontal)
            .padding(.vertical,12)
            .background(
                RoundedRectangle(cornerRadius: 4.0, style: .continuous)
                    .fill(bgColor)
            )
        })
    }
}
