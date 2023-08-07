import Foundation

struct FolderCard: Identifiable {
    
    var id = UUID().uuidString
    var name: String
    var image: String
    //    var books: [String]
}

var folders: [FolderCard] = [
    FolderCard (name: "Leituras realizadas", image: "folderShapePurple"),
    FolderCard (name: "Livros que eu quero ler", image: "folderShapeBlue"),
    FolderCard (name: "Lendo agora", image: "folderShapePurple"),
]
