import Foundation
import UIKit

struct FolderCard: Identifiable {
    
    var id = UUID().uuidString
    var name: String
    var image: String
    
    var books: [Book]
}

//MARK: TEMPORÁRIO PARA TESTES

var book = Book(authors: ["Maria Autora"], genres: ["Romance"], image: "book0", isbns: ["1234"], rating: "4,9", sinopsis: "Essa é uma história sobre uma princesa", title: "A princesa em seu castelo", imageCover: UIImage(named: "book0")!)

var book1 = Book(authors: ["Maria Autora"], genres: ["Romance"], image: "book1", isbns: ["1234"], rating: "4,9", sinopsis: "Essa é uma história sobre uma princesa", title: "A princesa em seu castelo", imageCover: UIImage(named: "book1")!)

var book2 = Book(authors: ["Maria Autora"], genres: ["Romance"], image: "book2", isbns: ["1234"], rating: "4,9", sinopsis: "Essa é uma história sobre uma princesa", title: "A princesa em seu castelo", imageCover: UIImage(named: "book2")!)

var book3 = Book(authors: ["Maria Autora"], genres: ["Romance"], image: "book3", isbns: ["1234"], rating: "4,9", sinopsis: "Essa é uma história sobre uma princesa", title: "A princesa em seu castelo", imageCover: UIImage(named: "book3")!)

var book4 = Book(authors: ["Maria Autora"], genres: ["Romance"], image: "book4", isbns: ["1234"], rating: "4,9", sinopsis: "Essa é uma história sobre uma princesa", title: "A princesa em seu castelo", imageCover: UIImage(named: "book4")!)

var book5 = Book(authors: ["Maria Autora"], genres: ["Romance"], image: "book5", isbns: ["1234"], rating: "4,9", sinopsis: "Essa é uma história sobre uma princesa", title: "A princesa em seu castelo", imageCover: UIImage(named: "book5")!)

var book6 = Book(authors: ["Maria Autora"], genres: ["Romance"], image: "book6", isbns: ["1234"], rating: "4,9", sinopsis: "Essa é uma história sobre uma princesa", title: "A princesa em seu castelo", imageCover: UIImage(named: "book6")!)

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
