import SwiftUI

struct SearchableView: View {
    @State private var searchText = ""
    @State private var filteredData: [String] = []
    @EnvironmentObject private var searchViewModel: SearchViewModel
    
    let spaceName = "scroll"
    @State var scrollViewSize: CGSize = .zero
    
    var body: some View {
        ScrollView {
            ChildSizeReader(size: $scrollViewSize) {
                VStack(alignment: .leading) {
                    // Search Bar
                    HStack {
                        TextField("Procure por livros, autores e gêneros", text: $searchText)
                            .onSubmit {
                                searchViewModel.fetchBooks(searchedText: searchText)
                            }
                            .padding(15)
                            .font(.system(size: 15))
                            .foregroundColor(Color(red: 0.255, green: 0.255, blue: 0.255))
                    }
                    .padding(.trailing, 20)
                    .background(Color(red: 0.851, green: 0.851, blue: 0.851))
                    .cornerRadius(30)
                    .padding()
                    .overlay(
                        HStack {
                            Spacer()
                            Button(action: {
                                searchViewModel.fetchBooks(searchedText: searchText)
                                
                                print("Pesquisar...")
                            }) {
                                Image("searchIconSelected")
                                    .padding(.trailing, 25)
                            }
                            .disabled(searchText == "")
                            .opacity(searchText == "" ? 0.6 : 1)
                        }
                    )
                    
                    ForEach(searchViewModel.books) { book in
                        ResearchedBookView(book: book)
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
                        print("offset: \(value.description)") // offset: 1270.3333333333333 when User has reached the bottom
                        print("height: \(scrollViewSize.height)") // height: 2033.3333333333333
                        
                        //                        if value > 900 {
                        //                            searchViewModel.fetchBooks(searchedText: searchText)
                        //                        }
                    }
                )
            }
        }
        .coordinateSpace(name: spaceName)
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

//import SwiftUI
//
//struct ItemListView: View {
//    @StateObject private var viewModel = ItemViewModel()
//
//    var body: some View {
//        ScrollViewReader { scrollViewProxy in
//            ScrollView {
//                LazyVStack {
//                    ForEach(viewModel.items) { item in
//                        ItemRow(item: item)
//                            .onAppear {
//                                viewModel.loadMoreItems(currentItem: item)
//                            }
//                    }
//                }
//                .padding()
//            }
//            .onAppear {
//                viewModel.fetchItems()
//            }
//            .onChange(of: viewModel.items) { newItems in
//                withAnimation {
//                    scrollViewProxy.scrollTo(newItems.last?.id)
//                }
//            }
//        }
//    }
//}
//
//struct ItemRow: View {
//    let item: Item
//
//    var body: some View {
//        // Implemente a aparência de uma linha de item individual aqui
//        // Por exemplo: Text(item.name)
//    }
//}
