//
//  SignInWithEmailView.swift
//  Signin With Apple
//
//  Created by Stewart Lynch on 2020-03-19.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import SwiftUI

struct SignInWithEmailView: View {
    @EnvironmentObject var userInfo: UserInfo
    @State var user: UserViewModel = UserViewModel()
    @State private var showAlert = false
    @State private var authError:EmailAuthError?
    @State private var errString:String = ""
    @Binding var showSheet: Bool
    @Binding var action:LoginView.Action?
    var body: some View {
        VStack {
            TextField("Email Address",
                      text: self.$user.email)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
            SecureField("Password", text: $user.password)
            HStack {
                Spacer()
                Button(action: {
                    self.action = .resetPW
                    self.showSheet = true
                }) {
                    Text("Forgot Password")
                }
            }.padding(.bottom)
            VStack(spacing: 10) {
                Button(action: {
                    FBAuth.authenticate(withEmail: self.user.email, password: self.user.password) { (result) in
                        switch result {
                        case .failure(let error):
                            self.authError = error
                            self.showAlert = true
                        case .success( _):
                            print("Signed in")
                        }
                    }
                }) {
                    Text("Login")
                        .padding(.vertical, 15)
                        .frame(width: 200)
                        .background(Color.green)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                }
                
                Button(action: {
                    self.action = .signUp
                    self.showSheet = true
                }) {
                    Text("Sign Up")
                        .padding(.vertical, 15)
                        .frame(width: 200)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                }
            }
            .alert(isPresented: $showAlert) {

                Alert(title: Text("Login Error"), message: Text(self.authError?.localizedDescription ?? "Unknown error"), dismissButton:.default(Text("OK")){
                    switch self.authError {
                    case .incorrectPassword:
                        self.user.password = ""
                    default:
                        self.user.email = ""
                        self.user.password = ""
                    }
                })
            }
        }
        .padding(.top, 100)
        .frame(width: 300)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        
    }
}

struct SignInWithEmailView_Previews: PreviewProvider {
    static var previews: some View {
        SignInWithEmailView(showSheet: .constant(false), action: .constant(.signUp))
    }
}
