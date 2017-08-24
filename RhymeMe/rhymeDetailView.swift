

//
//  rhymeDetailView.swift
//  RhymeMe
//
//  Created by Mac on 8/14/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class rhymeDetailView: UIViewController {
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var flagLabel: UILabel!
    @IBOutlet weak var syllableLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var flag3Label: UILabel!
    @IBOutlet weak var flagLabel2: UILabel!
    var word: String?
    var syllable: Int?
    var flag: String?
    var score: Int?
    
    
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    
    func isPerfectRhyme(score: Int) -> String {
        var rhymeGrade: String = ""
        if score >= 300 {
            rhymeGrade = "Perfect Rhyme"
            star1.isHidden = false
            star2.isHidden = false
            star3.isHidden = false
            star4.isHidden = false
        } else if score < 300 && score > 200 {
            rhymeGrade = "Near Perfect Rhyme"
            star1.isHidden = false
            star2.isHidden = false
            star3.isHidden = false
        } else if score < 200 && score > 100 {
            rhymeGrade = "OK Rhyme"
            star1.isHidden = false
            star2.isHidden = false
        } else if score < 100 && score > 0 {
            rhymeGrade = "Almost a Rhyme"
            star1.isHidden = false
        }
        return rhymeGrade
    }
    
    func explainFlags(flags: String) -> [String] {
        var flagArray: [String] = []
        for letter in flags.characters {
            if letter == "a" {
                flagArray.append("This word is offensive")
            } else if letter == "b" {
                flagArray.append("Might be found in most dictionaries")
            } else if letter == "c" {
                flagArray.append("Pronounciation is certain")
            }
        }
        
        
        
        return flagArray
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //hide flag textLabels
        self.flagLabel.isHidden = true
        self.flagLabel2.isHidden = true
        self.flag3Label.isHidden = true
        
        //hide all stars
        star1.isHidden = true
        star2.isHidden = true
        star3.isHidden = true
        star4.isHidden = true
        
        
        self.wordLabel.text = word
        self.syllableLabel.text = "\(syllable!)"
        
        let rhymeGrade = self.isPerfectRhyme(score: score!)
        
        self.scoreLabel.text = rhymeGrade
        
        let flagArray = explainFlags(flags: flag!)
        
        if flagArray.count == 1 {
            self.flagLabel.isHidden = false
          self.flagLabel.text = flagArray[0]
        } else if flagArray.count == 2 {
            self.flagLabel.isHidden = false
            self.flagLabel2.isHidden = false
            self.flagLabel.text = flagArray[0]
            self.flagLabel2.text = flagArray[1]
        } else if flagArray.count == 3 {
            self.flagLabel.isHidden = false
            self.flagLabel2.isHidden = false
            self.flag3Label.isHidden = false
            self.flagLabel.text = flagArray[0]
            self.flagLabel2.text = flagArray[1]
            self.flag3Label.text = flagArray[2]
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
