//
//  LoginView.swift
//  CSDS395
//
//  Created by Tran Dac Nguyen Kim on 9/7/23.
//

import SwiftUI
import _AuthenticationServices_SwiftUI

struct SignInWithAppleSwiftUIButton: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
      if colorScheme.self == .dark {
          SignInButton(SignInWithAppleButton.Style.whiteOutline)
      }
      else {
          SignInButton(SignInWithAppleButton.Style.black)
      }
    }

    func SignInButton(_ type: SignInWithAppleButton.Style) -> some View{
        return SignInWithAppleButton(.signIn) { request in
            request.requestedScopes = [.fullName, .email]
        } onCompletion: { result in
            switch result {
            case .success(let authResults):
                print("Authorisation successful \(authResults)")
            case .failure(let error):
                print("Authorisation failed: \(error.localizedDescription)")
            }
        }
        .frame(width: 280, height: 60, alignment: .center)
        .signInWithAppleButtonStyle(type)
    }
}

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    
    
    var body: some View {
        VStack{
            HStack(alignment: .top, spacing: 0) {
                Text("QUICCODE")
                    .font(.largeTitle).bold().padding(.leading, 15)
                    .fontWidth(.expanded)
                    .font(.callout)
                Spacer()
            }
            
            Spacer()
            
            VStack(alignment: .center, spacing: 15){
                
                Text("Login")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 12)
                    .padding(.top, 30)
    
            }

            // username and password fields (commednted out)
            // sign in with apple auth
            VStack(alignment: .center, spacing: 15){
                    SignInWithAppleSwiftUIButton()
                
//                HStack{
//                    TextField("", text: $username, prompt: Text("username").foregroundColor(.gray))
//                        .frame(height: 40)
//                        .padding(5)
//                        .foregroundColor(.black)
//                        .overlay{
//                            (RoundedRectangle(cornerRadius: 10))
//                            .stroke(Color.black, lineWidth: 1)
//                            .background(Color.white)
//                        }
//                        .padding(.horizontal)
//                }
//
//                HStack{
//                    TextField("", text: $password, prompt: Text("password").foregroundColor(.gray))
//                        .frame(height: 40)
//                        .foregroundColor(.black)
//                        .padding(5)
//                        .overlay{
//                            (RoundedRectangle(cornerRadius: 10))
//                            .stroke(Color.black, lineWidth: 1)
//                            .background(Color.white)
//                        }
//                        .padding(.horizontal)
//                }
                Spacer()
            }
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
        
    }
}
