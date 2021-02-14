//
//  TwitterSentiment2.swift
//  theappsapp
//
//  Created by Berkat Bhatti on 2/13/21.
//

import Foundation
import SwifteriOS
import SwiftyJSON


private let apiKey = "Fi8lxjhEonFkpp9z0ggFp6KGr"
private let secretKey = "4T5xXZpUSlClfkRzKtf6SvnFsWYnAwpvdDDBRTgDWEplGv8CYy"


struct TwitterSentiment2 {
    
    private let twitterObject = Swifter(consumerKey: apiKey, consumerSecret: secretKey)
    private let twitterNLPModel = twitter_test_1_2()
    
    
    // Lets create a funciton that will search for our tweets from a search
    
    func searchForTweetsfor(value: String, completed: @escaping (_ tweets: [Tweet], _ score: Int) -> ()) {
        var tweets = [Tweet]()
        var convertedInputs = [twitter_test_1_2Input]()
        var score = 0
        twitterObject.searchTweet(using: value, lang: "en", count: 100, tweetMode: TweetMode.extended) { (results, metaData) in
            //print(results)
            // We will use swifty json to get the data for each tweet
            results.array?.forEach({ (JSONTweet) in
                guard let tweetText = JSONTweet["full_text"].string else {return}
                guard let userName = JSONTweet["user"]["screen_name"].string else {return}
                let tweet = Tweet(text: tweetText, sentimentValue: performSentimentOn(tweetText: tweetText), sender: "@" + "\(userName)")
                convertedInputs.append(convert(tweet: tweetText))
                tweets.append(tweet)
                score = calculateScorefor(model_inputs: convertedInputs)
            })
            completed(tweets, score)
        } failure: { (error) in
            print("There was an error getting tweets \(error.localizedDescription)")
            tweets = []
            completed(tweets, score)
        }
    }
    // Ok we heve the tweets above so lets use our ML NLP model to perform some sentiment analysis
    
    private func performSentimentOn(tweetText: String ) -> String {
        do {
            let sentiment = try twitterNLPModel.prediction(text: tweetText).label
            return sentiment
        }catch {
            print("There was an error performing prediciton \(error.localizedDescription) ")
            return "Unable to classify"
        }
    }
    
    // Will create a funciton to calculate the score
    private func calculateScorefor(model_inputs: [twitter_test_1_2Input]) -> Int {
        do {
            var score = 0
            let sentiment = try twitterNLPModel.predictions(inputs: model_inputs)
            sentiment.forEach { (tweetPrediction) in
                let label = tweetPrediction.label
                if label == K.SentimentLabels.positive {
                    score += 1
                } else if label == K.SentimentLabels.negative {
                    score -= 1
                }
            }
            return score
        } catch {
            print("There was an error getting predicitons \(error.localizedDescription)")
            return 0
        }
    }
    
    // Converting Stings to model inputs to
    private func convert(tweet: String) -> twitter_test_1_2Input {
        let tweetInput = twitter_test_1_2Input(text: tweet)
        return tweetInput
    }
    
//    mutating func getScoreForSentimentAnalysys(label: String) {
//        switch label {
//        case K.SentimentLabels.positive:
//            score += 1
//        case K.SentimentLabels.negative:
//            score -= 1
//        default:
//            score = 0
//        }
//    }
    
    
    
    
    
    
}
