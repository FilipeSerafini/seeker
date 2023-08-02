//
//  CloudKitUtility.swift
//  BookApp
//
//  Created by Filipe Serafini on 02/08/23.
//

import Foundation
import CloudKit
import Combine

class CloudKitUtility {
    
    enum CloudKitError: String, LocalizedError {
        case iCloudAccountNotFound
        case iCloudAccountNotDetermined
        case iCloudAccountRestricted
        case iClouldAccountUnknown
        case iCloudApplicationPermissionNotGranted
        case iCloudCouldNotFetchUserRecordID
        case iCloudCouldNotDiscoverUser
    }
    
}

// MARK: USER FUNCTIONS
extension CloudKitUtility {
    
    static private func getiCloudStatus(completion: @escaping (Result<Bool, Error>) -> ()) {
        CKContainer.default().accountStatus { returnedStatus, returnedError in
            switch returnedStatus {
            case .available:
                completion(.success(true))
            case .noAccount:
                completion(.failure(CloudKitError.iCloudAccountNotFound))
            case .couldNotDetermine:
                completion(.failure(CloudKitError.iCloudAccountNotDetermined))
            case .restricted:
                completion(.failure(CloudKitError.iCloudAccountRestricted))
            default:
                completion(.failure(CloudKitError.iClouldAccountUnknown))
            }
        }
    }
    
    static func getiCloudStatus() -> Future<Bool, Error> {
        Future { promise in
            CloudKitUtility.getiCloudStatus { result in
                promise(result)
                
            }
            
        }
    }
    
    
    static private func requestApplicationPermission(completion: @escaping (Result<Bool, Error>) -> ()) {
        CKContainer.default().requestApplicationPermission([.userDiscoverability]) { returnedStatus, returnedError in
            if returnedStatus == .granted {
                completion(.success(true))
            } else {
                completion(.failure(CloudKitError.iCloudApplicationPermissionNotGranted))
            }
        }
    }
    
    static func requestApplicationPermission() -> Future<Bool, Error> {
        Future { promise in
            CloudKitUtility.requestApplicationPermission { result in
                promise(result)
                
            }
            
        }
    }
    
    static func fetchUserRecordID(completion: @escaping (Result<CKRecord.ID, Error>) -> ()) {
        CKContainer.default().fetchUserRecordID { returnedID, returnedError in
            if let id = returnedID {
                completion(.success(id))
            } else {
                completion(.failure(CloudKitError.iCloudCouldNotFetchUserRecordID))
            }
        }
    }
    
    static private func discoverUserIdentity(id: CKRecord.ID, completion: @escaping (Result<String, Error>) -> ()) {
        CKContainer.default().discoverUserIdentity(withUserRecordID: id) { returnedIdentity, returnedError in
            if let name = returnedIdentity?.nameComponents?.givenName {
                completion(.success(name))
            } else {
                completion(.failure(CloudKitError.iCloudCouldNotDiscoverUser))
            }
        }
    }
    
    static private func discoverUserIdentity(completion: @escaping (Result<String, Error>) -> ()) {
        fetchUserRecordID { fetchCompletion in
            switch fetchCompletion {
            case .success(let recordID):
                CloudKitUtility.discoverUserIdentity(id: recordID, completion: completion)
            case .failure(let error):
                completion(.failure(error))
                
            }
        }
    }
    
    static func discoverUserIdentity() -> Future<String, Error> {
        Future { promise in
            CloudKitUtility.discoverUserIdentity { result in
                promise(result)
                
            }
            
        }
    }
    
    
}


// MARK: CRUD FUNCTIONS
extension CloudKitUtility {
    
    //chumiga tinha feito outro fetch com a reference
    
    static func fetch<T:CKProtocol>(
        predicate: NSPredicate,
        recordType: CKRecord.RecordType,
        sortDescriptors: [NSSortDescriptor]? = nil,
        resultsLimit: Int? = nil
    ) -> Future<[T], Error> {
        Future { promise in
            CloudKitUtility.fetch(predicate: predicate, recordType: recordType, sortDescriptors: sortDescriptors, resultsLimit: resultsLimit)
            { (items: [T]) in
                promise(.success(items))
                
            }
        }
    }
    
