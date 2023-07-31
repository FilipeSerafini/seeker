import Foundation
import UIKit
import Combine

class BookService {
    //    private let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=")!
}

//MARK: - Fetch Books with combine API
extension BookService {
    func fetchBooks(searchedText: String) -> AnyPublisher<[APIBook], Error> {
        
        let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=\(searchedText)")!
        
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
