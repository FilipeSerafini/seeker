import Foundation
import CloudKit

struct Folder: CKProtocol {
    var record: CKRecord
    var id: String = UUID().uuidString
    var books: [CKRecord.Reference]
    var description: String
    var name: String
    
//    init() {
//        id = UUID().uuidString
//        books = []
//        description = ""
//        name = ""
////        owner = CKRecord.Reference.
//
//        self.record = CKRecord(recordType: "Folder")
//    }
    
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
        let id = record["id"] as? String ?? ""
        let books = record["books"] as? [CKRecord.Reference] ?? []
        let description = record["description"] as? String ?? ""
        let name = record["name"] as? String ?? ""
        
        self.id = id
        self.books = books
        self.description = description
        self.name = name
        self.record = record
    }
}
