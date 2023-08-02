import Foundation
import CloudKit

struct User: CKProtocol {
    
    var record: CKRecord
    var id: String = UUID().uuidString
    var name: String
    var username: String
    var bio: String
    var badges: [CKRecord.Reference]
    var favoriteGenres: [String]
    var folders: [CKRecord.Reference]
    var goals: [CKRecord.Reference]
    var image: String
    var reviews: [CKRecord.Reference]
    
    //init para inicializar os atributos
    init() {
        id = UUID().uuidString
        name = ""
        username = ""
        bio = ""
        badges = []
        favoriteGenres = []
        folders = []
        goals = []
        image = ""
        reviews = []
        
        self.record = CKRecord(recordType: "User")
    }
    
    
    //init para transformar os atributos em records para o banco, e determinar o recordType do usuario
    init?(
        id: String,
        name: String,
        username: String,
        bio: String,
        badges: [CKRecord.Reference],
        favoriteGenres: [String],
        folders: [CKRecord.Reference],
        goals: [CKRecord.Reference],
//        image:,
        reviews: [CKRecord.Reference]
    ) {
        
        let record = CKRecord(recordType: "User")
        
        record["id"] = id
        record["name"] = name
        record["username"] = username
        record["bio"] = bio
        record["badges"] = badges
        record["favoriteGenres"] = favoriteGenres
        record["folders"] = folders
        record["goals"] = goals
//        record["image"] =
        record["reviews"] = reviews
        
        self.init(record: record)
    }
    
    //init para criar o objeto e atribuir o record a ele
    init?(record: CKRecord) {
        
        guard let id = record["id"] as? String else {return nil}
        guard let name = record["name"] as? String else {return nil}
        guard let username = record["username"] as? String else {return nil}
        guard let bio = record["bio"] as? String else {return nil}
        guard let badges = record["badges"] as? [CKRecord.Reference] else {return nil}
        guard let favoriteGenres = record["favoriteGenres"] as? [String] else {return nil}
        guard let folders = record["folders"] as? [CKRecord.Reference] else {return nil}
        guard let goals = record["goals"] as? [CKRecord.Reference] else {return nil}
//        guard let image = record["image"] as? String else {return nil}
        guard let reviews = record["reviews"] as? [CKRecord.Reference] else {return nil}
        
        self.id = id
        self.name = name
        self.username = username
        self.bio = bio
        self.badges = badges
        self.favoriteGenres = favoriteGenres
        self.folders = folders
        self.goals = goals
        self.image = ""
        self.reviews = reviews
        
        self.record = record
    }
}
