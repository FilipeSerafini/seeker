//
//  SignUpWithEmailView.swift
//  Seeker
//
//  Created by Filipe Serafini on 18/09/25.
//

import SwiftUI

struct SignUpWithEmailView: View {
    @StateObject private var vm: AuthEmailPasswordViewModel
    @FocusState private var focusedField: Field?
    private enum Field { case email, password }

    init(vm: AuthEmailPasswordViewModel) { _vm = .init(wrappedValue: vm) }

    var body: some View {
        VStack {
            TextField("Email...", text: $vm.email)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .textContentType(.username)
                .autocorrectionDisabled()
                .focused($focusedField, equals: .email)
                .padding().background(.quaternary.opacity(0.5)).cornerRadius(10)

            SecureField("Password...", text: $vm.password)
                .textContentType(.newPassword)
                .focused($focusedField, equals: .password)
                .padding().background(.quaternary.opacity(0.5)).cornerRadius(10)

            Button {
                Task { await vm.submit() }
            } label: {
                Text(vm.isSubmitting ? "Criando..." : "Sign Up")
                    .font(.headline).foregroundStyle(.white)
                    .frame(height: 55).frame(maxWidth: .infinity)
                    .background(vm.isValid ? Color.blue : Color.gray)
                    .cornerRadius(10)
            }
            .disabled(!vm.isValid || vm.isSubmitting)
            .submitLabel(.go)

            Spacer()
        }
        .padding()
        .navigationTitle("Sign Up with Email")
        .onSubmit {
            if focusedField == .email {
                focusedField = .password
            } else {
                Task { await vm.submit() }
            }
        }
        .alert("Ops", isPresented: Binding(
            get: { vm.alertMessage != nil },
            set: { if !$0 { vm.alertMessage = nil } }
        )) { Button("OK", role: .cancel) { vm.alertMessage = nil } } message: { Text(vm.alertMessage ?? "") }
    }
}
