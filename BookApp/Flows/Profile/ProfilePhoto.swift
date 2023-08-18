import SwiftUI

struct ProfilePhoto: View {
    @AppStorage("profileIcon") var profileIcon : Data = .init(count: 0)
    @State public var iconPicker : Bool = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Button {
                    self.iconPicker.toggle()
                } label: {
                    VStack {
                        if self.profileIcon.count != 0  {
                            Image(uiImage: UIImage(data: self.profileIcon)!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 110, height: 110)
                                .clipShape(Circle())
                        } else {
                            Image("person")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 110, height: 110)
                                .clipShape(Circle())
                        }
                    }
                }
                .padding(.bottom, 5)
            }
        }
        .padding()
        .sheet(isPresented: self.$iconPicker) {
            PhotoPicker(show: self.$iconPicker, image: self.$profileIcon)
        }
    }
}

struct ProfilePhoto_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhoto()
    }
}
