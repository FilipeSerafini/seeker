import SwiftUI

struct OpenComment: View {
    @State private var originalComment = ""
    @State private var originalTitle = ""
    @State var comment: CommentReview
    @State private var onEdit: Bool = false
    @State private var isPresented: Bool = false
    @FocusState private var keyboardFocused: Bool
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @Environment (\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            VStack {
                if onEdit {
                    VStack(alignment: .leading) {
                        HStack {
                            VStack {
                                if let url = URL(string: comment.bookImageURL) {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                    } placeholder: {
                                        Image("bookImage")
                                            .resizable()
                                    }
                                } else {
                                    Image("bookImage")
                                }
                            }
                            .frame(width: 62, height: 88)
                            .cornerRadius(10)
                            .shadow(color: Color("shadowBook"), radius: 4, x: 2, y: 4)
                            
                            VStack(alignment: .leading) {
                                Text(comment.bookAuthor)
                                    .font(.system(size: 13))
                                    .textCase(.uppercase)
                                Text(comment.bookTitle)
                                    .font(.system(size: 22, weight: .medium, design: .serif))
                            }
                            Spacer()
                        }
                        .padding(.top, 30)
                        .padding(.horizontal)
                        Divider()
                            .padding(.horizontal)
                        
                        VStack(alignment: .leading) {
                            TextField("", text: $comment.commentTitle)
                                .textFieldStyle(.plain)
                                .font(.system(size: 22, weight: .medium, design: .serif))
                                .padding(.top, 4)
                                .focused($keyboardFocused)
                                    .onAppear {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            keyboardFocused = true
                                        }
                                    }
                            TextField("", text: $comment.comment, axis: .vertical)
                                .textFieldStyle(.plain)
                                .font(.system(size: 17))
                                .padding(.top,5)
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    VStack(alignment: .center) {
                        Button {
                            isPresented.toggle()
                        } label: {
                            ZStack {
                                Rectangle()
                                    .fill(.clear)
                                    .cornerRadius(22)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(lineWidth: 1)
                                            .fill(.red)
                                    }
                                    .frame(width: 126, height: 36)
                                HStack {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                    Text("Apagar nota")
                                        .font(.system(size: 13, weight: .regular))
                                        .foregroundColor(Color("text"))
                                }
                            }
                            .multilineTextAlignment(.center)
                            .padding(.bottom)
                        }
                        .alert("Tem certeza que deseja apagar essa nota?", isPresented: $isPresented) {
                            Button("Cancelar", role: .cancel, action: {})
                            Button("Apagar", role: .destructive,action: {
                                profileViewModel.deleteCommentReview(comment: comment)
                                dismiss()
                            })
                        } message: {
                            Text("Essa ação não poderá ser desfeita.")
                        }
                    }
                } else {
                    VStack(alignment: .leading) {
                        HStack{
                            VStack {
                                if let url = URL(string: comment.bookImageURL) {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                    } placeholder: {
                                        Image("bookImage")
                                            .resizable()
                                    }
                                } else {
                                    Image("bookImage")
                                }
                            }
                            .frame(width: 62, height: 88)
                            .cornerRadius(10)
                            .shadow(color: Color("shadowBook"), radius: 4, x: 2, y: 4)
                            
                            VStack(alignment: .leading) {
                                Text(comment.bookAuthor)
                                    .font(.system(size: 13))
                                    .textCase(.uppercase)
                                Text(comment.bookTitle)
                                    .font(.system(size: 22, weight: .medium, design: .serif))
                            }
                            Spacer()
                        }
                        .padding(.top, 30)
                        .padding(.horizontal)
                        Divider()
                            .padding(.horizontal)
                        
                        VStack(alignment: .leading) {
                            Text(comment.commentTitle)
                                .font(.system(size: 22, weight: .medium, design: .serif))
                                .padding(.vertical, 5)
                                .multilineTextAlignment(.leading)
                            Text(comment.comment)
                                .font(.system(size: 17))
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .background(
                Image("backgroundImage")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
            )
            .background(Color("backgroundColor"))
        }
        .onAppear {
            originalComment = comment.comment
            originalTitle = comment.commentTitle
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if onEdit {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        onEdit = false
                        originalComment = comment.comment
                        originalTitle = comment.commentTitle
                        profileViewModel.saveUserCommentReview(comment: comment)
                    } label: {
                        Image("saveFolder")
                    }
                    .disabled(!((comment.comment == originalComment) || (comment.commentTitle == originalTitle)))
                    .opacity((comment.comment != originalComment || comment.commentTitle != originalTitle) ? 1.0 : 0.6)
                }
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Editar nota")
                            .font(.system(size: 22, weight: .medium, design: .serif))
                    }
                }
            } else {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        onEdit = true
                    } label: {
                        Image("pencil")
                    }
                }
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text(comment.bookTitle)
                            .font(.system(size: 22, weight: .medium, design: .serif))
                    }
                }
            }
        }
    }
}
