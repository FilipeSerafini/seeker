import Foundation
import CloudKit

protocol CKProtocol {
    init?(record: CKRecord)
    var record: CKRecord { get }
}
