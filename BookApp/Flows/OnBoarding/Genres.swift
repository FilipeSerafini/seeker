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
    
    var toApi: String {
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
    
    var toUser: String {
        switch self {
        case .romance: return "Romance"
        case .fiction: return "Ficção"
        case .poetry: return "Poesia"
        case .horror: return "Terror"
        case .mystery: return "Mistério"
        case .selfHelp: return "Autoajuda"
        case .nonFiction: return "Não ficção"
        case .fantasy: return "Fantasia"
        case .thriller: return "Suspense"
        case .biography: return "Biografia"
        case .religion: return "Religião"
        case .philosophy: return "Filosofia"
        case .empty: return ""
        }
    }
}
