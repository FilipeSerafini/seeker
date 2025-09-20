//
//  ViewModel.swift
//  Seeker
//
//  Created by Filipe Serafini on 20/09/25.
//

import Foundation

@MainActor
final class AuthEmailPasswordViewModel: ObservableObject {
    enum Mode { case signIn, signUp }

    @Published var email = ""
    @Published var password = ""
    @Published var isSubmitting = false
    @Published var alertMessage: String?

    let mode: Mode
    private let auth: AuthServiceProtocol

    init(mode: Mode, auth: AuthServiceProtocol) {
        self.mode = mode
        self.auth = auth
    }

    var trimmedEmail: String { email.trimmingCharacters(in: .whitespacesAndNewlines) }
    var isValid: Bool {
        isValidEmail(trimmedEmail) && passwordIsValid
    }

    private var passwordIsValid: Bool {
        switch mode {
        case .signIn: return !password.isEmpty
        case .signUp: return password.count >= 6
        }
    }
    
    func submit() async {
        guard isValid, !isSubmitting else { return }
        isSubmitting = true
        
        defer { isSubmitting = false }
        
        do {
            switch mode {
            case .signIn:
                try await auth.signIn(email: trimmedEmail, password: password)
            case .signUp:
                try await auth.signUp(email: trimmedEmail, password: password)
            }
        } catch {
            let msg = (error as? LocalizedError)?.errorDescription
            alertMessage = msg ?? "Ocorreu um erro inesperado. Por favor, tente novamente."
        }
    }
    
    private func isValidEmail(_ s: String) -> Bool {
        s.range(of: #"^\S+@\S+\.\S+$"#, options: .regularExpression) != nil
    }
}
