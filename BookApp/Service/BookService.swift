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
    private let baseURL: String = "https://www.googleapis.com/books/v1/"
}

//MARK: - Fetch Books with combine API
extension BookService {
    func fetchBooks(searchedText: String, page: Int, filter: Filter) -> AnyPublisher<[APIBook], Error> {
        let url: URL = buildAPIURL(searchedText: searchedText, page: page, filter: filter)
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap(\.data)
            .decode(type: APIBookResponse.self, decoder: JSONDecoder())
            .compactMap { response in
                response.items?.compactMap { item -> APIBook? in
                    let volumeInfo = item.volumeInfo
                    let apiBook = APIBook(id: item.id, authors: volumeInfo.authors, genres: volumeInfo.genres, image: volumeInfo.image, isbns: volumeInfo.isbns, rating: volumeInfo.rating, sinopsis: volumeInfo.sinopsis, title: volumeInfo.title)
                    return apiBook
                }
            }
            .mapError { $0 as Error }
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private func buildAPIURL(searchedText: String, page: Int, filter: Filter) -> URL {
        var searchURL: String = self.baseURL + filter.url
        
        if filter == .isbn {
            searchURL = searchURL + searchedText.replacingOccurrences(of: " ", with: "+")
        } else {
            searchURL = searchURL + "\"" + searchedText.replacingOccurrences(of: " ", with: "+") + "\""
        }
        
        let pageURL: String = searchURL + "&startIndex=\(page)&orderBy=relevance&maxResults=20"
        
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

//MARK: - Fetch Book by ID with Combine API
extension BookService {
    func fetchBookById(bookId: String) -> AnyPublisher<APIBook, Error> {
        let url: URL = URL(string: "https://www.googleapis.com/books/v1/volumes/\(bookId)")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap(\.data)
            .decode(type: BookItemResponse.self, decoder: JSONDecoder())
            .mapError { $0 as Error }
            .compactMap { response in
                let volumeInfo = response.volumeInfo
                let apiBook = APIBook(id: response.id, authors: volumeInfo.authors, genres: volumeInfo.genres, image: volumeInfo.image, isbns: volumeInfo.isbns, rating: volumeInfo.rating, sinopsis: volumeInfo.sinopsis, title: volumeInfo.title)
                return apiBook
            }
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
