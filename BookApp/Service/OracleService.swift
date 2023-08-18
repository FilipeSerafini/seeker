import Foundation
import Combine

private enum roles: String {
    case user
    case assistant
    case system
    case error
    
    var description: String {
        switch self {
        case .user: return "user"
        case .assistant: return "assistant"
        case .system: return "system"
        case .error: return "error"
        }
    }
}

class OracleService {
    private let openAIURL = URL(string: "https://api.openai.com/v1/chat/completions")!
    
    // MARK: - Chave aqui!!
    private let openAIKey = "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"
    
    private let initialMessage = Message(role: roles.system.description, content: "Your name is Zoe, you are a friendly and helpful assistant. You are going to receive books questions. If the user asks for any kind of summary, keep the answer short. If the question is not about books dont respond the question just kindly ask the user to make a question about books.")
    
    private let errorMessage: String = "Desculpe, não estou conseguindo visualizar uma resposta para a sua pergunta. Que tal checar sua conexão à internet e tentar novamente?"
    
    private var messeges: [[String: String]] = []
    
    init() {
        messeges.append(convertMessageToRequest(message: initialMessage))
    }
}

extension OracleService {
    
    private func convertMessageToRequest(message: Message) -> [String: String] {
        let role: String = "role"
        let content: String = "content"
        return [content: message.content, role: message.role]
    }
    
    public func sendRequest(messageString: String) async -> Message {
        let message: Message = Message(role: roles.user.description, content: messageString)
        messeges.append(convertMessageToRequest(message: message))
        
        var request = URLRequest(url: self.openAIURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(self.openAIKey)", forHTTPHeaderField: "Authorization")
        
        let httpBody: [String: Any] = [
            "model" : "gpt-3.5-turbo",
            "messages" :  messeges
        ]
        
        var httpBodyJson: Data? = nil
        
        do {
            httpBodyJson = try JSONSerialization.data(withJSONObject: httpBody, options: .prettyPrinted)
        } catch {
            print("Unable to convert to JSON \(error)")
        }
        request.httpBody = httpBodyJson
        
        let serverResponse = try? await URLSession.shared.data(for: request)
        
        guard let serverResponse = serverResponse else { return Message(role: roles.error.description, content: errorMessage) }
        let data = serverResponse.0
        
        do {
            return try JSONDecoder().decode(APIResponse.self, from: data).choices[0].message
        } catch {
            return Message(role: roles.error.description, content: errorMessage)
        }
    }
}

