//
//  Goal.swift
//  BookApp
//
//  Created by Filipe Serafini on 26/07/23.
//

import Foundation
import CloudKit

struct Goal: CKProtocol {
    
    var record: CKRecord
    var id: String = UUID().uuidString
    var bookAmount: String
    var finalDate: Date
    var initialDate: Date
    var name: String
    
    init() {
        id = UUID().uuidString
        bookAmount = ""
        finalDate = Date()
        initialDate = Date()
        name = ""
        
        self.record = CKRecord(recordType: "Goal")
    }
    
    init?(
        id: String,
        bookAmount: String,
        finalDate: Date,
        initialDate: Date,
        name: String
    ) {
        
        let record = CKRecord(recordType: "Goal")
        
        record["id"] = id
        record["bookAmount"] = bookAmount
        record["finalDate"] = finalDate
        record["initialDate"] = initialDate
        record["name"] = name
        
        self.init(record: record)
    }
    
    init?(record: CKRecord) {
        
        guard let id = record["id"] as? String else { return nil }
        guard let bookAmount = record["bookAmount"] as? String else { return nil }
        guard let finalDate = record["finalDate"] as? Date else { return nil }
        guard let initialDate = record["initialDate"] as? Date else { return nil }
        guard let name = record["name"] as? String else { return nil }
        
        self.id = id
        self.bookAmount = bookAmount
        self.finalDate = finalDate
        self.initialDate = initialDate
        self.name = name
        self.record = record
    }
}
