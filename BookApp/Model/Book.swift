import Foundation
import UIKit
import CloudKit

enum CKRecordNames: String {
    case id
    case authors
    case genres
    case image
    case isbns
    case rating
    case sinopsis
    case title
    
    var description : String {
        switch self {
        case .id: return "id"
        case .authors: return "authors"
        case .genres: return "genres"
        case .image: return "image"
        case .isbns: return "isbns"
        case .rating: return "rating"
        case .sinopsis: return "sinopsis"
        case .title: return "title"
        }
    }
}

struct Book {
    
    var record: CKRecord?
    var id: String = UUID().uuidString
    var authors: [String]
    var genres: [String]
    var image: String
    var isbns: [String]
    var rating: String
    var sinopsis: String
    var title: String
    var imageCover: UIImage?
    
    //init para inicializar os atributos
    init() {
        id = UUID().uuidString
        authors = []
        genres = []
        image = ""
        isbns = []
        rating = ""
        sinopsis = ""
        title = ""
        
        self.record = CKRecord(recordType: "Book")
    }
    
    //init para transformar os atributos em records para o banco, e determinar o recordType do usuario
    init?(
        id: String = UUID().uuidString,
        authors: [String],
        genres: [String],
        image: String,
        isbns: [String],
        rating: String,
        sinopsis: String,
        title: String,
        imageCover: UIImage?
    ) {
        
        let record = CKRecord(recordType: "Book")
        
        record[CKRecordNames.id.description] = id
        record[CKRecordNames.authors.description] = authors
        record[CKRecordNames.genres.description] = genres
        record[CKRecordNames.image.description] = image
        record[CKRecordNames.isbns.description] = isbns
        record[CKRecordNames.rating.description] = rating
        record[CKRecordNames.sinopsis.description] = sinopsis
        record[CKRecordNames.title.description] = title
        
        self.init(record: record)
    }
    
    //init para criar o objeto e atribuir o record a ele
    init?(record: CKRecord) {
        
        guard let id = record[CKRecordNames.id.description] as? String else {return nil}
        guard let authors = record[CKRecordNames.authors.description] as? [String] else {return nil}
        guard let genres = record[CKRecordNames.genres.description] as? [String] else {return nil}
        guard let image = record[CKRecordNames.image.description] as? String else {return nil}
        guard let isbns = record[CKRecordNames.isbns.description] as? [String] else {return nil}
        guard let rating = record[CKRecordNames.rating.description] as? String else {return nil}
        guard let sinopsis = record[CKRecordNames.sinopsis.description] as? String else {return nil}
        guard let title = record[CKRecordNames.title.description] as? String else {return nil}
        
        self.id = id
        self.authors = authors
        self.genres = genres
        self.image = image
        self.isbns = isbns
        self.rating = rating
        self.sinopsis = sinopsis
        self.title = title
        self.record = record
    }
}

struct APIBookResponse: Decodable {
    var items: [BookItemResponse]
}

struct BookItemResponse: Decodable {
    var volumeInfo: APIBook
}

struct APIBook: Decodable {
    struct APIImage: Decodable {
        var smallThumbnail: String
        var thumbnail: String
    }
    
    struct APIISBN: Decodable {
        var type: String
        var identifier: String
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case authors
        case genres = "categories"
        case image = "imageLinks"
        case isbns = "industryIdentifiers"
        case rating = "averageRating"
        case sinopsis = "description"
        case title
        
        
    }
    
    var id: String? = UUID().uuidString
    var authors: [String]
    var genres: [String]
    var image: APIImage
    var isbns: [APIISBN]
    var rating: Double?
    var sinopsis: String?
    var title: String
}
