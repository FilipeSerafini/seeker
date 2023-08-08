import Foundation
import UIKit

struct FolderCard: Identifiable {
    
    var id = UUID().uuidString
    var name: String
    var image: String
    
    var books: [Book]
}

var book = Book(authors: ["Maria Autora"], genres: ["Romance"], image: "bookImage", isbns: ["1234"], rating: "4,9", sinopsis: "Essa é uma história sobre uma princesa", title: "A princesa em seu castelo", imageCover: UIImage(named: "bookImage")!)

var book1 = Book(authors: ["Maria Autora"], genres: ["Romance"], image: "bookImage", isbns: ["1234"], rating: "4,9", sinopsis: "Essa é uma história sobre uma princesa", title: "A princesa em seu castelo", imageCover: UIImage(named: "bookImage")!)

var book2 = Book(authors: ["Maria Autora"], genres: ["Romance"], image: "bookImage", isbns: ["1234"], rating: "4,9", sinopsis: "Essa é uma história sobre uma princesa", title: "A princesa em seu castelo", imageCover: UIImage(named: "bookImage")!)

var book3 = Book(authors: ["Maria Autora"], genres: ["Romance"], image: "bookImage", isbns: ["1234"], rating: "4,9", sinopsis: "Essa é uma história sobre uma princesa", title: "A princesa em seu castelo", imageCover: UIImage(named: "bookImage")!)

var book4 = Book(authors: ["Maria Autora"], genres: ["Romance"], image: "bookImage", isbns: ["1234"], rating: "4,9", sinopsis: "Essa é uma história sobre uma princesa", title: "A princesa em seu castelo", imageCover: UIImage(named: "bookImage")!)

var book5 = Book(authors: ["Maria Autora"], genres: ["Romance"], image: "bookImage", isbns: ["1234"], rating: "4,9", sinopsis: "Essa é uma história sobre uma princesa", title: "A princesa em seu castelo", imageCover: UIImage(named: "bookImage")!)

var book6 = Book(authors: ["Maria Autora"], genres: ["Romance"], image: "bookImage", isbns: ["1234"], rating: "4,9", sinopsis: "Essa é uma história sobre uma princesa", title: "A princesa em seu castelo", imageCover: UIImage(named: "bookImage")!)

var books: [Book] = [book!, book1!, book2!, book3!, book4!, book5!, book6!]

var folders: [FolderCard] = [
    FolderCard (name: "Leituras realizadas", image: "folderShapePurple", books: books),
    FolderCard (name: "Livros que eu quero ler", image: "folderShapeBlue", books: books),
    FolderCard (name: "Lendo agora", image: "folderShapePurple", books: books),
    FolderCard (name: "Lendo agora", image: "folderShapePurple", books: books),
    FolderCard (name: "Lendo agora", image: "folderShapePurple", books: books),
    FolderCard (name: "Lendo agora", image: "folderShapePurple", books: books),
    FolderCard (name: "Lendo agora", image: "folderShapePurple", books: books),

]
