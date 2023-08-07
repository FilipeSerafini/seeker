import SwiftUI

struct ProfileView: View {
    
    
    var body: some View {
        VStack{
            NavigationStack {
                ZStack{
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color("Primary"))
                        .padding(.top, 200)
                        .ignoresSafeArea()
                    HStack{
                        Image("bookImage")
                            .resizable()
                            .frame(width: 110, height: 110)
                            .clipShape(Circle())
                    }
                    .padding(.bottom, 500)
                    
                    VStack{
                        Text ("@manuaraujo")
                            .font(.system(size: 17))
                        Text ("Manu Araujo")
                            .font(.system(size: 34, design: .serif))
                        Text ("Amo ler e viajar com amigos!")
                            .frame(width: 300)
                            .padding(.top, -30)
                            .font(.system(size: 15))
                            .padding()
                    }
                    .padding(.bottom, 240)
                    .multilineTextAlignment(.center)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button {
                            //ação do botão
                        }
                    label: {
                        Image("pencil")
                    }
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
