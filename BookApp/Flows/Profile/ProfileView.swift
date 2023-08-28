import SwiftUI

struct ProfileView: View {
    @AppStorage("profilePhoto") var profilePhoto: Data = .init()
    @State private var myBio = UserDefaults.standard.value(forKey: "bio") as? String ?? ""
    @State private var myName = UserDefaults.standard.value(forKey: "name") as? String ?? ""
    //@State private var myUsername = UserDefaults.standard.value(forKey: "username") as? String ?? "username"
    @State private var combinedReviews: [AnyReview] = []
    @State private var alreadyShuffled = false
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @EnvironmentObject var ratingViewModel: RatingViewModel
    
    var body: some View {
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
        ]
        NavigationStack {
            VStack {
                VStack(spacing: 5) {
                    Image(uiImage: UIImage(data: self.profilePhoto) ?? UIImage(named: "person")!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 110, height: 110)
                        .clipShape(Circle())
                    //                                        Text ("@\(myUsername)")
                    //                                            .font(.system(size: 15))
                    //                                            .autocapitalization(.none)
                    //                                            .padding(.top, 5)
                    Text (myName)
                        .font(.system(size: 22, design: .serif))
                        .padding(.top, 5)
                    Text (myBio)
                        .frame(width: 300)
                        .font(.system(size: 15))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 10)
                }
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(combinedReviews) { review in
                            switch review {
                            case .rate(let rateReview):
                                if rateReview.rate != 0 {
                                    RatingView(review: rateReview)
                                }
                            case .comment(let commentReview):
                                MediumCommentButton(comment: commentReview)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: UserSettings(myName: $myName, myBio: $myBio), label: {
                            Image("pencil")
                        })
                    }
                }
            }
            .padding([.top, .horizontal])
            .background(
                Image("backgroundImage")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
            )
            .background(Color("backgroundColor"))
            .onAppear {
                if !alreadyShuffled {
                    let rateReviews = ratingViewModel.userRateReviews.map(AnyReview.rate)
                    let commentReviews = profileViewModel.userCommentReviews.map(AnyReview.comment)
                    combinedReviews = (rateReviews + commentReviews).shuffled()
                    self.alreadyShuffled = true
                }
            }
            .onChange(of: ratingViewModel.userRateReviews) { value in
                let rateReviews = ratingViewModel.userRateReviews.map(AnyReview.rate)
                let commentReviews = profileViewModel.userCommentReviews.map(AnyReview.comment)
                combinedReviews = (rateReviews + commentReviews).shuffled()
            }
            .onChange(of: profileViewModel.userCommentReviews) { value in
                let rateReviews = ratingViewModel.userRateReviews.map(AnyReview.rate)
                let commentReviews = profileViewModel.userCommentReviews.map(AnyReview.comment)
                combinedReviews = (rateReviews + commentReviews).shuffled()
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
