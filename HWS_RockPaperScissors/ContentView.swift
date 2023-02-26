//
//  ContentView.swift
//  HWS_RockPaperScissors
//
//  Created by Ryan Saunders on 2023-02-26.
//

import SwiftUI

struct ContentView: View {
    
    enum PossibleMove: String, CaseIterable {
        case rock = "Rock"
        case paper = "Paper"
        case scissors = "Scissors"
    }
    @State var score = 0
    @State private var shouldWin = true
    @State private var instructionMessage = "You should: "
    @State private var currentMove : PossibleMove = .rock
    @State private var expectedMove : PossibleMove = .paper
    @State private var gameOver = false
    let maxScore = 10
    
    
    var body: some View {
        
        VStack {
            HStack{
                Spacer()
                Text("Score: \(score)")
                    .padding(.trailing, 20)
            }
            Spacer()
            VStack{
                Spacer()
                Text("Computer plays:")
                Text("\(currentMove.rawValue)")
                    .font(.largeTitle)
                    .padding(.bottom, 50)
                Text("You should try to: ")
                Text(shouldWin == true ? "Win!" : "Lose!")
                    .font(.largeTitle)
                Spacer()
            }
            Spacer()
            HStack {
                Spacer()
                Button("Rock") {
                    checkMove(move: .rock)
                }
                Spacer()
                Button("Paper") {
                    checkMove(move: .paper)
                }
                Spacer()
                Button("Scissors") {
                    checkMove(move: .scissors)
                }
                Spacer()
            }
        }
        .alert("Game Over!", isPresented: $gameOver) {
            Button("Play Again!", action: resetGame)
        } message: {
            Text("Final score: \(score)")
        }
    }
    
    func makeMove() {
        shouldWin = Bool.random()
        currentMove = PossibleMove.allCases.randomElement() ?? .paper
        switch shouldWin {
        case true:
            switch currentMove {
            case .paper:
                expectedMove = .scissors
            case .rock:
                expectedMove = .paper
            case .scissors:
                expectedMove = .rock
            }
        case false:
            switch currentMove {
            case .paper:
                expectedMove = .rock
            case .rock:
                expectedMove = .scissors
            case .scissors:
                expectedMove = .paper
            }
        }

    }
    
    func checkMove(move: PossibleMove) {
        if move == expectedMove {
            score += 1
        } else {
            score -= 1
            print("Wrong! Expected: \(expectedMove.rawValue)")
        }
        checkScore()
    }
    
    func checkScore() {
        if score == maxScore {
            gameOver = true
        } else {
            makeMove()
        }
    }
    
    func resetGame() {
        score = 0
        makeMove()
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
