import Foundation
import UIKit
import Combine

class BookService {
    //    private let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=")!
}

//MARK: - Fetch Books with combine API
extension BookService {
    func fetchBooks(searchedText: String, page: Int) -> AnyPublisher<[APIBook], Error> {
        
        let url: URL = buildAPIURL(searchedText: searchedText, page: page)
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap(\.data)
            .decode(type: APIBookResponse.self, decoder: JSONDecoder())
            .map(\.items)
            .map({ items -> [APIBook] in
                return items.compactMap({ $0.volumeInfo })
            })
            .mapError({ $0 as Error })
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private func buildAPIURL(searchedText: String, page: Int) -> URL {
        let baseURL: String = "https://www.googleapis.com/books/v1/volumes?q="
        let searchURL: String = baseURL + searchedText
        let pageURL: String = searchURL + "&startIndex=\(page)&orderBy=relevance"
        
        let finalURL = pageURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        guard let url = URL(string: finalURL) else {
            return URL(string: "https://www.googleapis.com/books/v1/volumes?q=a")!
        }
        
        return url
    }
}

//MARK: - Fetch Book poster with Combine API
extension BookService {
    func fetchBookCover(forURL bookCoverURL: String) -> AnyPublisher<Data, Error> {
        let url = URL(string: bookCoverURL)!
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap(\.data)
            .mapError({ $0 as Error })
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
