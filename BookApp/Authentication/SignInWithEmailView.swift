//
//  SignInWithEmailView.swift
//  Seeker
//
//  Created by Filipe Serafini on 18/09/25.
//

import SwiftUI

@MainActor
final class SignInWithEmailViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func validate() -> Bool {
        !email.isEmpty && !password.isEmpty
    }
}

struct SignInWithEmailView: View {
    @EnvironmentObject private var auth: AuthService
    @StateObject private var vm = SignInWithEmailViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            TextField("Email...", text: $vm.email)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            SecureField("Password...", text: $vm.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            Button {
                Task {
                    guard vm.validate() else { return }
                    do {
                        try await auth.signIn(email: vm.email, password: vm.password)
                        dismiss()
                    } catch {
                        // TODO: handle error
                        print("Error signing in: \(error)")
                    }
                }
            } label: {
                Text("Sign In")
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
        .navigationTitle("Sign In with Email")
    }
}

#Preview {
    NavigationStack {
        SignInWithEmailView()
    }
}
