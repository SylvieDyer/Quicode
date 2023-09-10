//
//  LoginView.swift
//  CSDS395
//
//  Created by Tran Dac Nguyen Kim on 9/7/23.
//

import SwiftUI
import _AuthenticationServices_SwiftUI
import AuthenticationServices

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
                PrintResults(authResults: authResults)
            case .failure(let error):
                print("Authorisation failed: \(error.localizedDescription)")
            }
        }
        .frame(width: 280, height: 60, alignment: .center)
        .signInWithAppleButtonStyle(type)
    }
    
    func PrintResults(authResults: ASAuthorization) -> Void{
        switch authResults.credential {
        case let appleIdCredential as ASAuthorizationAppleIDCredential:
            //these will only be printed the first time user login
            print(appleIdCredential.email ?? "Email not available.")
            print(appleIdCredential.fullName?.givenName ?? "givenName not available")
            print(appleIdCredential.fullName?.familyName ?? "Familyname not available")
            //this will be printed everytime the user login
            print("user " + appleIdCredential.user)  // This is a user identifier
        case let passwordCredential as ASPasswordCredential:
            print("\n ** ASPasswordCredential ** \n")
            print(passwordCredential.user)  // This is a user identifier
            print(passwordCredential.password) //The password
            break
            
        default:
            break
        }
    }
}

struct LoginView: View {
    @State var res: String = ""
    
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
            
            // sign in with apple auth
            VStack(alignment: .center, spacing: 15){
                SignInWithAppleSwiftUIButton()
                
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

//                switch authResults.credential {
//                case let appleIdCredential as ASAuthorizationAppleIDCredential:
//                    let email = appleIdCredential.email
//                    let givenName = appleIdCredential.fullName?.givenName
//                    let familyName = appleIdCredential.fullName?.familyName
//                    let userIdentifier = appleIdCredential.user  // This is a user identifier
//                    print("email" + email + "givenname" + givenName + "familyname" + familyName + "userIdent" + userIdentifier)

//TODO:
//                case let passwordCredential as ASPasswordCredential:
//                    let user = (passwordCredential.user)  // This is a user identifier
//                    let password = (passwordCredential.password) //The password
//                    DispatchQueue.main.async {
//                        self.showPasswordCredentialAlert(username: user, password: password)
//                    }
