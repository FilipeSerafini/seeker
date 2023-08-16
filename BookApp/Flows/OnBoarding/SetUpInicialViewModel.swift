//
//  SetUpInicialViewModel.swift
//  BookApp
//
//  Created by Waldyr Schneider on 15/08/23.
//

import Foundation
import CloudKit

class SetUpInicialViewModel: ObservableObject {
    func isUsernameUnique(username: String) -> Bool {
        print("verificando nome")
        let predicate = NSPredicate(format: "username == %@", username)
        let query = CKQuery(recordType: "User", predicate: predicate)
        
        var isUnique = true
        
        let semaphore = DispatchSemaphore(value: 0)
        
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { records, error in
            if let error = error {
                print("Erro ao verificar unicidade do nome de usuário:", error.localizedDescription)
                isUnique = false
            } else if let records = records, !records.isEmpty {
                print("achou usuario com esse nome: ", username)
                isUnique = false
            }
            
            semaphore.signal()
        }
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        print("nome unico: ", isUnique)
        return isUnique
    }
}
