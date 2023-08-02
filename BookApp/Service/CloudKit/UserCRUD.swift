//
//  UserCRUD.swift
//  BookApp
//
//  Created by Filipe Serafini on 02/08/23.
//

import SwiftUI
import Combine
import CloudKit

class UserCRUD: ObservableObject {
        
    @Published var permissionStatus: Bool = false
    @Published var isSignedInToiCloud: Bool = false
    @Published var error: String = ""
    @Published var userName: String = ""
    @Published var userID: String = ""
    @Published var userRecordID: CKRecord.ID?
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getiCloudStatus() //pegar o status da conta do icloud, se logou ou nao
        requestPermission() //pedir permissao ao usuario para pegar sua informacao
        setUserID() //guardar o id do usuario
        getCurrentUserName() //depois de ter logado pegar o id necessario para pegar o userName
        
        
    }
    
    func addUserToCK() {
        
    }
    
    func fetchUsers() {
        
    }
    
    
    private func getiCloudStatus(){
        
        CloudKitUtility.getiCloudStatus()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] success in
                self?.isSignedInToiCloud = success
            }
            .store(in: &cancellables)

    }
    
    
    //funcao para pedir permissao ao usuario para pegar a identidade
    func requestPermission() {
        
        CloudKitUtility.requestApplicationPermission()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] success in
                self?.permissionStatus = success
            }
            .store(in: &cancellables)

    }
    
    func getCurrentUserName() {
        CloudKitUtility.discoverUserIdentity()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] returnedName in
                self?.userName = returnedName
                UserDefaults.standard.set(returnedName, forKey: "userName")
            }
            .store(in: &cancellables)
    }
    
    static func setUserName(userName: String) {
        UserDefaults.standard.set(userName, forKey: "userName")
    }
    
    static func getUserName() -> String {
        return UserDefaults.standard.string(forKey: "userName") ?? "No Name"
    }
    
    func setUserID() {
        
        CloudKitUtility.fetchUserRecordID { fetchCompletion in
            switch fetchCompletion {
            case .success(let userRecordID):
                DispatchQueue.main.async {
                    self.userID = userRecordID.recordName
                    self.userRecordID = userRecordID
                    UserDefaults.standard.set(self.userID, forKey: "userID")
                }

            case .failure(let error):
                print(error)
            }
        }

    }

    static func getUserID() -> String {
        return UserDefaults.standard.string(forKey: "userID") ?? "No ID"
    }

}

struct CloudKitUserBootcamp: View {

    @StateObject private var vm = UserCRUD()

    var body: some View {
        VStack {
            Text("IS SIGNED IN: \(vm.isSignedInToiCloud.description.uppercased())")
            Text(vm.error)
            Text("Permission: \(vm.permissionStatus.description.uppercased())")
            Text("NAME: \(vm.userName)")
            Text(UserCRUD.getUserID())
        }
    }
}

struct CloudKitUserBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CloudKitUserBootcamp()
    }
}





//    func fetchiCloudUserRecordID() {
//        CKContainer.default().fetchUserRecordID { [weak self] returnedID, returnedError in
//            if let id = returnedID {
////                self?.userID = id
//            }
//        }
//    }
