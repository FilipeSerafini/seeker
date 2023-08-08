import Foundation
import CloudKit

struct Folder: CKProtocol, Identifiable, Equatable {
    var record: CKRecord
    let id: String
    var books: [String]
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
        books: [String],
        description: String,
        name: String
    ) {
        
        let record = CKRecord(recordType: "Folder")
        
        record["id"] = UUID().uuidString
        record["books"] = books
        record["description"] = description
        record["name"] = name
        
        self.init(record: record)
    }
    
    init?(record: CKRecord) {
        let id = record["id"] as? String ?? ""
        let books = record["books"] as? [String] ?? []
        let description = record["description"] as? String ?? ""
        let name = record["name"] as? String ?? ""
        
        self.id = id
        self.books = books
        self.description = description
        self.name = name
        self.record = record
    }
    
    func updateRecordProperties() {
        record["id"] = id
        record["books"] = books
        record["description"] = description
        record["name"] = name
    }
}
