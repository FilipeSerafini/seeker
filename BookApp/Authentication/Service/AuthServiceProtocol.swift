//
//  AuthServiceProtocol.swift
//  Seeker
//
//  Created by Filipe Serafini on 20/09/25.
//

import Foundation

protocol AuthServiceProtocol {
    func signIn(email: String, password: String) async throws
    func signUp(email: String, password: String) async throws
}
