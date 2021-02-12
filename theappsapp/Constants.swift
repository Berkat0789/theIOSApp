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
    }
    struct cellIdentifiers {
        static let appCell = "appCell"
        static let weatherCell = "weatherCell"
        static let messageCell = "messageCell"
    }
    struct segues {
        static let appsToWeather = "appsToWeather"
        static let loginToApps = "loginToApps"
        static let registerToApps = "registerToApps"
        static let appsToChat = "appsToChat"
        static let appsToImgRecon = "appsToImgRecon"
        static let appsToAnimalClassifier = "appsToAnimalClassifier"
        static let appsToTwitter = "appsToTwitter"
    }
    struct DB {
        static let messageCollection = "message"
        static let senderNode = "sender"
        static let bodyNode = "body"
        static let stampNode = "timestamp"
    }
    
}
