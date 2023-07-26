import Foundation
import CloudKit

struct Badge: CKProtocol {
    
    var record: CKRecord
    var id: String = UUID().uuidString
    var name: String
    //    var image: String
    var description: String
    
    
    //init para inicializar os atributos
    init() {
        id = UUID().uuidString
        name = ""
        //        image = ""
        description = ""
        
        self.record = CKRecord(recordType: "User")
    }
    
    
    //init para transformar os atributos em records para o banco, e determinar o recordType do usuario
    init?(
        id: String,
        name: String,
        //        image: String,
        description: String
        
    ) {
        
        let record = CKRecord(recordType: "User")
        
        record["id"] = id
        record["name"] = name
        //        record["image"] = bio
        record["description"] = description
        
        self.init(record: record)
    }
    
    //init para criar o objeto e atribuir o record a ele
    init?(record: CKRecord) {
        
        guard let id = record["id"] as? String else {return nil}
        guard let name = record["name"] as? String else {return nil}
        //        guard let image = record["image"] as? String else {return nil}
        guard let description = record["description"] as? String else {return nil}
        
        self.id = id
        self.name = name
        //        self.image = image
        self.description = description
        
        self.record = record
    }
    
}
