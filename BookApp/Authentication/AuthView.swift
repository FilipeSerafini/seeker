//
//  AuthView.swift
//  Seeker
//
//  Created by Filipe Serafini on 18/09/25.
//

import SwiftUI

struct AuthView: View {
    
    
    var body: some View {
        VStack {
            
            NavigationStack {
                Text("Already have an account?")
                NavigationLink {
                    SignInWithEmailView()
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
                    SignInWithEmailView()
                } label: {
                    Text("Create an account with Email")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Sign In")
    }
}

#Preview {
    NavigationStack {
        AuthView()
    }
}
