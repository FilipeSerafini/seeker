//
//  Genres.swift
//  BookApp
//
//  Created by Sabrina Souza on 09/08/23.
//

import Foundation

enum Genre: String {
    case romance
    case fiction
    case poetry
    case horror
    case mystery
    case nonFiction
    case selfHelp
    case fantasy
    case thriller
    case biography
    case religion
    case philosophy
    case empty
    
    var url: String {
        switch self {
        case .romance: return "romance"
        case .fiction: return "fiction"
        case .poetry: return "poetry"
        case .horror: return "horror"
        case .mystery: return "mystery"
        case .selfHelp: return "self-help"
        case .nonFiction: return "nonfiction"
        case .fantasy: return "fantasy"
        case .thriller: return "thriller"
        case .biography: return "biography"
        case .religion: return "religion"
        case .philosophy: return "philosophy"
        case .empty: return ""
        }
    }
}
