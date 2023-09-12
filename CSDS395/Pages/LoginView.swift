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
    @Binding var isLogin : Bool
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
                CreateUser(authResults: authResults)
                isLogin = true
            case .failure(let error):
                print("Authorisation failed: \(error.localizedDescription)")
                isLogin = false
            }
        }
        .frame(width: 280, height: 60, alignment: .center)
        .signInWithAppleButtonStyle(type)
    }
    
    func CreateUser(authResults: ASAuthorization) -> Void{
        switch authResults.credential {
        case let appleIdCredential as ASAuthorizationAppleIDCredential:
            //these will only be printed the first time user login
            let userEmail = appleIdCredential.email ?? "Email not available."
            let userLastName = appleIdCredential.fullName?.familyName ?? "Familyname not available"
            let userFirstName = appleIdCredential.fullName?.givenName ?? "GivenName not available"
            let user = User(id: appleIdCredential.user, email: userEmail , lastname: userLastName , firstname: userFirstName)
            print(user)
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
    @Binding var isLogin : Bool
    
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
                SignInWithAppleSwiftUIButton(isLogin : $isLogin)
                Spacer()
            }
        }
    }
}

struct IsLoginView : View{
    @State var isLogin = false
    
    var body : some View{
        HStack{
            if (isLogin){
                NavigationView {
                    HomeView(controller: AppController())
                }
                
            }
            else{
                LoginView(isLogin : $isLogin)
            }
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        IsLoginView()
    }
}
