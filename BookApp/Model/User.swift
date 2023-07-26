//
//  User.swift
//  BookApp
//
//  Created by Filipe Serafini on 26/07/23.
//

import Foundation
import CloudKit

struct User: CKProtocol {
    
    var id: String = UUID().uuidString
    var name: String
    var username: String
    var bio: String
    var badges: [String]
    var favoriteGenres: [String]
    var folders: [String]
    var goals: [String]
    var image: String
    var reviews: [String]
    
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
        badges: [String],
        favoriteGenres: [String],
        folders: [String],
        goals: [String],
//        image:,
        reviews: [String]
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
        guard let badges = record["badges"] as? [String] else {return nil}
        guard let favoriteGenres = record["favoriteGenres"] as? [String] else {return nil}
        guard let folders = record["folders"] as? [String] else {return nil}
        guard let goals = record["goals"] as? [String] else {return nil}
        guard let image = record["image"] as? String else {return nil}
        guard let reviews = record["reviews"] as? [String] else {return nil}
        
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
    
    var record: CKRecord
    
    
}
