//
//  rhymetableview.swift
//  RhymeMe
//
//  Created by Mac on 8/8/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

extension rhymetableview: UISearchResultsUpdating {
    @available(iOS 8.0, *)
    public func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchText: searchController.searchBar.text!, scope: scope)
        
    }
}

extension rhymetableview: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchText: searchBar.text!, scope: (searchBar.scopeButtonTitles?[selectedScope])!)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        updateSearchResults(for: searchController)
    }
}

extension MutableCollection where Index == Int {
    mutating func shuffle() {
        if count < 2 { return }
        
        for i in startIndex ..< endIndex - 1  {
            let j = Int(arc4random_uniform(UInt32(endIndex - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}
    // Make tableView beautiful

    // push to app store

class rhymetableview: UITableViewController  {
    var rhymeWord: String!
    let dataManager = DataManager()
    var resultsArray: [Rhyme] = []
    var filteredResults: [Rhyme] = []
    let searchController = UISearchController(searchResultsController: nil)
    var unfilteredResults: [Rhyme] = []
    
    func getRhymes(word:String, completion: @escaping ([Rhyme]) -> Void) {
        dataManager.rhymeDataForWord(word: word) { (response, error) in
            
            if let response = response as? [AnyObject] {
                
                for element in response {
                    let flags = element["flags"] as! String
                    let syllable = element["syllables"] as! String
                    let score = element["score"] as! Int
                    let word = element["word"] as! String
                    let syllableInt = Int(syllable)
                    let results = Rhyme(word: word, syllable: syllableInt!, score: score, flags: flags)
                    self.resultsArray.append(results) // FIX THIS LINE OF CODE
                }
                
                completion(self.resultsArray)
                
            }
            
        }
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredResults = resultsArray.filter { rhyme in
            if scope == "Alphabetical" {
                resultsArray.sort { $0.word < $1.word }
            } else if scope == "Syllable" {
                resultsArray.sort { $0.syllable < $1.syllable }
            } else if scope == "Best Rhyme" {
                resultsArray.sort { $0.score > $1.score }
            } else if scope == "All" {
                resultsArray.removeAll()
                self.resultsArray = self.unfilteredResults
            }
            return rhyme.word.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (searchBarScopeIsFiltering)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        
        self.getRhymes(word: rhymeWord) { (resultsArray) in
            self.resultsArray = resultsArray
            self.resultsArray.shuffle()
            self.unfilteredResults = self.resultsArray // make a copy for resultsArray for the filterfuction in scope "All"

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        

        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        // setup the scope bar
        searchController.searchBar.scopeButtonTitles = ["All", "Alphabetical", "Syllable", "Best Rhyme"]
        searchController.searchBar.delegate = self
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let detailVC = segue.destination as! rhymeDetailView
                if searchController.isActive && searchController.searchBar.text != "" {
                    detailVC.word = filteredResults[indexPath.row].word
                    detailVC.flag = filteredResults[indexPath.row].flags
                    detailVC.score = filteredResults[indexPath.row].score
                    detailVC.syllable = filteredResults[indexPath.row].syllable
                } else {
                    detailVC.word = resultsArray[indexPath.row].word
                    detailVC.flag = resultsArray[indexPath.row].flags
                    detailVC.score = resultsArray[indexPath.row].score
                    detailVC.syllable = resultsArray[indexPath.row].syllable
                }
            }
        }
    }
    
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredResults.count
        }
        return resultsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! rhymeCell
        let rhyme: Rhyme
        if searchController.isActive && searchController.searchBar.text != "" {
            rhyme = filteredResults[indexPath.row]
        } else {
            rhyme = resultsArray[indexPath.row]
        }
        
    
        cell.wordLabel.text = rhyme.word
        let scoreData = isPerfectRhyme(score: rhyme.score)
        let scoreString = scoreData.0
        let scoreColor = scoreData.1
        cell.scoreLabel.text = scoreString
        cell.scoreLabel.textColor = scoreColor
        
        return cell
    }
 

}