    static func fetch<T:CKProtocol>(
        predicate: NSPredicate,
        recordType: CKRecord.RecordType,
        sortDescriptors: [NSSortDescriptor]? = nil,
        resultsLimit: Int? = nil,
        completion: @escaping ((Result<[T], Error>) -> Void)
    ) {
        CloudKitUtility.fetch(predicate: predicate, recordType: recordType, sortDescriptors: sortDescriptors, resultsLimit: resultsLimit) { (items: [T]) in
            completion(.success(items))
        }
    }
    
    static private func fetch<T:CKProtocol>(
        predicate: NSPredicate,
        recordType: CKRecord.RecordType,
        sortDescriptors: [NSSortDescriptor]? = nil,
        resultsLimit: Int? = nil,
        completion: @escaping(_ items: [T]) -> ()) {
        
        //Create operation
        let operation = createOperation(predicate: predicate, recordType: recordType, sortDescriptors: sortDescriptors, resultsLimit: resultsLimit)
        
        //Get items in query
        var returnedItems: [T] = []
        addRecordMatchedBlock(operation: operation) { item in
            returnedItems.append(item)
        }
        
        //Query compeltion
        addQueryResultBlock(operation: operation) { finished in
            completion(returnedItems)
        }

        
        //Execute operation
        addOperation(operation: operation)

    }
    
    static private func createOperation(
        predicate: NSPredicate,
        recordType: CKRecord.RecordType,
        sortDescriptors: [NSSortDescriptor]? = nil,
        resultsLimit: Int? = nil
    ) -> CKQueryOperation {
        
        //let predicate = NSPredicate(format: "name = %@", argumentArray: ["Goiaba"])
        let query = CKQuery(recordType: recordType, predicate: predicate) //query em si, especifica o tipo de record a ser procurado (recordType) e procura
        query.sortDescriptors = sortDescriptors
        let queryOperation = CKQueryOperation(query: query) //operacao que faz a busca de uma query
        
        if let limit = resultsLimit {
            queryOperation.resultsLimit = limit
        }
        
        return queryOperation
    }
    
    static private func addRecordMatchedBlock<T:CKProtocol>(operation: CKQueryOperation, completion: @escaping (_ item: T) -> ()) {
        //operacao que executa cada vez que um dado (record) procurado eh encontrado, retorna o ID do item, e o dado (record)
        //depois pega o nome e adiciona ao array de itens
        operation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
            switch returnedResult {
            case .success(let record):
                guard let item = T(record: record) else { return }
                completion(item)
                
            case .failure(let error):
                print("Error recordMatchedBlock: \(error)")
            }
        }
    }
    
    static private func addQueryResultBlock(operation: CKQueryOperation, completion: @escaping (_ finished: Bool) -> ()) {
        //completion block, quando a queryOperation termina devemos pegar o seu retorno e adicionar ao array que  vai aparecer na tela
        operation.queryResultBlock = { returnedResult in
            completion(true)
        }

    }
    
    //puxar do banco a informacao
    //para pegar algo do banco, precisamos adicionar uma operacao (por ex: operacao de busca)
    static private func addOperation(operation: CKDatabaseOperation) {
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    static func add<T:CKProtocol>(item: T, completion: @escaping (Result<Bool, Error>) -> ()) {
        
        //Get record from generic item
        let record = item.record
        
        //Save to CloudKit
        save(record: record, completion: completion)
    }
    
    static func update<T:CKProtocol>(item: T, completion: @escaping (Result<Bool, Error>) -> ()) {
        
        add(item: item, completion: completion)
    }
    
    static func save(record: CKRecord, completion: @escaping (Result<Bool, Error>) -> ()) {
        CKContainer.default().publicCloudDatabase.save(record) { returnedRecord, returnedError in
            if let error = returnedError {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    static private func delete(record: CKRecord, completion: @escaping (Result<Bool, Error>) -> ()) {
        CKContainer.default().publicCloudDatabase.delete(withRecordID: record.recordID) { returnedRecordID, returnedError in
            if let error = returnedError {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    static private func delete<T:CKProtocol>(item: T, completion: @escaping (Result<Bool, Error>) -> ()) {
        CloudKitUtility.delete(record: item.record, completion: completion)
    }
    
    static func delete<T:CKProtocol>(item: T) -> Future<Bool, Error>{
        Future { promise in
            CloudKitUtility.delete(item: item, completion: promise)
        }
    }
}
