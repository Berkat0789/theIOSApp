//
//  homeVC.swift
//  theappsapp
//
//  Created by Berkat Bhatti on 2/8/21.
//

import UIKit

class homeVC: UIViewController {

    @IBOutlet weak var appsTableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        appsTableView.register(UINib(nibName: K.cellIdentifiers.appCell, bundle: nil), forCellReuseIdentifier: K.cellIdentifiers.appCell)
        
        // Do any additional setup after loading the view.
    }


}



extension homeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Apps.appList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let app = Apps.appList[indexPath.row]
        guard let cell = appsTableView.dequeueReusableCell(withIdentifier: K.cellIdentifiers.appCell, for: indexPath) as? appCell else {return UITableViewCell()}
        cell.updateCell(app: app)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let app = Apps.appList[indexPath.row]
        switch app.name {
        case K.AppNames.weatherApp:
            performSegue(withIdentifier: K.segues.appsToWeather, sender: self)
        default:
            return
        }
    }
    
}
