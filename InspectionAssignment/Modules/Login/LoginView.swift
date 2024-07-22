//
//  ContentView.swift
//  INspectionTest
//
//  Created by Sanjay Raskar on 20/07/24.
//

import SwiftUI

struct LoginView: View {
   
    @State var email: String = "Test1@mail.com"
    @State var password: String = "test123"
    @StateObject private var loginViewModel = LoginViewModel()
    @State var isLogin: Bool = true

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Username", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                loginSignupButtonView

                Button {
                    isLogin.toggle()
                } label: {
                    Text(isLogin ? "Register new user" : "Login existing user")
                }

            }
            .padding()
            .navigationDestination(isPresented: $loginViewModel.loginOrSignupSuccess, destination: { 
                StartInspectionView()
            })
            .alert(loginViewModel.error, isPresented: isShowingError) {
            }
        
        }
    }
    
    var loginSignupButtonView: some View {
        Button(action: {
            Task {
                if isLogin {
                    await loginViewModel.login(with: email, password: password)
                } else {
                    await loginViewModel.register(with: email, password: password)
                }
            }
            
        }) {
            Text(isLogin ? "Login" : "Register")
                .padding(.horizontal, 40)
                .padding(.vertical, 10)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(5)
        }
        .padding()
    }
    
    var isShowingError: Binding<Bool> {
        Binding {
            !loginViewModel.error.isEmpty
        } set: { _ in
            loginViewModel.error = ""
        }
    }
}

#Preview {
    LoginView()
}
