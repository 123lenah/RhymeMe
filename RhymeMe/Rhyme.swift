//
//  Rhyme.swift
//  RhymeMe
//
//  Created by Mac on 8/7/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import Foundation
import UIKit

class Rhyme: NSObject {

    let word: String
    let syllable: Int
    let score: Int
    let flags: String
    
    override var description: String {
        return "Word: \(word), Syllable: \(syllable), Score: \(score), Flags: \(flags)"
    }
    
    init(word: String, syllable: Int, score: Int, flags: String) {
        self.word = word
        self.syllable = syllable
        self.score = score
        self.flags = flags
    }
    
   
    
}

func isPerfectRhyme(score: Int) -> (scoreString: String, scoreColor: UIColor) {
    var rhymeGrade: String = ""
    var rhymeColor: UIColor = UIColor.black
    if score >= 300 {
        rhymeGrade = "Perfect"
        rhymeColor = UIColor.green
    } else if score < 300 && score > 200 {
        rhymeGrade = "Good"
        rhymeColor = UIColor.yellow
    } else if score < 200 && score > 100 {
        rhymeGrade = "OK"
        rhymeColor = UIColor.orange
    } else if score < 100 && score > 0 {
        rhymeGrade = "Bad"
        rhymeColor = UIColor.red
    }
    return (rhymeGrade, rhymeColor)
}
