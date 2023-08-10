//
//  BookServiceExtension.swift
//  BookApp
//
//  Created by Waldyr Schneider on 09/08/23.
//

import Foundation
import Combine
import SwiftUI

extension Publisher where Output == [APIBook] {
    func mapAPIBookToBook() -> AnyPublisher<[Book], Error> {
        self
            .flatMap({ apiBooks in
                apiBooks.publisher
            })
            .filter ({ apiBook in
                return apiBook.sinopsis != nil
            })
            .compactMap({ apiBook -> Book? in
                let newBook = Book(id: apiBook.id ?? "N/A", authors: apiBook.authors ?? ["N/A"], genres: apiBook.genres ?? ["N/A"], image: apiBook.image?.thumbnail ?? "image", isbns: apiBook.isbns?.map(\.identifier) ?? ["N/A"], rating: apiBook.rating?.description ?? "N/A", sinopsis: apiBook.sinopsis ?? "N/A", title: apiBook.title ?? "N/A", imageCover: nil)
                return newBook
            })
            .collect()
            .mapError({ $0 as Error })
            .eraseToAnyPublisher()
    }
}

extension Publisher where Output == APIBook {
    func mapAPIBookToBook() -> AnyPublisher<Book, Error> {
        self
            .compactMap { apiBook -> Book? in
                let book = Book(id: apiBook.id ?? "N/A",
                                authors: apiBook.authors ?? ["N/A"],
                                genres: apiBook.genres ?? ["N/A"],
                                image: apiBook.image?.thumbnail ?? "image",
                                isbns: apiBook.isbns?.map(\.identifier) ?? ["N/A"],
                                rating: apiBook.rating?.description ?? "N/A",
                                sinopsis: convertHTMLToString(htmlString: apiBook.sinopsis ?? "N/A"),
                                title: apiBook.title ?? "N/A",
                                imageCover: nil)
                return book
            }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}

extension Publisher where Output == [Book] {
    func setBookImages(withService service: BookService) -> AnyPublisher<[Book], Error> {
        self
            .flatMap({ apiBooks in
                apiBooks.publisher
            })
            .flatMap({ book in
                if book.image != "image" {
                    return service.fetchBookCover(forURL: book.image)
                        .map({ data in
                            var newBook = book
                            newBook.imageCover = UIImage(data: data)
                            return newBook
                        })
                        .replaceError(with: book)
                        .eraseToAnyPublisher()
                } else {
                    var newBook = book
                    newBook.imageCover = UIImage(named: "bookImage")
                    return Just(newBook).eraseToAnyPublisher()
                }
            })
            .collect()
            .mapError({ $0 as Error })
            .eraseToAnyPublisher()
    }
}

extension Publisher where Output == Book {
    func setBookImages(withService service: BookService) -> AnyPublisher<Book, Error> {
        self
            .flatMap({ book in
                if book.image != "image" {
                    return service.fetchBookCover(forURL: book.image)
                        .map({ data in
                            var newBook = book
                            newBook.imageCover = UIImage(data: data)
                            return newBook
                        })
                        .replaceError(with: book)
                        .eraseToAnyPublisher()
                } else {
                    var newBook = book
                    newBook.imageCover = UIImage(named: "bookImage")
                    return Just(newBook).eraseToAnyPublisher()
                }
            })
            .mapError({ $0 as Error })
            .eraseToAnyPublisher()
    }
}

private func convertHTMLToString(htmlString: String) -> String {
    if let data = htmlString.data(using: .utf8) {
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        do {
            let attributedString = try NSAttributedString(data: data, options: options, documentAttributes: nil)
            return attributedString.string
        } catch {
            print("Error converting HTML to attributed string: \(error)")
        }
    }
    
    return "N/A"
}

func sortBooks(books: [Book]) -> [Book] {
    let sortedBooks = books.sorted { (book1, book2) in
        if book1.image.contains("image") && !book2.image.contains("image") {
            return false // book2 tem capa, então book1 vai depois
        } else if !book1.image.contains("image") && book2.image.contains("image") {
            return true // book1 tem capa, então book1 vai antes
        } else {
            return book1.title < book2.title // ambos têm ou não têm capa, ordene por título
        }
    }
    return sortedBooks
}
