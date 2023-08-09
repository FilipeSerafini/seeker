import Foundation
import UIKit

struct FolderCard: Identifiable {
    
    var id = UUID().uuidString
    var name: String
    var books: [Book]
    var isExpanded: Bool = false
}

//MARK: TEMPORÁRIO PARA TESTES

var book1 = Book(id: "12345", authors: ["Maria Autora"], genres: ["Romance"], image: "bookImage", isbns: ["1234"], rating: "4,9", sinopsis: "Essa é uma história sobre uma princesa", title: "A princesa em seu castelo", imageCover: UIImage(named: "bookImage")!)

var book2 = Book(id: "12345", authors: ["Maria Autora"], genres: ["Romance"], image: "bookImage", isbns: ["1234"], rating: "4,9", sinopsis: "Essa é uma história sobre uma princesa", title: "A princesa em seu castelo", imageCover: UIImage(named: "bookImage")!)

var book3 = Book(id: "12345", authors: ["Maria Autora"], genres: ["Romance"], image: "bookImage", isbns: ["1234"], rating: "4,9", sinopsis: "Essa é uma história sobre uma princesa", title: "A princesa em seu castelo", imageCover: UIImage(named: "bookImage")!)

var book4 = Book(id: "12345", authors: ["Maria Autora"], genres: ["Romance"], image: "bookImage", isbns: ["1234"], rating: "4,9", sinopsis: "Essa é uma história sobre uma princesa", title: "A princesa em seu castelo", imageCover: UIImage(named: "bookImage")!)

var book5 = Book(id: "12345", authors: ["Maria Autora"], genres: ["Romance"], image: "bookImage", isbns: ["1234"], rating: "4,9", sinopsis: "Essa é uma história sobre uma princesa", title: "A princesa em seu castelo", imageCover: UIImage(named: "bookImage")!)

var book6 = Book(id: "12345", authors: ["Maria Autora"], genres: ["Romance"], image: "bookImage", isbns: ["1234"], rating: "4,9", sinopsis: "Essa é uma história sobre uma princesa", title: "A princesa em seu castelo", imageCover: UIImage(named: "bookImage")!)

var books: [Book] = [book1!, book2!, book3!, book4!, book5!, book6!]

var folders: [FolderCard] = [
    FolderCard (name: "Leituras realizadas", books: books),
    FolderCard (name: "Livros que eu quero ler", books: books),
    FolderCard (name: "Lendo agora", books: books),
//    FolderCard (name: "Lendo agora", books: books),
//    FolderCard (name: "Lendo agora", books: books),
//    FolderCard (name: "Lendo agora", books: books),
//    FolderCard (name: "Lendo agora", books: books),
    
]
