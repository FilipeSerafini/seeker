//
//  AuthError.swift
//  Seeker
//
//  Created by Filipe Serafini on 20/09/25.
//

import Foundation

enum AuthError: Error {
    case invalidCredentials
    case emailNotFound
    case emailAlreadyInUse
    case weakPassword
    
    case userDisabled
    case tooManyRequests
    case network
    case unknown
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Email ou senha inválidos."
        case .emailAlreadyInUse:
            return "Este email já está em uso."
        case .weakPassword:
            return "A senha é muito fraca."
        case .userDisabled:
            return "Sua conta foi desativada."
        case .tooManyRequests:
            return "Muitas tentativas. Tente novamente mais tarde."
        case .network:
            return "Falha de rede. Verifique sua conexão."
        case .unknown:
            return "Ocorreu um erro inesperado. Por favor, tente novamente."
        default:
            return "Ocorreu um erro inesperado. Tente novamente mais tarde."
        }
    }
}
