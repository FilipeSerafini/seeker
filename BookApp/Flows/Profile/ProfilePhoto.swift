import SwiftUI

struct ProfilePhoto: View {
    @AppStorage("profilePhoto") var profilePhoto : Data = .init()
    @State public var showingImagePickerOptions: Bool = false
    @State private var showingImagePickerView = false
    @State private var showingCameraPickerView = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Button {
                    self.showingImagePickerOptions
                .toggle()
                } label: {
                    VStack {
                        Image(uiImage: UIImage(data: self.profilePhoto) ?? UIImage(named: "person")!)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 110, height: 110)
                            .clipShape(Circle())
                    }
                }
                .padding(.bottom, 5)
            }
        }
        .padding()
        .confirmationDialog("Como você deseja adicionar sua foto?", isPresented: $showingImagePickerOptions, titleVisibility: .visible) {
            Button("Câmera") { showingCameraPickerView = true }
            Button("Galeria") { showingImagePickerView = true }
            Button("Cancelar", role: .cancel, action: {})
        }
        .sheet(isPresented: self.$showingCameraPickerView) {
            PhotoPicker(image: self.$profilePhoto, sourceType: .camera)
        }
        .sheet(isPresented: self.$showingImagePickerView) {
            PhotoPicker(image: self.$profilePhoto, sourceType: .photoLibrary)
        }
    }
}

struct ProfilePhoto_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhoto()
    }
}
