//
//  Book.swift
//  BookApp
//
//  Created by Filipe Serafini on 26/07/23.
//

import Foundation
import CloudKit

struct Book: CKProtocol {
    var record: CKRecord
    
    var id: String = UUID().uuidString
    var author: String
    var genre: String
    var image: String
    var isbn: String
    var rating: String
    var sinopsis: String
    var title: String

    //init para inicializar os atributos
    init() {
        id = UUID().uuidString
        author = ""
        genre = ""
        image = ""
        isbn = ""
        rating = ""
        sinopsis = ""
        title = ""
        
        self.record = CKRecord(recordType: "Book")
    }
    
    //init para transformar os atributos em records para o banco, e determinar o recordType do usuario
    init?(
        id: String = UUID().uuidString,
        author: String,
        genre: String,
        //image: String
        isbn: String,
        rating: String,
        sinopsis: String,
        title: String
        
    ) {
        
        let record = CKRecord(recordType: "Book")
        
        record["id"] = id
        record["author"] = author
        record["genre"] = genre
        //record["image"] = image
        record["isbn"] = isbn
        record["rating"] = rating
        record["sinopsis"] = sinopsis
        record["title"] = title
        
        self.init(record: record)
    }
    
    //init para criar o objeto e atribuir o record a ele
    init?(record: CKRecord) {
        
        guard let id = record["id"] as? String else {return nil}
        guard let author = record["author"] as? String else {return nil}
        guard let genre = record["genre"] as? String else {return nil}
        guard let image = record["image"] as? String else {return nil}
        guard let isbn = record["isbn"] as? String else {return nil}
        guard let rating = record["rating"] as? String else {return nil}
        guard let sinopsis = record["sinopsis"] as? String else {return nil}
        guard let title = record["title"] as? String else {return nil}
        
        self.id = id
        self.author = author
        self.genre = genre
        self.image = ""
        self.isbn = isbn
        self.rating = rating
        self.sinopsis = sinopsis
        self.title = title
 
        
        self.record = record
    }

}
