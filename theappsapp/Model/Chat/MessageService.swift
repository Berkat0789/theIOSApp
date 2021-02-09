//
//  MessageService.swift
//  theappsapp
//
//  Created by Berkat Bhatti on 2/9/21.
//

import Foundation
import Firebase


private let db = Firestore.firestore()

struct MessageService {
    
    
    func addMessageToDB(sender: String, body :String, completed: @escaping (_ done: Bool) -> ()) {
        db.collection(K.DB.messageCollection).addDocument(data: [
            K.DB.bodyNode: body,
            K.DB.senderNode: sender,
            K.DB.stampNode: Date().timeIntervalSince1970
        ])
        completed(true)
    }
    func getmessages(completed: @escaping (_ messages: [Message]) -> ()) {
        db.collection(K.DB.messageCollection).order(by: K.DB.stampNode).addSnapshotListener { (documentSnap, error) in
            var returnedMessages = [Message]()
            if let err = error {
                //There was an error
                print("There was a error retrieving \(err)")
                returnedMessages = []
                completed(returnedMessages)
            } else {
                //There was no error
                guard let snap = documentSnap?.documents else {return}
                snap.forEach { (messageSnap) in
                     let doc = messageSnap.data()
                    let sender = doc[K.DB.senderNode] as? String ?? ""
                    let body = doc[K.DB.bodyNode] as? String ?? ""
                    let stamp = doc[K.DB.stampNode] as? Double ?? 0.0
                    let message = Message(sender: sender, body: body, timestamp: stamp)
                    returnedMessages.append(message)
                    completed(returnedMessages)
                }
            }
        }
    }
    
    
}
