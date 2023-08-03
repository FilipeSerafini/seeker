import SwiftUI
import CloudKit

class LibraryViewModel: ObservableObject {
    
    // MARK: - Variables
    
    @State var presentAlert = false
    @State var newFolderName = ""
    
    @Published var folders: [Folder] = []
    var userRecordID: CKRecord.ID?
    
    // MARK: - Init
    
    init() {
        fetchAllFolders()
    }
    
    // MARK: - Setup
    
    func fetchAllFolders() {
        CloudKitUtility.fetchUserRecordID { (result: Result<CKRecord.ID, Error>) in
            switch result {
            case .success(let recordID):
                self.userRecordID = recordID
                print("JORGE ", recordID.recordName)
                self.fetchAllFoldersWith(recordID: recordID)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    // MARK: - Functions
    
    func fetchAllFoldersWith(recordID: CKRecord.ID) {
        let reference = CKRecord.Reference(recordID: recordID, action: .none)
        let predicate = NSPredicate(format: "creatorUserRecordID == %@", reference)
        let recordType = "Folder"
        
        CloudKitUtility.fetch(predicate: predicate, recordType: recordType) { (result: Result<[Folder], Error>) in
            switch result {
            case .success(let folders):
                print("JORGE retornou \(folders.count)")
                DispatchQueue.main.async {
                    self.folders = folders
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func createFolder(folderName: String) {
        
        guard let newFolder = Folder(id: "1", books: [], description: "", name: folderName) else { return }
        
        CloudKitUtility.add(item: newFolder) { result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.fetchAllFolders()
            }
        }
    }
}
