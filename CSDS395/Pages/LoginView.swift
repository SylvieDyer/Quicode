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
    var viewContext: NSManagedObjectContext
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
                CreateUser(authResults: authResults)
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
    func CreateUser(authResults: ASAuthorization) -> User{
        let user = User(context: viewContext)
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
            
            let defaults = UserDefaults.standard
                            
            if appleIdCredential.email != nil{
                defaults.set(appleIdCredential.email, forKey: "email")
            }
            
            if appleIdCredential.fullName?.givenName != nil{
                defaults.set(appleIdCredential.fullName?.givenName, forKey: "firstname")
            }
            
            if appleIdCredential.fullName?.familyName != nil{
                defaults.set(appleIdCredential.fullName?.familyName, forKey: "lastname")
            }
            
            print("users is empty")
            user.newUser = false
            user.isLoggedOut = false
            user.email = appleIdCredential.email ?? UserDefaults.standard.string(forKey: "email")
            user.firstName = appleIdCredential.fullName?.givenName ?? UserDefaults.standard.string(forKey: "firstname")
            user.lastName = appleIdCredential.fullName?.familyName ?? UserDefaults.standard.string(forKey: "lastname")
            user.appid = appleIdCredential.user
            
//            if users.isEmpty {
//                
////                user.id = UUID()
//            }
//            else {
//                print("users not empty")
//                // check if user is already in core data by comparing appid
//                if user.appid != users.first!.appid {
//                    RemoveUser() // we only allow one user in core data, so if a new appid is detected, the old user in core data should be deleted
//                    user.newUser = false
//                    user.isLoggedOut = false
//                    user.email = appleIdCredential.email ?? UserDefaults.standard.string(forKey: "email")
//                    user.firstName = appleIdCredential.fullName?.givenName ?? UserDefaults.standard.string(forKey: "firstname")
//                    user.lastName = appleIdCredential.fullName?.familyName ?? UserDefaults.standard.string(forKey: "lastname")
//                    user.appid = appleIdCredential.user
////                    user.id = UUID()        // TODO: dont want to recreate everytime user logs in though ... TBD
//                }
//                else {
//                    users.first!.isLoggedOut = false
//                }
//            }
            // try to save with core data
//            do {
//                try viewContext.save()
//            } catch {
//                // TODO: Replace this implementation with code to handle the error appropriately.
//                
//                let nsError = error as NSError
//                // fatalError() will crash app
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
            
            
        case let passwordCredential as ASPasswordCredential:
            print("\n ** ASPasswordCredential ** \n")
            print(passwordCredential.user)  // This is a user identifier
            print(passwordCredential.password) //The password
            break
            
        default:
            break
        }
        print(users)
        return user
    }
    
    func uploadUser(user: User) async {
        let email = user.email!
        let firstname = user.firstName!
        let lastname = user.lastName!
        let id = user.appid
        print("id: \(id!)")
        let userJson = Users(id: id!, email: email, firstname: firstname, lastname: lastname)
        
        do {
            //            let client = awsManager.initAWS()
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = .prettyPrinted
            let jsonData = try jsonEncoder.encode(userJson)
            await awsManager.uploadToAWS(filename: "\(user.appid!).json", body: jsonData)
            print("after await")
        }
        catch {
            print("cannot upload user")
        }
        print("leaving uploadUser")
    }
    
    func RemoveUser() -> Void {
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try viewContext.execute(deleteRequest)
            try viewContext.save()
        } catch {
            print ("There was an error")
        }
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
