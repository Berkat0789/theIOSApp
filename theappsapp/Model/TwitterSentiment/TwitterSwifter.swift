//
//  TwitterSwifter.swift
//  theappsapp
//
//  Created by Berkat Bhatti on 2/12/21.
//

import Foundation
import SwifteriOS
import CoreML
import  SwiftyJSON



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
    
    private let twitterSentament = twitter_test_1_2()
    private let swifter = Swifter(consumerKey: customerKey, consumerSecret: secretKey)
    private var sentimantScore = 0

      


    
    func searchFor(tweet: String, completed: @escaping (_ tweets: [String], _ score: Int) -> ()) {
        var tweetArray = [twitter_test_1_2Input]()
        // We are createing a new instance of swifter
        swifter.searchTweet(using: tweet, lang: "en",count: 100, tweetMode: TweetMode.extended) { (results, metaData) in
            //print(results)
            // We will need to parse the json for the results
            //Lets get all the tweets into an array
            guard let resultsArray = results.array else{fatalError("No data returned")}
            for i in 0..<resultsArray.count {
                if let tweet = results[i]["full_text"].string {
                    let tweetClassinput = twitter_test_1_2Input(text: tweet)
                    tweetArray.append(tweetClassinput)
                }
            }
            guard let tweetPredictionBatch = self.makePredicitonFOr(tweets: tweetArray).0 else {return}
            guard let score = self.makePredicitonFOr(tweets: tweetArray).1 else{return}
            completed(tweetPredictionBatch, score)
        } failure: { (error) in
            print("There was an error gfetching tweets \(error)")
            completed([], 0)
        }
    }
    
     private func makePredicitonFOr(tweets: [twitter_test_1_2Input]) -> ([String]?, Int?) {
        var labels = [String]()
        do {
            let prediction = try twitterSentament.predictions(inputs: tweets)
            // We need to convert the tweet string array to  model input
            var score = 0
            prediction.forEach { (pre) in
                labels.append(pre.label)
                let label = pre.label
                if label == "Pos"{
                    score += 1
                } else if label == "Neg" {
                    score -= 1
                }
            }
//            print("sentiment analysis score is \(score)")
            return (labels, score)
        } catch {
            print("Thre was an error prediction tweet \(error.localizedDescription)")
            return (nil, nil)
        }
    }
    
//    private func checkSentiment(label: String) -> Int {
//        if label == "Pos" {
//            sentimantScore += 1
//        } else if label == "Neg" {
//            sentimantScore -= 1
//        }
//        return sentimantScore
//    }
    
    
    
//    func getPlist(withName name: String, completed: @escaping (_ key: String, _ secret: String, _ access: String, _ accSec: String) ->())  {
//        let keys = ["k": String]
//
//        guard let path = Bundle.main.path(forResource: name, ofType: "plist") else {return}
//        guard let xml = FileManager.default.contents(atPath: path) else {return}
//        guard let preferences = try? PropertyListDecoder().decode(Keys.self, from: xml) else {return}
//        return (preferences.twitterApi, preferences.twitterSecret, preferences.twitterAccess, preferences.twitterAccessSecret)
//    }

    
    
    
    
    
    

    
}
