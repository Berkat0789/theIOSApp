//
//  Apps.swift
//  theappsapp
//
//  Created by Berkat Bhatti on 2/8/21.
//

import Foundation





struct Apps {
    let name: String
    let description: String
    
    
    
    
    static let appList = [
        Apps(name: K.AppNames.weatherApp, description: "App will use open weather api to get the wether for the user current location as well as the locaiton that is searched"),
        Apps(name: K.AppNames.chatApp, description: "App will use Google Firestore to create a chat mobile applicaiton"),
        Apps(name: K.AppNames.mlApp, description: "App will use Core ML and the Vision framework to classify images tht are taken frm a user's camera, The incepton model will be used to classify these items. The target for this will be to find if an image is classified as a Hotdog or Not a Hot God"),
        Apps(name: K.AppNames.createML, description: "App will be built on the create ML tool provided by Apple to build a ML model to classify a few animals of our choosing (Dog, Bat, Fish)"),
        Apps(name: K.AppNames.twitterSentimant, description: "THis app will use NLP to create a model that will take into account the sentiment of twitter data to predict stock market movement"),
        Apps(name: K.AppNames.twitterSentiment2, description: "THis app will use NLP also to to get a sentament analysis on a @ or # tweet pulled form the swifter api, unlike the previous app we will display the tweets as well as the clasificaion of the tweet as either Neg, Pos, or Neutral. The scor for the analysis will be presented on the navigation controller. For practice we will add a new tweet service class for familiarity for working with coreML clasification model as well."),


        
    ]
    
}
