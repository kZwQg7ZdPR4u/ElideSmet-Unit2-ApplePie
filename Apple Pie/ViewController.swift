//
//  ViewController.swift
//  Apple Pie
//
//  Created by Eli de Smet on 16/02/2018.
//  Copyright © 2018 minor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // initializing variables
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    var listOfWords = ["agastopia","bibble","cabotage","erinaceous","gabelle","impignorate", "jentacular", "kakorrhaphiophobia", "lamprophony", "nudiustertian","pauciloquent"]
    
    let incorrectMovesAllowed = 7
    
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    var currentGame: Game!

    
    // action when button is tapped
    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // start newRound after view is loaded
        newRound()
    }
    
    // start new round
    func newRound(){
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            updateUI()
            enableLetterButtons(true)
        } else {
            // disabling all buttons, because there are no words left
            enableLetterButtons(false)
        }
        
        
    }
    
    // function to update the user interface
    func updateUI(){
        
        // updating correctWordLabel
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        
        // updating scoreLabel
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        
        //updating tree image with incorrectMovesRemaining
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    // function to update game state
    func updateGameState(){
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
    // function to enable or disable all buttons
    func enableLetterButtons(_ enable: Bool){
        for button in letterButtons{
            button.isEnabled = enable
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

