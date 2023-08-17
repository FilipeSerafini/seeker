import SwiftUI
import CloudKit

class UserManager: ObservableObject {
    
    // MARK: - Variables
    
    @Published var id: String = ""
    @Published var folders: [Folder] = []
    @Published var rateReviews: [RateReview] = []
    @Published var userAlreadyOnCK: Bool = false
    
    
    // MARK: - Init
    
    init() {
        fetchFolders()
        checkUserAlreadyOnCK()
    }
    
    // MARK: - Functions
    
    func fetchFolders() {
        CloudKitUtility.fetchUserRecordID { (result: Result<CKRecord.ID, Error>) in
            switch result {
            case .success(let recordID):
                DispatchQueue.main.async {
                    self.id = recordID.recordName
                }
                self.fetchAllFoldersWith(recordID: recordID)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func fetchAllFoldersWith(recordID: CKRecord.ID) {
        let reference = CKRecord.Reference(recordID: recordID, action: .none)
        let predicate = NSPredicate(format: "creatorUserRecordID == %@", reference)
        let recordType = "Folder"
        
        CloudKitUtility.fetch(predicate: predicate, recordType: recordType) { (result: Result<[Folder], Error>) in
            switch result {
            case .success(let folders):
                DispatchQueue.main.async {
                    self.folders = folders
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func createFolder(folderName: String) {
        guard let newFolder = Folder(books: [], description: "", name: folderName) else { return }
        folders.append(newFolder)
        
        CloudKitUtility.add(item: newFolder) { result in
            switch result {
            case .success(_):
                break
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func updateFolders(folders: [Folder], completion: @escaping () -> ())  {
        
        folders.forEach { folder in
            guard let folderIndex = folders.firstIndex(of: folder) else { return }
            
            let updatedFolder = folders[folderIndex]
            
            updatedFolder.updateRecordProperties()
            
            CloudKitUtility.add(item: updatedFolder) { result in
                switch result {
                case .success(_):
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
                completion()
                
            }
        }
    }
    
    func checkUserAlreadyOnCK() {
        CloudKitUtility.fetchUserRecordID { (result: Result<CKRecord.ID, Error>) in
            switch result {
            case .success(let recordID):
                DispatchQueue.main.async {
                    self.id = recordID.recordName
                }
                self.fetchUserWith(recordID: recordID)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func fetchUserWith(recordID: CKRecord.ID) {
        let reference = CKRecord.Reference(recordID: recordID, action: .none)
        let predicate = NSPredicate(format: "creatorUserRecordID == %@", reference)
        let recordType = "User"
        
        CloudKitUtility.fetch(predicate: predicate, recordType: recordType) { (result: Result<[User], Error>) in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.userAlreadyOnCK = user.isEmpty ? false: true
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    //    func fetchRateReviewWith(recordID: CKRecord.ID) {
    //        let reference = CKRecord.Reference(recordID: recordID, action: .none)
    //        let predicate = NSPredicate(format: "creatorUserRecordID == %@", reference)
    //        let recordType = "RateReview"
    //
    //        CloudKitUtility.fetch(predicate: predicate, recordType: recordType) { (result: Result<[RateReview], Error>) in
    //            switch result {
    //            case .success(let userRateReviews):
    //                DispatchQueue.main.async {
    //                    self.rateReviews = userRateReviews
    //                }
    //            case .failure(let failure):
    //                print(failure.localizedDescription)
    //            }
    //        }
    //
    //        print(rateReviews)
    //    }
    
}


