import Foundation
import CloudKit

struct Folder: CKProtocol {
    
    var record: CKRecord
    var id: String = UUID().uuidString
    var books: [String]
    var description: String
    var name: String
    
    init() {
        id = UUID().uuidString
        books = []
        description = ""
        name = ""
        
        self.record = CKRecord(recordType: "Folder")
    }
    
    init?(
        id: String,
        books: [String],
        description: String,
        name: String
    ) {
        
        let record = CKRecord(recordType: "Folder")
        
        record["id"] = id
        record["books"] = books
        record["description"] = description
        record["name"] = name
        
        self.init(record: record)
    }
    
    init?(record: CKRecord) {
        
        guard let id = record["id"] as? String else { return nil }
        guard let books = record["books"] as? [String] else { return nil }
        guard let description = record["description"] as? String else { return nil }
        guard let name = record["name"] as? String else { return nil }
        
        self.id = id
        self.books = books
        self.description = description
        self.name = name
        self.record = record
    }
}
