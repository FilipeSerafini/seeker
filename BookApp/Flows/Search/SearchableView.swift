import SwiftUI

struct SearchableView: View {
    private let spaceName = "scroll"
    @State private var scrollViewSize: CGSize = .zero
    @State private var wholeSize: CGSize = .zero
    @State private var searchText = ""
    @State private var isEditing: Bool = false
    
    @State var selectedFilter: Filter = .empty
    
    @Environment(\.colorScheme) var scheme
    @EnvironmentObject private var searchViewModel: SearchViewModel
    
    var body: some View {
        ChildSizeReader(size: $wholeSize) {
            ScrollView {
                ChildSizeReader(size: $scrollViewSize) {
                    VStack(alignment: .leading) {
                        // Search Bar
                        HStack {
                            TextField("Procure por livros, autores e gêneros", text: $searchText, onEditingChanged: { editing in
                                isEditing = editing
                            })
                            .onSubmit {
                                if searchText != ""{
                                    searchViewModel.fetchBooks(searchedText: searchText, filter: selectedFilter)
                                }
                            }
                            .padding(15)
                            .font(.system(size: 17))
                            .foregroundColor(Color(red: 0.255, green: 0.255, blue: 0.255))
                        }
                        .padding(.trailing, 20)
                        .background(scheme == .light ? Color(red: 0.8509803921568627, green: 0.8509803921568627, blue: 0.8509803921568627) : Color(red: 0.14901960784313725, green: 0.14901960784313725, blue: 0.14901960784313725))
                        .cornerRadius(30)
                        .padding(.horizontal)
                        .overlay(
                            HStack {
                                Spacer()
                                Button(action: {
                                    searchViewModel.fetchBooks(searchedText: searchText, filter: selectedFilter)
                                }) {
                                    Image("searchIconSelected")
                                        .padding(.trailing, 25)
                                }
                                .disabled(searchText == "")
                                .opacity(searchText == "" ? 0.6 : 1)
                            }
                        )
                        .padding(.vertical, 5)
                        
                        VStack{
                            HStack {
                                Button(action: {
                                    selectedFilter = .title
                                }) {
                                    Text("Título")
                                }.buttonStyle(
                                    StyleFilterButton(
                                        isFilled: Binding(get: { selectedFilter == .title },
                                                          set: { newValue in
                                                              if newValue {
                                                                  selectedFilter = .title
                                                              } else {
                                                                  selectedFilter = .title
                                                              }
                                                          })))
                                
                                Button(action: {
                                    selectedFilter = .author
                                }) {
                                    Text("Autor")
                                }.buttonStyle(StyleFilterButton(isFilled: Binding(get: { selectedFilter == .author }, set: { newValue in
                                    if newValue {
                                        selectedFilter = .author
                                    } else {
                                        selectedFilter = .author
                                    }
                                })))
                                
                                Button(action: {
                                    selectedFilter = .genre
                                }) {
                                    Text("Gênero")
                                }.buttonStyle(
                                    StyleFilterButton(
                                        isFilled: Binding(get: { selectedFilter == .genre },
                                                          set: { newValue in
                                                              if newValue {
                                                                  selectedFilter = .genre
                                                              } else {
                                                                  selectedFilter = .genre
                                                              }
                                                          })))
                            }
                        }
                        .padding(.bottom, 40)
                        .padding([.leading, .trailing])
                        
                        
                        if !isEditing && searchText == "" {
                            RecommendedView()
                        } else if !isEditing {
                            ForEach(searchViewModel.books) { book in
                                ResearchedBookView(book: book)
                            }
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
                                    searchViewModel.fetchBooks(searchedText: searchText, filter: .empty)
                                }
                            }
                        }
                    )
                }
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil) //teclado some ao clicar na tela
            }
            .coordinateSpace(name: spaceName)
        }
        .onChange(
            of: scrollViewSize,
            perform: { value in
                print(value)
            }
        )
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

struct Searchable_Previews: PreviewProvider {
    static var previews: some View {
        SearchableView()
    }
}
