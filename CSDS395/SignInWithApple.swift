//
//  SignInWithApple.swift
//  CSDS395
//
//  Created by Helio Dong on 9/9/23.
//

import SwiftUI
import AuthenticationServices

// 1 You subclass UIViewRepresentable when you need to wrap a UIView.
final class SignInWithApple: UIViewRepresentable {
  // 2 makeUIView should always return a specific type of UIView.
  func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
    // 3Since you’re not performing any customization, you return the Sign In with Apple object directly.
    return ASAuthorizationAppleIDButton()
  }
  
  // 4Since the view’s state never changes, leave an empty implementation.
  func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
  }
}
