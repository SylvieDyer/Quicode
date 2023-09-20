//
//  HomeView.swift
//  CSDS395
//
//  Created by Sylvie Dyer on 9/1/23.
//

import SwiftUI
import CoreData

struct HomeView: View {
    // stores module names
    @ObservedObject var controller: AppController
    
//    var viewContext: NSManagedObjectContext
    var user : User
   
    
    var body: some View {
        // wraps app in navigation to switch to user-screen
        NavigationView{
            VStack {
                
                // header
                HStack(alignment: .lastTextBaseline, spacing:0){
                    Text("QUICCODE").font(.largeTitle).bold().padding(.leading, 15)
                        .fontWidth(.expanded)
                        .font(.callout)
                    Spacer()
                    
                    /// commented out for now... will be log out button in UserPage?
                    // sign in with apple page
                    /*
                                        NavigationLink {
                                            IsLoginView()
                                        } label: {
                                            Image(systemName: "arrow.down.left.circle.fill").foregroundColor(.gray).padding(25)
                     */
                    
                    // user page navigation
                    NavigationLink {
                        UserView(controller: controller, user: user).navigationBarBackButtonHidden(true)
                    } label: {
                        Image(systemName: "person").foregroundColor(.gray).padding(25)
                    }
                }
                
                // section to replace when navigating btwn modules
                NavigationStack{
                    List{
                        // welcome section
                        Section{
                            // will be dynamic with user name -- Text("Welcome Back, \(user.name)
                            Text("Welcome Back, \(user.firstName ?? "User")").bold().font(.title2)
                            
                        }
                        .listRowBackground(
                            Capsule()
                                .fill(Color.init(hex: "93BEA4"))
                        )
                        
                        // "quick code" section
                        Section{
                            HStack{ // to center text
                                Spacer()
                                NavigationLink{
                                    ModuleView(name: "Quick Lesson", controller: controller)
                                } label: {
                                    VStack{
                                        Text("Today's Quick Lesson:") .foregroundColor(.cyan.opacity(0.7)).font(.title2).fontWeight(.heavy)
                                        Text("Common Mistakes") .foregroundColor(.red.opacity(0.7)).font(.title3).fontWeight(.heavy)
                                    }
                                }
                                .padding(20)
                                Spacer()
                            }
                        }
                        
                        
                        // iterate through list of modules
                        ForEach(controller.getModuleNames(), id: \.self) { moduleName in
                            Section{
                                // individual module
                                NavigationLink(){
                                    ModuleView(name: moduleName, controller: controller)
                                } label: {
                                    VStack{
                                        Text(moduleName).padding(.top, 10)
                                        Spacer()
                                        // progress Bar
                                        HStack{
                                            Spacer()
                                            ForEach(controller.getBlocks(name: moduleName), id: \.self) { blockName in
                                                // TODO: Connect with user-status
                                                // if blockName associated with complete , "star.fill"
                                                Image(systemName: "star").foregroundColor(.black)
                                            }
                                            Spacer()
                                        }
                                    }
                                }
                                .foregroundColor(.black).font(.title3).fontWeight(.heavy)
                                .padding([.bottom], 30)
                            }
                            
                        }
                        .listRowBackground(
                            RoundedRectangle(cornerRadius: 40)
                                .fill(Color.init(hex: "#B2D4AB"))
                        ) // color each list section
                        
                    }.listStyle(InsetGroupedListStyle()) // (remove drop down option for list sectoins)
                }
            }
        }
        
    }
    
    /// attempt to work around the preview issue... 
//    struct TestUser {
//        var firstName = "HELLO"
//        var lastName = "BYE"
//        var email = "hi@gmail.com"
//    }
}



// TODO: may want to move elsewhere
// to allow for custon hex-code colors
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}


// TODO: can't preview home - will need a workaround or simulator to view
//struct HomeView_Previews: PreviewProvider {
//
//    // for core data
////    let userDataController = UserDataController.shared
//
//    static var previews: some View {
//        // for core data
//        let userDataController = UserDataController.shared
//        // preview enter in MainView
//        MainView(appController: AppController())
//            .environment(\.managedObjectContext, userDataController.container.viewContext)
//
//    }
//}
