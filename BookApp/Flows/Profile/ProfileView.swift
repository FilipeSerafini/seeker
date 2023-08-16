import SwiftUI

struct ProfileView: View {
    @AppStorage("profileIcon") var profileIcon : Data = .init(count: 0)
    @State private var myName = UserDefaults.standard.value(forKey: "name") as? String ?? ""
    @State private var myUsername = UserDefaults.standard.value(forKey: "username") as? String ?? "@username"
    @State private var myBio = UserDefaults.standard.value(forKey: "bio") as? String ?? ""
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @EnvironmentObject var ratingViewModel: RatingViewModel
    var combinedReviews: [AnyReview] = []
    
    var body: some View {
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
        ]
        NavigationStack {
            VStack{
                VStack(spacing: 5){
                    Image(uiImage: UIImage(data: self.profileIcon) ?? UIImage(named: "person")!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 110, height: 110)
                        .clipShape(Circle())
                    Text ("@\(myUsername)")
                        .font(.system(size: 15))
                        .autocapitalization(.none)
                        .onChange(of: myUsername) { newValue in
                            let allowedCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_.-")
                            let filteredText = newValue.filter { allowedCharacterSet.contains(UnicodeScalar(String($0))!) }
                            myUsername = String(filteredText.prefix(10))
                        }
                    Text (myName)
                        .font(.system(size: 22, design: .serif))
                    Text (myBio)
                        .frame(width: 300)
                        .font(.system(size: 15))
                        .multilineTextAlignment(.center)
                }
                ScrollView(showsIndicators: false) {
                    var combinedReviews: [AnyReview] {
                        let rateReviews = ratingViewModel.userRateReviews.map(AnyReview.rate)
                        let commentReviews = profileViewModel.userCommentReviews.map(AnyReview.comment)
                        return (rateReviews + commentReviews).shuffled()
                    }
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(combinedReviews) { review in
                            switch review {
                            case .rate(let rateReview):
                                RatingView(review: rateReview)
                            case .comment(let commentReview):
                                MediumCommentButton(comment: commentReview)
                            }
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing){
                        NavigationLink(destination: UserSettings(myName: $myName, myUsername: $myUsername, myBio: $myBio), label: {
                            Image("pencil")
                        })
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
            .onAppear {
                if !profileViewModel.requestAlreadyMade {
                    profileViewModel.fetchUserData()
                }
                
                if !ratingViewModel.requestAlreadyMade {
                    ratingViewModel.fetchRateReviews()
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(ProfileViewModel())
            .environmentObject(RatingViewModel())
    }
}
