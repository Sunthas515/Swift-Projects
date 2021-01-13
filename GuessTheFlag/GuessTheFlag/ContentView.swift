//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Callum McNeilage on 6/12/20.
//

import SwiftUI
struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var score = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack {
                    Text("Tap the flag of:")
                    Text(countries[correctAnswer]).font(.largeTitle).fontWeight(.black)
                }
                ForEach(0..<3) { number in
                    Button(action:{
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number]).renderingMode(.original).clipShape(Capsule()).overlay(Capsule().stroke(Color.black, lineWidth: 1)).shadow(color: .black, radius: 2)
                    }
                }
                Text("Score: \(score)").foregroundColor(.white)
                Spacer()
                    .alert(isPresented: $showingScore) {
                        Alert(title: Text(scoreTitle), message: Text(scoreMessage), dismissButton: .default(Text("Continue")) {
                            self.askQuestion()
                        })
                }
        }
    }
}
    func flagTapped(_ number: Int) {
        if number == correctAnswer{
            scoreTitle = "Correct"
            score += 1
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        } else {
            scoreTitle = "Incorrect"
            scoreMessage = "That is the flag of \(countries[number])"
            showingScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
