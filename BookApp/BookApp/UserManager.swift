import SwiftUI
import CloudKit

class UserManager: ObservableObject {
    
    // MARK: - Variables
    @Published var id: String = ""
    @Published var folders: [Folder] = []
    @Published var rateReviews: [RateReview] = []
    @Published var userAlreadyOnCK: Bool = false
    @Published var selectedGenresForAPI: [String] = []
    @Published var selectedGenresUser: [String] = []
    
    
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
                    self.fetchAllFoldersWith(recordID: recordID)
                }
            case .failure(let failure):
                print("error trying to fetch folder: ", failure.localizedDescription)
            }
        }
    }
    
    private func fetchAllFoldersWith(recordID: CKRecord.ID) {
        let reference = CKRecord.Reference(recordID: recordID, action: .none)
        let predicate = NSPredicate(format: "creatorUserRecordID == %@", reference)
        let recordType = "Folder"
        
        CloudKitUtility.fetch(predicate: predicate, recordType: recordType) { (result: Result<[Folder], Error>) in
            switch result {
            case .success(let folders):
                DispatchQueue.main.async {
                    self.folders = folders
                    self.folders = self.sortFolders(folders: self.folders)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func createFolder(folderName: String, description: String) {
        guard let newFolder = Folder(books: [], description: description, name: folderName) else { return }
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
        for folder in folders {
            self.folders.removeAll(where: { $0.id == folder.id})
            self.folders.append(folder)
        }
        folders.forEach { folder in
            guard let folderIndex = folders.firstIndex(of: folder) else { return }
            
            let updatedFolder = folders[folderIndex]
            
            updatedFolder.updateRecordProperties()
            
            CloudKitUtility.add(item: updatedFolder) { result in
                switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        self.folders = self.sortFolders(folders: self.folders)
                    }
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
                self.fetchUserWith(recordID: recordID) { userFound in
                    self.selectedGenresForAPI = userFound.favoriteGenresForAPI
                    self.selectedGenresUser = userFound.favoriteGenres
                    UserDefaults.standard.set(userFound.name, forKey: "name")
                    UserDefaults.standard.set(userFound.bio, forKey: "bio")
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func fetchUserWith(recordID: CKRecord.ID, completion: @escaping (_ user: User) -> ()) {
        let reference = CKRecord.Reference(recordID: recordID, action: .none)
        let predicate = NSPredicate(format: "creatorUserRecordID == %@", reference)
        let recordType = "User"
        
        CloudKitUtility.fetch(predicate: predicate, recordType: recordType) { (result: Result<[User], Error>) in
            switch result {
            case .success(let users):
                DispatchQueue.main.async {
                    self.userAlreadyOnCK = users.isEmpty ? false: true
                    if !users.isEmpty {
                        let userFound = users[0]
                        completion(userFound)
                    }
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func updateUser(name: String, bio: String) {
        CloudKitUtility.fetchUserRecordID { (result: Result<CKRecord.ID, Error>) in
            switch result {
            case .success(let recordID):
                DispatchQueue.main.async {
                    self.id = recordID.recordName
                    
                    self.fetchUserWith(recordID: recordID, completion: { userFound in
                        userFound.record["name"] = name
                        userFound.record["bio"] = bio
                        
                        CloudKitUtility.update(item: userFound) { result in
                            switch result {
                            case .success(_):
                                break
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }
                    })
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    private func sortFolders(folders: [Folder]) -> [Folder] {
        let desiredOrder = ["Lendo agora", "Livros que quero ler", "Leituras realizadas"]
        
        var firstThreeFolders: [Folder] = []
        var remainingFolders: [Folder] = []
        for folder in folders {
            if let index = desiredOrder.firstIndex(of: folder.name) {
                if index < 3 {
                    firstThreeFolders.append(folder)
                } else {
                    remainingFolders.append(folder)
                }
            } else {
                remainingFolders.append(folder)
            }
        }
        
        firstThreeFolders.sort { folder1, folder2 in
            guard let index1 = desiredOrder.firstIndex(of: folder1.name),
                  let index2 = desiredOrder.firstIndex(of: folder2.name) else {
                return false
            }
            return index1 < index2
        }

        remainingFolders.sort { folder1, folder2 in
            if let date1 = folder1.record.creationDate, let date2 = folder2.record.creationDate {
                return date1.compare(date2) == .orderedAscending
            }
            return false
        }
        
        return firstThreeFolders + remainingFolders
    }
}
