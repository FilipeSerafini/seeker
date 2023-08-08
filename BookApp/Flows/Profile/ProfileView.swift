import SwiftUI

struct ProfileView: View {
    var body: some View {
        
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
        ]
        NavigationStack {
            
            VStack{
                NavigationStack {
                    VStack{
                        Image("usuariaTeste")
                            .resizable()
                            .frame(width: 110, height: 110)
                            .clipShape(Circle())
                        Text ("@manuaraujo")
                            .font(.system(size: 17))
                        Text ("Manu Araujo")
                            .font(.system(size: 34, design: .serif))
                        Text ("Amo ler e viajar com amigos!")
                            .frame(width: 300)
                            .font(.system(size: 15))
                            .padding(.top, -16)
                    }
                    ScrollView{
                        LazyVGrid(columns: columns, spacing: 10) {
                            
                            //                            ForEach() { commentButton in
                            //                                SmallCommentButton(book: commentButton)
                            //                            }
                            
                            MediumCommentButton()
                            MediumCommentButton()
                            MediumCommentButton()
                            MediumCommentButton()
                            MediumCommentButton()
                            MediumCommentButton()
                            MediumCommentButton()
                            MediumCommentButton()
                            MediumCommentButton()
                            
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing){
                            
                            NavigationLink(destination: UserSettings(), label: {
                                Image("pencil")
                            })
                        }
                    }
                    
                }
            }
            .padding()
            .background(
                Image("backgroundImage")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
            )
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
