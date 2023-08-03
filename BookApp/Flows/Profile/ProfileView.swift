import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack{
            Text("Em breve...")
                .font(.system(size: 34, design: .serif))

//            ZStack{
//                RoundedRectangle(cornerRadius: 30)
//                    .fill(.gray)
//                    .padding(.top, 200)
//                    .ignoresSafeArea()
//                HStack{
//                    Image("profileImage")
//                        .resizable()
//                        .frame(width: 110, height: 110)
//                        .clipShape(Circle())
//
//                    //                    Image("profileImage")
//                    //                        .resizable()
//                    //                        .frame(width: 48, height: 48)
//                    //                        .clipShape(Circle())
//                }
//                .padding(.bottom, 500)
//
//                VStack{
//                    Text ("@username")
//                        .font(.system(size: 17))
//                    Text ("Actual name")
//                        .font(.system(size: 34, design: .serif))
//                    Text ("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.")
//                        .frame(width: 300)
//                        .padding(.top, -30)
//                        .font(.system(size: 15))
//                        .padding()
//                }
//                .padding(.bottom, 240)
//                .multilineTextAlignment(.center)
//            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
