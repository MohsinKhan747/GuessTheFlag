//
//  ContentView.swift
//  FlagGame
//
//  Created by Mohsin Khan on 25/06/2025.
//
import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia","France", "Germany", "Ireland","Italy","Nigeria", "Poland","Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle: String = ""
    
    @State private var userScore = 0
    @State private var questionDisplayed = 0
    let maxAttempts = 8
    @State private var restartTitle = ""
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red:0.1, green:0.2, blue: 0.45), location:0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue:0.26) , location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                VStack(spacing:30){
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                        
                    }
                    ForEach(0..<3){ number in
                        Button{
                            flagTapped(number)
                        }label: {
                            Image(countries[number])
                                .shadow(radius: 5)
                        }
                    }
                    
                }
                .frame(maxWidth:.infinity)
                .padding(.vertical,20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius:20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
            }
            .padding()
            .alert(scoreTitle, isPresented: $showingScore) {
                if questionDisplayed >= maxAttempts {
                    Button("Restart", action: restartGame)
                } else {
                    Button("Continue", action: askQuestion)
                }
            } message: {
                if questionDisplayed >= maxAttempts {
                    Text("Your final score is \(userScore) / \(maxAttempts)")
                } else {
                    Text("Your score is: \(userScore)")
                }
            }

        }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            userScore += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
            userScore = max(userScore - 1, 0)
        }
        questionDisplayed += 1

        if questionDisplayed >= maxAttempts {
            scoreTitle = "Game Over"
            showingScore = true
        } else if number != correctAnswer {
            showingScore = true
        } else {
            askQuestion()
        }
    }

    func restartGame() {
        userScore = 0
        questionDisplayed = 0
        askQuestion()
    }

    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
