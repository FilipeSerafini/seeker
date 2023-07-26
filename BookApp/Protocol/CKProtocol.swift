//
//  CKProtocol.swift
//  BookApp
//
//  Created by Filipe Serafini on 26/07/23.
//

import Foundation
import CloudKit

protocol CKProtocol {
    init?(record: CKRecord)
    var record: CKRecord { get }
}
