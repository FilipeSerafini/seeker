//
//  GenreButtonOnboarding.swift
//  BookApp
//
//  Created by Sabrina Souza on 10/08/23.
//

import SwiftUI

class SelectedGenres: ObservableObject {
    @Published var genres: [Genre] = []
    @Published var genresAPI: [String] = []
    @Published var genresUser: [String] = []
}

struct ButtonData: Identifiable {
    let id: Int
    let title: String
    var isSelected: Bool
    @State var genre: Genre
}

struct GenreButtonOnboarding: View {
    @EnvironmentObject private var selectedGenres: SelectedGenres
    @State private var buttons: [ButtonData] = [
        ButtonData(id: 0, title: "Fantasia", isSelected: false, genre: .fantasy),
        ButtonData(id: 1, title: "Suspense", isSelected: false, genre: .thriller),
        ButtonData(id: 2, title: "Ficção", isSelected: false, genre: .fiction),
        ButtonData(id: 3, title: "Romance", isSelected: false, genre: .romance),
        ButtonData(id: 4, title: "Poesia", isSelected: false, genre: .poetry),
        ButtonData(id: 5, title: "Biografia", isSelected: false, genre: .biography),
        ButtonData(id: 6, title: "Terror", isSelected: false, genre: .horror),
        ButtonData(id: 7, title: "Não ficção", isSelected: false, genre: .nonFiction),
        ButtonData(id: 8, title: "Mistério", isSelected: false, genre: .mystery),
        ButtonData(id: 9, title: "Autoajuda", isSelected: false, genre: .selfHelp),
        ButtonData(id: 10, title: "Filosofia", isSelected: false, genre: .philosophy),
        ButtonData(id: 11, title: "Religião", isSelected: false, genre: .religion)
    ]
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    toggleButtonSelection(button: buttons[0])
                }) {
                    Text(buttons[0].title)
                }
                .buttonStyle(CustomButtonGenre(isSelected: buttons[0].isSelected))
            }
            .padding(.leading, -50)
            
            HStack {
                ForEach(buttons.dropFirst(1).prefix(2)) { button in
                    Button(action: {
                        toggleButtonSelection(button: button)
                    }) {
                        Text(button.title)
                    }
                    .buttonStyle(CustomButtonGenre(isSelected: button.isSelected))
                }
            }
            .padding(.leading, -60)
            
            HStack {
                ForEach(buttons.dropFirst(3).prefix(2)) { button in
                    Button(action: {
                        toggleButtonSelection(button: button)
                    }) {
                        Text(button.title)
                    }
                    .buttonStyle(CustomButtonGenre(isSelected: button.isSelected))
                }
            }
            .padding(.leading, 50)
            
            HStack {
                ForEach(buttons.dropFirst(5).prefix(2)) { button in
                    Button(action: {
                        toggleButtonSelection(button: button)
                    }) {
                        Text(button.title)
                    }
                    .buttonStyle(CustomButtonGenre(isSelected: button.isSelected))
                }
            }
            .padding(.leading, 5)
            
            HStack {
                ForEach(buttons.dropFirst(7).prefix(2)) { button in
                    Button(action: {
                        toggleButtonSelection(button: button)
                    }) {
                        Text(button.title)
                    }
                    .buttonStyle(CustomButtonGenre(isSelected: button.isSelected))
                }
            }
            .padding(.leading, -20)
            
            HStack {
                ForEach(buttons.dropFirst(9).prefix(2)) { button in
                    Button(action: {
                        toggleButtonSelection(button: button)
                    }) {
                        Text(button.title)
                    }
                    .buttonStyle(CustomButtonGenre(isSelected: button.isSelected))
                }
            }
            .padding(.leading, 50)
            
            HStack {
                Button(action: {
                    toggleButtonSelection(button: buttons[11])
                }) {
                    Text(buttons[11].title)
                }
                .buttonStyle(CustomButtonGenre(isSelected: buttons[11].isSelected))
                
            }
            .padding(.leading, 20)
        }
        .padding(.leading, 5)
    }
    
    private func toggleButtonSelection(button: ButtonData) {
        guard let index = buttons.firstIndex(where: { $0.id == button.id }) else {
            return
        }
        
        if buttons.filter({ $0.isSelected }).count < 3 || button.isSelected {
            if button.isSelected {
                selectedGenres.genres.removeAll { $0 == button.genre }
            } else {
                selectedGenres.genres.append(button.genre)
            }
            buttons[index].isSelected.toggle()
        }
    }
}

struct GenreButtonOnboarding_Previews: PreviewProvider {
    static var previews: some View {
        GenreButtonOnboarding()
    }
}
