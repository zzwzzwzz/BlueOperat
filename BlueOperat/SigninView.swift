//
//  SigninView.swift
//  BlueOperat
//
//  Created by Ziwen Zhou on 2024.11.26.
//

import SwiftUI
import AuthenticationServices // Required for Apple Sign-In

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            // Welcome Back Title
            VStack(spacing: 8) {
                Text("Welcome Back!")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.theme)
                
                Text("Sign in to continue")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.gray)
            }

            Spacer().frame(height: 20)

            // Email TextField
            VStack(alignment: .leading, spacing: 8) {
                Text("Email")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.gray)
                
                TextField("Enter your email", text: $email)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(12)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
            }

            // Password TextField
            VStack(alignment: .leading, spacing: 8) {
                Text("Password")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.gray)
                
                SecureField("Enter your password", text: $password)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(12)
            }

            // Sign In Button
            Button(action: {
                if validateCredentials() {
                    // Handle successful sign-in
                } else {
                    showError = true
                    errorMessage = "Invalid email or password"
                }
            }) {
                Text("Sign In")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.theme)
                    .cornerRadius(12)
            }
            .padding(.top, 20)

            // Error Message
            if showError {
                Text(errorMessage)
                    .font(.system(size: 14))
                    .foregroundColor(.red.opacity(0.8))
                    .padding(.top, 8)
            }
            
            Spacer().frame(height: 16)

            // Apple Sign-In
            SignInWithAppleButton(.signIn, onRequest: { request in
                // Handle Apple Sign-In request
                request.requestedScopes = [.email, .fullName]
            }, onCompletion: { result in
                switch result {
                case .success(let authResults):
                    print("Authorization successful: \(authResults)")
                case .failure(let error):
                    print("Authorization failed: \(error.localizedDescription)")
                }
            })
            .signInWithAppleButtonStyle(.black)
            .frame(height: 50)
            .cornerRadius(12)

            // Google Sign-In Placeholder
            Button(action: {
                // Integrate Google Sign-In SDK here
                print("Google Sign-In pressed")
            }) {
                HStack {
                    Image(systemName: "globe")
                        .resizable()
                        .frame(width: 18, height: 18)
                    Text("Sign In with Google")
                        .font(.system(size: 18, weight: .semibold))
                }
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color.theme.opacity(0.2))
                .cornerRadius(12)
            }

            Spacer()

            // Sign Up Link
            HStack {
                Text("Don't have an account?")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                
                Button(action: {
                    // Handle sign-up navigation
                }) {
                    Text("Sign Up")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.theme)
                }
            }
            .padding(.bottom, 20)
        }
        .padding(.horizontal, 24)
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }

    private func validateCredentials() -> Bool {
        // Implement your own validation logic here
        return email == "example@email.com" && password == "password"
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
