//
//  AuthView.swift
//  Seeker
//
//  Created by Filipe Serafini on 18/09/25.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject private var auth: AuthService
    var body: some View {
        VStack {
            Text("Already have an account?")
            
            NavigationLink {
                SignInWithEmailView(vm: .init(mode: .signIn, auth: auth))
            } label: {
                Text("Sign In with Email")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Text("New here?")
            
            NavigationLink {
                SignUpWithEmailView(vm: .init(mode: .signUp, auth: auth))
            } label: {
                Text("Create an account with Email")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Welcome to Seeker!")
    }
}

#Preview {
    NavigationStack {
        AuthView()
    }
}
