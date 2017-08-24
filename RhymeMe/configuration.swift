//
//  configuration.swift
//  RhymeMe
//
//  Created by Mac on 8/7/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import Foundation


struct API {
    // returns array of arrays
    // URL structure has 3 parameters: word, maxResults, lang
    static func getURLFromString(word: String) -> URL? {
        let urlString = "http://rhymebrain.com/talk?function=getRhymes&word=\(word)=&lang=en"
        let urlFromString = URL(string: urlString)
          
        return urlFromString
    }
    
}
