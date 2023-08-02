//
//  FolderCRUD.swift
//  BookApp
//
//  Created by Filipe Serafini on 02/08/23.
//

import Foundation
import CloudKit
import Combine


class FolderCRUD: ObservableObject {
    
    var cancellables = Set<AnyCancellable>()
    
    
    func addFolder(folder: Folder) {
        
        CloudKitUtility.add(item: folder) { result in
            
        }
    }
    
}
