//
//  SignUpWithEmailView.swift
//  Seeker
//
//  Created by Filipe Serafini on 18/09/25.
//

import SwiftUI

@MainActor
final class SignUpWithEmailViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func validate() -> Bool {
        !email.isEmpty && !password.isEmpty
    }
}

struct SignUpWithEmailView: View {
    @EnvironmentObject private var auth: AuthService
    @StateObject private var vm = SignUpWithEmailViewModel()
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
                        try await auth.signUp(email: vm.email, password: vm.password)
                        dismiss()
                    } catch {
                        // TODO: handle error
                        print("Error signing up: \(error)")
                    }
                }
            } label: {
                Text("Sign Up")
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
    SignUpWithEmailView()
}
