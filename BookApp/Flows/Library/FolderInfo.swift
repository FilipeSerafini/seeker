import SwiftUI

struct FolderInfo: Identifiable {
    var id = UUID().uuidString
    var name: String
    var image: String
//    var books: [String]
}

var folders: [FolderInfo] = [
    FolderInfo (name: "Leituras realizadas", image: "folderShapePurple"),
    FolderInfo (name: "Livros que eu quero ler", image: "folderShapeBlue"),
    FolderInfo (name: "Lendo agora", image: "folderShapePurple"),
]
