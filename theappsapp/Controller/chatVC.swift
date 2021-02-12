//
//  chatVC.swift
//  theappsapp
//
//  Created by Berkat Bhatti on 2/9/21.
//

import UIKit
import Firebase

class chatVC: UIViewController {
    @IBOutlet weak var messgeTableView: UITableView!
    @IBOutlet weak var messageField: UITextField!
    
    var service = MessageService()
    var returnedMessages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messgeTableView.register(UINib(nibName: K.cellIdentifiers.messageCell, bundle: nil), forCellReuseIdentifier: K.cellIdentifiers.messageCell)
        service.getmessages { (messages) in
            self.returnedMessages = messages
            self.messgeTableView.reloadData()
            self.messgeTableView.scrollToBottom(dataArray: self.returnedMessages)
        }

    }
    
    
    @IBAction func sendPressed(_ sender: Any) {
        print("send Pressed")
        guard let message = messageField.text else {return}
        guard let sender = Auth.auth().currentUser?.email else {return}
        service.addMessageToDB(sender: sender, body: message) { (done) in
            if done {
                DispatchQueue.main.async {
                    self.messageField.text = ""
                }
            }
        }
    }
}






extension chatVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        returnedMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = returnedMessages[indexPath.row]
        guard let messCell = messgeTableView.dequeueReusableCell(withIdentifier: K.cellIdentifiers.messageCell, for: indexPath) as? messageCell else {return UITableViewCell()}
        messCell.updateCell(message: message)
        return messCell
    }
}

extension UITableView {
    // need a scroll to bottom function
    func scrollToBottom(dataArray: [Any]) {
        let index = IndexPath(item: dataArray.count - 1 , section: 0)
        self.scrollToRow(at: index, at: ScrollPosition.top, animated: false)
    }
}
