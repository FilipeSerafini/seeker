import Foundation
import CloudKit

struct User: CKProtocol {
    
    var record: CKRecord
    var id: String = UUID().uuidString
    var name: String
   // var username: String
    var bio: String
    var favoriteGenres: [String]
    var image: String
    var favoriteGenresForAPI: [String]
    
    //init para inicializar os atributos
    init() {
        id = UUID().uuidString
        name = ""
       // username = ""
        bio = ""
        favoriteGenres = []
        image = ""
        favoriteGenresForAPI = []
        
        self.record = CKRecord(recordType: "User")
    }
    
    
    //init para transformar os atributos em records para o banco, e determinar o recordType do usuario
    init?(
        id: String = UUID().uuidString,
        name: String,
       // username: String,
        bio: String,
        favoriteGenres: [String],
        favoriteGenresForAPI: [String]
       // image:,
        
    ) {
        
        let record = CKRecord(recordType: "User")
        
        record["id"] = id
        record["name"] = name
        //record["username"] = username
        record["bio"] = bio
        record["favoriteGenres"] = favoriteGenres
        record["favoriteGenresForAPI"] = favoriteGenresForAPI
        
        self.init(record: record)
    }
    
    //init para criar o objeto e atribuir o record a ele
    init?(record: CKRecord) {
        
        guard let id = record["id"] as? String else {return nil}
        guard let name = record["name"] as? String else {return nil}
       // guard let username = record["username"] as? String else {return nil}
        guard let bio = record["bio"] as? String else {return nil}
        guard let favoriteGenres = record["favoriteGenres"] as? [String] else {return nil}
        guard let favoriteGenresForAPI = record["favoriteGenresForAPI"] as? [String] else {return nil}
        
        self.id = id
        self.name = name
        //self.username = username
        self.bio = bio
        self.favoriteGenres = favoriteGenres
        self.image = ""
        self.favoriteGenresForAPI = favoriteGenresForAPI
        
        self.record = record
    }
}
