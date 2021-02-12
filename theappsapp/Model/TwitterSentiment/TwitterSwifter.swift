//
//  TwitterSwifter.swift
//  theappsapp
//
//  Created by Berkat Bhatti on 2/12/21.
//

import Foundation
import SwifteriOS



private let customerKey = "Fi8lxjhEonFkpp9z0ggFp6KGr"
private let secretKey  = "4T5xXZpUSlClfkRzKtf6SvnFsWYnAwpvdDDBRTgDWEplGv8CYy"
private let access = "1329436022950813696-nzb1Qo2Tr9AfbiP1ro542e15hyUkIc"
private let accessSec = "FWFhILRvxJHyJhulKm3i9K8dSWxKMpM4nB9FDtE9GIXOk"


struct Keys: Codable {
    var twitterApi:String
    var twitterSecret:String
    var twitterAccess:String
    var twitterAccessSecret: String
}


struct SwifterService {
    
      


    
    func searchFor(tweet: String) {
        // We are createing a new instance of swifter
        let swifter = Swifter(consumerKey: customerKey, consumerSecret: secretKey)
        swifter.searchTweet(using: tweet) { (results, metaData) in
            print(results)
        } failure: { (error) in
            print("There was an error gfetching tweets \(error)")
        }

    }
    
//    func getPlist(withName name: String, completed: @escaping (_ key: String, _ secret: String, _ access: String, _ accSec: String) ->())  {
//        let keys = ["k": String]
//
//        guard let path = Bundle.main.path(forResource: name, ofType: "plist") else {return}
//        guard let xml = FileManager.default.contents(atPath: path) else {return}
//        guard let preferences = try? PropertyListDecoder().decode(Keys.self, from: xml) else {return}
//        return (preferences.twitterApi, preferences.twitterSecret, preferences.twitterAccess, preferences.twitterAccessSecret)
//    }

    
    
    
    
    
    

    
}
