import Foundation

// MARK: - APIResponse
struct APIResponse: Codable {
    let choices: [Choice]
}

// MARK: - Choice
struct Choice: Codable {
    let message: Message
}

// MARK: - Message
struct Message: Codable {
    let role: String
    let content: String
}
