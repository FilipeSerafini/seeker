import Foundation
import UIKit
import Combine

enum Filter: String {
    case title
    case genre
    case author
    case isbn
    case empty
    
    var url: String {
        switch self {
        case .title: return "volumes?q=intitle:"
        case .genre: return "volumes?q=subject:"
        case .author: return "volumes?q=inauthor:"
        case .isbn: return "volumes?q=isbn:"
        case .empty: return "volumes?q="
        }
    }
}

class BookService {
    //    private let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=")!
}

//MARK: - Fetch Books with combine API
extension BookService {
    func fetchBooks(searchedText: String, page: Int, filter: Filter) -> AnyPublisher<[APIBook], Error> {
        
        let url: URL = buildAPIURL(searchedText: searchedText, page: page, filter: filter)
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap(\.data)
            .decode(type: APIBookResponse.self, decoder: JSONDecoder())
            .map(\.items)
            .map({ items -> [APIBook] in
                return items?.compactMap({ $0.volumeInfo }) ?? []
            })
            .mapError({ $0 as Error })
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private func buildAPIURL(searchedText: String, page: Int, filter: Filter) -> URL {
        let baseURL: String = "https://www.googleapis.com/books/v1/"
        
        let searchURL: String = baseURL + filter.url + searchedText.replacingOccurrences(of: " ", with: "+")

        let pageURL: String = searchURL + "&startIndex=\(page)&orderBy=relevance"
        
        let finalURL = pageURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        print(finalURL)
        
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
