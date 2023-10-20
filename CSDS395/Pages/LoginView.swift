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
    @ObservedObject var appController: AppController
    var awsManager : AWSManager = AWSManager()
    var viewContext: NSManagedObjectContext

    // new user
    @FetchRequest(
        sortDescriptors: []
    )
    private var users: FetchedResults<User>
 
    
    // apple log in variables
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var moc
    
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
                // for the button appearance
                if colorScheme.self == .dark {
                    SignInButton(SignInWithAppleButton.Style.whiteOutline)
                }
                else {
                    SignInButton(SignInWithAppleButton.Style.black)
                }
                Spacer()
            }
        }
    }
    
    // for sign in with Apple
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
        switch authResults.credential {
        case let appleIdCredential as ASAuthorizationAppleIDCredential:
            print("FULL NAME")
            print(appleIdCredential.fullName!)
            // create new user object
            user.newUser = false
            user.email = appleIdCredential.email ?? "NO EMAIL GIVEN"
            user.firstName = appleIdCredential.fullName?.givenName ?? "ERROR: NO NAME GIVEN"
            user.lastName = appleIdCredential.fullName?.familyName ?? "ERROR: NO NAME GIVEN"
            user.id = UUID()        // TODO: dont want to recreate everytime user logs in though ... TBD
            

            // try to save with core data
            do {
                try viewContext.save()
            } catch {
                // TODO: Replace this implementation with code to handle the error appropriately.
               
                let nsError = error as NSError
                // fatalError() will crash app
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
        
        case let passwordCredential as ASPasswordCredential:
            print("\n ** ASPasswordCredential ** \n")
            print(passwordCredential.user)  // This is a user identifier
            print(passwordCredential.password) //The password
            break
            
        default:
            break
        }
        
        return user
    }
    
    func uploadUser(user: User) async {
        let email = user.email!
        let firstname = user.firstName!
        let lastname = user.lastName!
        let id = user.id
        let userJson = Users(id: id!, email: email, firstname: firstname, lastname: lastname)
        
        do {
//            let client = awsManager.initAWS()
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = .prettyPrinted
            let jsonData = try jsonEncoder.encode(userJson)
            await awsManager.uploadToAWS(filename: "\(user.id!).json", body: jsonData)
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



//
//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        IsLoginView()
//    }
//}
