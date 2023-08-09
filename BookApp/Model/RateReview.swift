//
//  RateReview.swift
//  BookApp
//
//  Created by Filipe Serafini on 09/08/23.
//

import Foundation
import CloudKit

struct RateReview: CKProtocol {
    
    var record: CKRecord
    var id: String = UUID().uuidString
    var rate: Int //estrelas
    var bookID: String
    
    //init para inicializar os atributos
    init() {
        id = UUID().uuidString
        rate = 0
        bookID = ""
        
        self.record = CKRecord(recordType: "RateReview")
    }
    
    
    //init para transformar os atributos em records para o banco, e determinar o recordType do usuario
    init?(
        id: String = UUID().uuidString,
        rate : Int,
        bookID: String
    ) {
        
        let record = CKRecord(recordType: "RateReview")
        
        record["id"] = id
        record["rate"] = rate
        record["bookdID"] = bookID
        
        self.init(record: record)
    }
    
    //init para criar o objeto e atribuir o record a ele
    init?(record: CKRecord) {
        
        guard let id = record["id"] as? String else {return nil}
        guard let rate = record["rate"] as? Int else {return nil}
        guard let bookID = record["bookID"] as? String else {return nil}
        
        
        self.id = id
        self.rate = rate
        self.bookID = bookID
        
        self.record = record
    }
    
}

