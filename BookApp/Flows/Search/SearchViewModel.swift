//
//  SearchViewModel.swift
//  BookApp
//
//  Created by Sabrina Souza on 27/07/23.
//

import Foundation
import Combine
import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var books: [Book] = []
    private let service: BookService = BookService()
    private var subscriptions = Set<AnyCancellable>()

    func fetchBooks(searchedText: String) {
        self.service.fetchBooks(searchedText: searchedText)
            .flatMap({ apiBooks in
                apiBooks.publisher
            })
            .compactMap({ apiBook -> Book in #warning("substituir image por imagem default dos assets")
                let newBook = Book(authors: apiBook.authors, genres: apiBook.genres ?? [], image: apiBook.image?.thumbnail ?? "image", isbns: apiBook.isbns.map(\.identifier), rating: apiBook.rating?.description ?? "", sinopsis: apiBook.sinopsis ?? "", title: apiBook.title, imageCover: nil)
                return newBook!
            })
            .collect()
            .flatMap({ apiBooks in
                apiBooks.publisher
            })
            .flatMap({ book in
                return self.service.fetchBookCover(forURL: book.image)
                    .map({ data in
                        var newBook = book
                        newBook.imageCover = Image(UIImage(data: data))
                        return newBook
                    })
                    .catch({ _ in Just(book) })
            })
            .collect()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    return
                }
            }, receiveValue: { books in
                self.books = books
                print(self.books)
//                self.reloadData()
            })
            .store(in: &subscriptions)
    }
}
