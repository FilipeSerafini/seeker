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
final class AuthService: ObservableObject {
    
    enum Phase {
        case unknown      // antes do primeiro callback do Firebase (evita flicker)
        case signedOut
        case signedIn(AuthDataResultModel)
    }
    
    @Published private(set) var phase: Phase = .unknown
    private var handle: AuthStateDidChangeListenerHandle?
    
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
            _ = try await Auth.auth().signIn(withEmail: email, password: password)
            // listener will update `phase`
       }

       func signUp(email: String, password: String) async throws {
           _ = try await Auth.auth().createUser(withEmail: email, password: password)
           // listener will update `phase`
       }

       func signOut() throws {
           try Auth.auth().signOut()
           // listener will update `phase` to .signedOut
       }

       var isAuthenticated: Bool {
           if case .signedIn = phase { return true }
           return false
       }
}
