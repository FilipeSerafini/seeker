import SwiftUI

struct SearchableView: View {
    private let spaceName = "scroll"
    @State private var scrollViewSize: CGSize = .zero
    @State private var wholeSize: CGSize = .zero
    @State private var searchText = ""
    @State private var isEditing: Bool = false
    @State var selectedFilter: Filter = .empty
    @State private var isShowingProgressView = false
    @State var isPresented = false
    @EnvironmentObject private var searchViewModel: SearchViewModel
    
    var body: some View {
        ChildSizeReader(size: $wholeSize) {
            ScrollView(showsIndicators: false) {
                ChildSizeReader(size: $scrollViewSize) {
                    VStack(alignment: .leading) {
                        //MARK: Search Bar
                        HStack {
                            HStack {
                                TextField("Procure por livros, autores e ISBN", text: $searchText, onEditingChanged: { editing in
                                    isEditing = editing
                                    isShowingProgressView = false
                                })
                                .onSubmit {
                                    if searchText != "" {
                                        searchViewModel.fetchBooks(searchedText: searchText, filter: selectedFilter)
                                    }
                                }
                                .padding(15)
                                .font(.system(size: 16))
                                .foregroundColor(Color("foregroundSearch"))
                            }
                            .padding(.trailing, 20)
                            .background(Color("textField"))
                            .cornerRadius(30)
                            .overlay(
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        searchViewModel.fetchBooks(searchedText: searchText, filter: selectedFilter)
                                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                    }) {
                                        Image("magnifyingGlassColors")
                                            .padding(.trailing, 20)
                                    }
                                    .disabled(searchText == "")
                                    .opacity(searchText == "" ? 0.6 : 1)
                                }
                            )
                            .padding(.vertical, 5)
                        }
                        .padding(.horizontal)
                        
                        VStack {
                            HStack {
                                Button(action: {
                                    selectedFilter = .title
                                }) {
                                    Text("Título")
                                }.buttonStyle(
                                    CustomButtonFilter(
                                        isSelected: Binding(get: { selectedFilter == .title }, set: { newValue in
                                            if newValue {
                                                selectedFilter = .title
                                            } else {
                                                selectedFilter = .empty
                                            }
                                        })))
                                
                                Button(action: {
                                    selectedFilter = .author
                                }) {
                                    Text("Autor")
                                }.buttonStyle(CustomButtonFilter(
                                    isSelected: Binding(get: { selectedFilter == .author }, set: { newValue in
                                        if newValue {
                                            selectedFilter = .author
                                        } else {
                                            selectedFilter = .empty
                                        }
                                    })))
                                
                                Button(action: {
                                    selectedFilter = .genre
                                }) {
                                    Text("ISBN")
                                }.buttonStyle(
                                    CustomButtonFilter(
                                        isSelected: Binding(get: { selectedFilter == .isbn }, set: { newValue in
                                            if newValue {
                                                selectedFilter = .isbn
                                            } else {
                                                selectedFilter = .empty
                                            }
                                        })))
                            }
                        }
                        .padding(.bottom, 40)
                        .padding([.leading, .trailing])
                        
                        if searchViewModel.isSearching == true && searchViewModel.books.isEmpty {
                            HStack {
                                Spacer()
                                Loading()
                                    .frame(width: 200, height: 200)
                                    .foregroundColor(Color("primary"))
                                Spacer()
                            }
                            .padding(.top, 70)
                        } else if !isEditing && searchText == "" {
                            RecommendedView()
                        } else if !isEditing {
                            if searchViewModel.returnEmpty == true {
                                VStack(alignment: .center){
                                    Image("emptyStateSearch")
                                        .resizable()
                                        .frame(width: 350, height: 225)
                                    Text("Infelizmente não encontramos resultados para a sua busca. Que tal procurar por algo diferente?")
                                        .font(.system(size: 15))
                                        .multilineTextAlignment(.center)
                                }
                                .padding()
                            } else {
                                ForEach(searchViewModel.books) { book in
                                    ResearchedBookView(book: book)
                                }
                            }
                        }
                        
                        if isShowingProgressView && !searchViewModel.books.isEmpty && isEditing == false {
                            HStack{
                                Spacer()
                                ProgressView()
                                    .tint(Color("primary"))
                                Spacer()
                            }
                            .padding(.bottom)
                        }
                    }
                    .background(
                        GeometryReader { proxy in
                            Color.clear.preference(
                                key: ViewOffsetKey.self,
                                value: -1 * proxy.frame(in: .named(spaceName)).origin.y
                            )
                        }
                    )
                    .onPreferenceChange(
                        ViewOffsetKey.self,
                        perform: { value in
                            if value > scrollViewSize.height - wholeSize.height {
                                if !searchText.isEmpty {
                                    searchViewModel.fetchBooks(searchedText: searchText, filter: selectedFilter)
                                    isShowingProgressView = true
                                } else {
                                    isShowingProgressView = false
                                }
                            }
                        }
                    )
                }
            }
            .background(
                Image("backgroundImage")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
            )
            .background(Color("backgroundColor"))
            .coordinateSpace(name: spaceName)
        }
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct ChildSizeReader<Content: View>: View {
    @Binding var size: CGSize
    
    let content: () -> Content
    var body: some View {
        ZStack {
            content().background(
                GeometryReader { proxy in
                    Color.clear.preference(
                        key: SizePreferenceKey.self,
                        value: proxy.size
                    )
                }
            )
        }
        .onPreferenceChange(SizePreferenceKey.self) { preferences in
            self.size = preferences
        }
    }
}

struct SizePreferenceKey: PreferenceKey {
    typealias Value = CGSize
    static var defaultValue: Value = .zero
    
    static func reduce(value _: inout Value, nextValue: () -> Value) {
        _ = nextValue()
    }
}
