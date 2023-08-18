import Foundation
import CloudKit

struct CommentReview: CKProtocol, Identifiable {
    
    var record: CKRecord
    var id: String = UUID().uuidString
    var comment: String
    var bookID: String
    var bookTitle: String
    var bookAuthor: String
    var bookImageURL: String
    var commentTitle: String
    
    //init para inicializar os atributos
    init() {
        id = UUID().uuidString
        comment = ""
        bookID = ""
        bookTitle = ""
        bookAuthor = ""
        bookImageURL = ""
        commentTitle = ""
        
        self.record = CKRecord(recordType: "CommentReview")
    }
    
    
    //init para transformar os atributos em records para o banco, e determinar o recordType do usuario
    init?(
        id: String = UUID().uuidString,
        comment: String,
        bookID: String,
        bookTitle: String,
        bookAuthor: String,
        bookImageURL: String,
        commentTitle: String
        
    ) {
        
        let record = CKRecord(recordType: "CommentReview")
        
        record["id"] = id
        record["comment"] = comment
        record["bookID"] = bookID
        record["bookTitle"] = bookTitle
        record["bookAuthor"] = bookAuthor
        record["bookImageURL"] = bookImageURL
        record["commentTitle"] = commentTitle
        
        self.init(record: record)
    }
    
    //init para criar o objeto e atribuir o record a ele
    init?(record: CKRecord) {
        
        guard let id = record["id"] as? String else {return nil}
        guard let comment = record["comment"] as? String else {return nil}
        guard let bookID = record["bookID"] as? String else {return nil}
        guard let bookTitle = record["bookTitle"] as? String else {return nil}
        guard let bookAuthor = record["bookAuthor"] as? String else { return nil }
        guard let bookImageURL = record["bookImageURL"] as? String else { return nil }
        guard let commentTitle = record["commentTitle"] as? String else { return nil }
        
        self.id = id
        self.comment = comment
        self.bookID = bookID
        self.bookTitle = bookTitle
        self.bookAuthor = bookAuthor
        self.bookImageURL = bookImageURL
        self.commentTitle = commentTitle
        
        self.record = record
    }
    
}
