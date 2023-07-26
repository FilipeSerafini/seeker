import Foundation
import CloudKit

struct Review: CKProtocol {
    
    var record: CKRecord
    var id: String = UUID().uuidString
    var book: String
    var comment: String
    var rate: String
    
    //init para inicializar os atributos
    init() {
        id = UUID().uuidString
        book = ""
        comment = ""
        rate = ""
        
        self.record = CKRecord(recordType: "User")
    }
    
    
    //init para transformar os atributos em records para o banco, e determinar o recordType do usuario
    init?(
        id: String,
        book: String,
        comment: String,
        rate: String
    ) {
        
        let record = CKRecord(recordType: "User")
        
        record["id"] = id
        record["book"] = book
        record["comment"] = comment
        record["rate"] = rate
        
        self.init(record: record)
    }
    
    //init para criar o objeto e atribuir o record a ele
    init?(record: CKRecord) {
        
        guard let id = record["id"] as? String else {return nil}
        guard let book = record["book"] as? String else {return nil}
        guard let comment = record["comment"] as? String else {return nil}
        guard let rate = record["rate"] as? String else {return nil}
        
        
        self.id = id
        self.book = book
        self.comment = comment
        self.rate = rate
        
        self.record = record
    }
    
}
