//
//  ContentView.swift
//  WordGarden
//
//  Created by HERNANDEZ CAZARES, JAZMIN on 1/13/26.
//

import SwiftUI

struct ContentView: View {
    @State private var wordsGuessed = 0
    @State private var wordsMissed = 0
    @State private var gamesStatusMessage = "How Many guesses to Uncover the Hidden Word?"
    @State private var currentWordIndex = 0 //index in wordsToGuess
    @State private var wordToGuess = ""
    @State private var revealedWord = ""
    @State private var lettersGuessed = ""
    @State private var guessedletter = ""
    @State private var imageName = "flower8"
    @State private var playAgainHidden = true
    @FocusState private var textFieldIsFocused: Bool
    private let wordsToGuess = ["SWIFT", "DOG", "CAT"] // All Caps
    
    var body: some View {
        VStack {
            HStack {
                VStack (alignment: .leading) {
                    Text ("Words Guessed: \(wordsGuessed)")
                    Text ("Words Missed: \(wordsMissed)")
                }
                Spacer()
                VStack (alignment: .trailing) {
                    Text ("Words to Guess: \(wordsToGuess.count - wordsGuessed + wordsMissed)")
                    Text ("Words in Game: \(wordsToGuess.count)")
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            Text(gamesStatusMessage)
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
            
            //TODO: switch to wordsToGuess[currentWordIndex]
            Text(revealedWord)
                .font(.title)
            
            if playAgainHidden {
                HStack{
                    TextField("", text: $guessedletter)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 30)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.gray, lineWidth: 2)
                        }
                        .keyboardType(.asciiCapable)
                        .submitLabel(.done)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.characters)
                        .onChange(of: guessedletter) {
                            guessedletter = guessedletter.trimmingCharacters(in: .letters.inverted)
                            guard let lastChar = guessedletter.last else {
                                return
                            }
                            guessedletter = String(lastChar).uppercased()
                        }
                    
                        .focused($textFieldIsFocused)
                        .onSubmit {
                            //As long as guessedLetter is not empty String we can continue, otherwise don't do anything
                            guard guessedletter != "" else {
                                return
                            }
                            guessALetter()
                        }
                 
                    Button("Guess a Letter:") {
                        guessALetter()
                    }
                    .buttonStyle(.bordered)
                    .tint(.mint)
                    .disabled(guessedletter.isEmpty)
                }
            } else {
                Button("Another Word?") {
                    //TODO: another word button action here
                    playAgainHidden = true
                }
                .buttonStyle(.borderedProminent)
                .tint(.mint)
            }

            
            Spacer()
            
            Image(imageName)
                .resizable()
                .scaledToFit()
        }
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            wordToGuess = wordsToGuess[currentWordIndex]
            // CREATE A STRING FROM A REPEATING VALUE
            revealedWord = "_ " + String(repeating: "_ ", count: wordToGuess.count-1)
        }
    }
    
    func guessALetter() {
        textFieldIsFocused = false
        lettersGuessed = lettersGuessed + guessedletter
        revealedWord = wordToGuess.map{ letter in
            lettersGuessed.contains(letter) ? "\(letter)" : "_"
        }.joined(separator: " ")
        guessedletter = ""
    }
}

#Preview {
    ContentView()
}
