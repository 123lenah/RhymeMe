//
//  dataManager.swift
//  RhymeMe
//
//  Created by Mac on 8/7/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import Foundation
enum DataManagerError: Error {
    case Unknown
    case FailedRequest
    case InvalidResponse
}

final class DataManager {
    typealias RhymeDataCompletion = (AnyObject?, DataManagerError?) -> ()
    
    //Serialize the JSON
    func processRhymeData(data: Data, completion: RhymeDataCompletion) {
        if let JSON = try? JSONSerialization.jsonObject(with: data, options: []) {
            completion(JSON as AnyObject?, nil) //only time we pass JSON to the completion
        } else {
            completion(nil, .InvalidResponse)
        }
    }
    
    //Make the Call
    func didFetchRhymeData(data: Data?, response: URLResponse?, error: Error?, completion: RhymeDataCompletion) {
        if let _ = error {
            completion(nil, .FailedRequest)
        } else if let data = data, let response = response as? HTTPURLResponse {
            if response.statusCode == 200 {
                processRhymeData(data: data, completion: completion)
            } else {
                completion(nil, .FailedRequest)
            }
        } else {
            completion(nil, .Unknown)
        }
    }
    
    //Pass URL into the didFetchRhymeData function to make the call and parse the JSON
    func rhymeDataForWord(word: String, completion: @escaping RhymeDataCompletion) {
        //fetch URL
        let URL = API.getURLFromString(word: word)
        
        // create Data Task
        URLSession.shared.dataTask(with: URL!) { (data, response, error) in
            //make the call and parsse (pass in data, response, and error from URL)
            self.didFetchRhymeData(data: data, response: response, error: error, completion: completion)
        }.resume()
    }
    
}
