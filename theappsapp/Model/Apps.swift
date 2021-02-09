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
        Apps(name: K.AppNames.chatApp, description: "App will use Google Firestore to create a chat mobile applicaiton")
    
    ]
    
}
