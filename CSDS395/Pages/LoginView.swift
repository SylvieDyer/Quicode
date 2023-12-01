//
//  LoginView.swift
//  CSDS395
//
//  Created by Tran Dac Nguyen Kim on 9/7/23.
//

import SwiftUI
import _AuthenticationServices_SwiftUI
import AuthenticationServices
import CoreData

// log in view
struct LoginView: View {
    var appController: AppController
    var awsManager : AWSManager
    var colorManager = ColorManager()
    
    // new user
    @FetchRequest(
        sortDescriptors: []
    )
    private var users: FetchedResults<User>
    
    
    // apple log in variables
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var moc
    
    var authenticationSuccess: () -> Void
    
    var body: some View {
        ZStack{
            colorManager.getLightGreen().ignoresSafeArea(.all, edges: .all)
            VStack{
                Spacer()
                Text("Welcome to").font(.title2).bold()
                
                Text("QUICODE")
                    .font(.largeTitle).bold()
                    .fontWidth(.expanded)
                    .font(.callout)
                Spacer()
                
                Text("Login to get started!")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                // sign in with apple auth
                
                // for the button appearance
                if colorScheme.self == .dark {
                    SignInButton(SignInWithAppleButton.Style.whiteOutline)
                }
                else {
                    SignInButton(SignInWithAppleButton.Style.black)
                }
                
                Spacer()
                Spacer()
            }
        }
    }
    
    // for sign in with apple
    func SignInButton(_ type: SignInWithAppleButton.Style) -> some View{
        return SignInWithAppleButton(.signIn) { request in
            request.requestedScopes = [.fullName, .email]
        } onCompletion: { result in
            switch result {
            case .success(let authResults):
                print("Authorization successful \(authResults)")
                // creates the user object
                let user = CreateUser(authResults: authResults)
                Task{
                    await uploadUser(user: user)
                }
//                appController.setAsHome()
                authenticationSuccess()
            case .failure(let error):
                print("Authorisation failed: \(error.localizedDescription)")
                
            }
        }
        .frame(width: 280, height: 60, alignment: .center)
        .signInWithAppleButtonStyle(type)
    }
    
    
    
    // to create the user and store with core data
    func CreateUser(authResults: ASAuthorization) -> Users{
//        let user = User(context: viewContext)
        var user: Users? = nil
        let defaults = UserDefaults.standard
        switch authResults.credential {
        case let appleIdCredential as ASAuthorizationAppleIDCredential:
            print("FULL NAME")
            print(appleIdCredential.fullName!)
            // appleIdCredential.user if the user's Sign In with Apple Credential Remains stable
            print("USER")
            print(appleIdCredential.user)
            // create new user object
            print("EMAIL")
            print(appleIdCredential.email ?? "NO EMAIL GIVEN")
                            
            if appleIdCredential.email != nil{
                defaults.set(appleIdCredential.email, forKey: "email")
            }
            
            if appleIdCredential.fullName?.givenName != nil{
                defaults.set(appleIdCredential.fullName?.givenName, forKey: "firstname")
            }
            
            if appleIdCredential.fullName?.familyName != nil{
                defaults.set(appleIdCredential.fullName?.familyName, forKey: "lastname")
            }
            
            
            let newUser = false
            let isLoggedOut = false
            let email = appleIdCredential.email ?? defaults.string(forKey: "email")
            let firstName = appleIdCredential.fullName?.givenName ?? defaults.string(forKey: "firstname")
            let lastName = appleIdCredential.fullName?.familyName ?? defaults.string(forKey: "lastname")
            let appid = appleIdCredential.user
            
            user = Users(
                id: appid,
                email: email!,
                firstname: firstName!,
                lastname: lastName!,
                newUser: newUser,
                isLoggedOut: isLoggedOut
            )
            return user!
            
        default:
            break
        }
        return user!
    }
    
    func uploadUser(user: Users) async {
        let email = user.email
        let firstname = user.firstname
        let lastname = user.lastname
        let id = user.id
        print("id: \(id)")
        let userJson = Users(id: id, email: email, firstname: firstname, lastname: lastname, newUser: user.newUser, isLoggedOut: user.isLoggedOut)
        
        do {
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = .prettyPrinted
            let jsonData = try jsonEncoder.encode(userJson)
            await awsManager.uploadToAWS(filename: "\(user.id).json", body: jsonData)
            print("after await")
        }
        catch {
            print("cannot upload user")
        }
        print("leaving uploadUser")
    }
    
}
//
//// to navigate signing in with APPLE
//struct SignInWithAppleSwiftUIButton: View {
//
//
//    var viewContext: NSManagedObjectContext
//
//    @FetchRequest(sortDescriptors: []) var users: FetchedResults<User>
//
//    var body: some View {
//
//
//    }
//
//
//}
