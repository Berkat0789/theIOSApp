//
//  Constants.swift
//  theappsapp
//
//  Created by Berkat Bhatti on 2/8/21.
//

import Foundation




struct K {
    struct AppNames {
        static let weatherApp = "weatherApp"
        static let chatApp = "chatApp"
        static let mlApp = "mlApp"
        static let createML = "createML"
        static let twitterSentimant = "twitterSent"
        static let twitterSentiment2 = "twitterSentiment2"
    }
    struct cellIdentifiers {
        static let appCell = "appCell"
        static let weatherCell = "weatherCell"
        static let messageCell = "messageCell"
        static let tweetCell = "tweetCell"
    }
    struct segues {
        static let appsToWeather = "appsToWeather"
        static let loginToApps = "loginToApps"
        static let registerToApps = "registerToApps"
        static let appsToChat = "appsToChat"
        static let appsToImgRecon = "appsToImgRecon"
        static let appsToAnimalClassifier = "appsToAnimalClassifier"
        static let appsToTwitter = "appsToTwitter"
        static let appsToSentimentDisplay = "appsToSentimentDisplay"
    }
    struct DB {
        static let messageCollection = "message"
        static let senderNode = "sender"
        static let bodyNode = "body"
        static let stampNode = "timestamp"
    }
    struct SentimentLabels {
        static let positive = "Pos"
        static let negative = "Negative"
        static let neutral = "Neutral"
    }
}
