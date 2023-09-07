//
//  LoginView.swift
//  CSDS395
//
//  Created by Tran Dac Nguyen Kim on 9/7/23.
//

import SwiftUI

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
            
            VStack(alignment: .center){
                
                Text("Login")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 12)
                    .padding(.top, 30)
            }
            
            // username and password fields
            VStack(alignment: .center, spacing: 15){
                HStack{
                    TextField("", text: $username, prompt: Text("username").foregroundColor(.gray))
                        .frame(height: 40)
                        .padding(5)
                        .foregroundColor(.black)
                        .overlay{
                            (RoundedRectangle(cornerRadius: 10))
                            .stroke(Color.black, lineWidth: 1)
                            .background(Color.white)
                        }
                        .padding(.horizontal)
                }
                
                HStack{
                    TextField("", text: $password, prompt: Text("password").foregroundColor(.gray))
                        .frame(height: 40)
                        .foregroundColor(.black)
                        .padding(5)
                        .overlay{
                            (RoundedRectangle(cornerRadius: 10))
                            .stroke(Color.black, lineWidth: 1)
                            .background(Color.white)
                        }
                        .padding(.horizontal)
                }
                
                Spacer()
            }
            
            Spacer()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
