//
//  rhymeViewController.swift
//  RhymeMe
//
//  Created by Mac on 8/10/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class rhymeViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    @IBOutlet weak var wordTextField: UITextField!
    
    
    @IBAction func wordButtonAction(_ sender: Any) { //FIX THIS
        
        let whiteSpace = NSCharacterSet.whitespaces
        let range = wordTextField?.text?.rangeOfCharacter(from: whiteSpace)
        
        if wordTextField?.text == "" {
            let alert = UIAlertController(title: "Error", message: "Enter a word", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else if let whiteSpaceIsTrue = range {
            let alert = UIAlertController(title: "Error", message: "Remove any empty spaces", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)

        } else {
            self.performSegue(withIdentifier: "segue", sender: self)
        }
      
    
    }
    
    override func viewDidLayoutSubviews() {
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor.black.cgColor
        border.frame = CGRect(x: 0, y: wordTextField.frame.size.height - width, width: wordTextField.frame.size.width, height: wordTextField.frame.size.height)
        border.borderWidth = width
        wordTextField.layer.addSublayer(border)
        wordTextField.layer.masksToBounds = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            let destinationTC = segue.destination as? rhymetableview
            destinationTC?.rhymeWord = wordTextField.text
        }
    }
   
    /*
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        var shouldPerform: Bool = false
        let whiteSpace = NSCharacterSet.whitespaces
        var range = wordTextField?.text?.rangeOfCharacter(from: whiteSpace)
        let userText = wordTextField.text
        
        if range == nil || userText! != "" {
            shouldPerform = true
            self.performSegue(withIdentifier: "segue", sender: self)
        }
        return shouldPerform
    }*/

    let test = "Test Case"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wordTextField.delegate = self
        // Do any additional setup after loading the view.
        
        let whitespace = NSCharacterSet.whitespaces
        let range = test.rangeOfCharacter(from: whitespace)
        if let test = range {
            print("whitespace found")
        } else {
            print("whitespace not found")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.wordTextField.resignFirstResponder()
        return true
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
