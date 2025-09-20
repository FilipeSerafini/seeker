//
//  AuthService.swift
//  Seeker
//
//  Created by Filipe Serafini on 18/09/25.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}

@MainActor
final class AuthService: ObservableObject, AuthServiceProtocol {
    
    enum Phase {
        case unknown      // antes do primeiro callback do Firebase (evita flicker)
        case signedOut
        case signedIn(AuthDataResultModel)
    }
    
    @Published private(set) var phase: Phase = .unknown
    private var handle: AuthStateDidChangeListenerHandle?
    
    var isAuthenticated: Bool {
        if case .signedIn = phase { return true }
        return false
    }
    
    init() {
        // Listen for Firebase session changes
        handle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self else { return }
            if let user {
                self.phase = .signedIn(AuthDataResultModel(user: user))
            } else {
                self.phase = .signedOut
            }
        }
    }
    
    deinit {
        if let handle { Auth.auth().removeStateDidChangeListener(handle) }
    }
    
    func signIn(email: String, password: String) async throws {
        do {
            _ = try await Auth.auth().signIn(withEmail: email, password: password)
        } catch {
            throw mapFirebaseError(error)
        }
    }
    
    func signUp(email: String, password: String) async throws {
        do {
            _ = try await Auth.auth().createUser(withEmail: email, password: password)
        } catch {
            throw mapFirebaseError(error)
        }
    }
    
    func signOut() throws {
        do {
            try Auth.auth().signOut()
        } catch {
            throw mapFirebaseError(error)
        }
    }
    
    func resetPassword(email: String) async throws {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
        } catch {
            throw mapFirebaseError(error)
        }
    }
    
    func getCurrentUserEmail() async throws -> String {
        guard let authUser = Auth.auth().currentUser else { throw AuthError.emailNotFound }
        guard let email = authUser.email else { throw AuthError.emailNotFound }
        
        return email
    }
    
    private func mapFirebaseError(_ error: Error) -> AuthError {
        let ns = error as NSError
        guard ns.domain == AuthErrorDomain,
              let code = AuthErrorCode(rawValue: ns.code) else {
            return .unknown
        }
        
        switch code {
        case .invalidEmail, .wrongPassword, .userNotFound:
            return .invalidCredentials
        case .emailAlreadyInUse:
            return .emailAlreadyInUse
        case .weakPassword:
            return .weakPassword
        case .userDisabled:
            return .userDisabled
        case .tooManyRequests:
            return .tooManyRequests
        case .networkError:
            return .network
        default:
            return .unknown
        }
    }
}

