//
//  ViewController.swift
//  ChuckApi
//
//  Created by jonnattan Choque on 23/11/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableViewChuck: UITableView!
    
    private var chucks: [ChuckModel] = [ChuckModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewChuck.delegate = self
        tableViewChuck.dataSource = self
        tableViewChuck.register(UINib(nibName: "ChuckTableViewCell", bundle: nil), forCellReuseIdentifier: "chuckTableViewCell")
        
        ViewChuckModel.sharedInstance.delegate = self
        loadInfo()
    }
    
    func loadInfo(){
        ViewChuckModel.sharedInstance.getChucks()
    }
}

extension ViewController: ReloadViewDelegate{
    func notifyErrorDelegate(message: String) {
        print(message)
    }
    
    func notifyDelegate() {
        self.chucks = ViewChuckModel.sharedInstance.dataSource()
        self.tableViewChuck.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.chucks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data =  self.chucks
        
        let object = data[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "chuckTableViewCell") as? ChuckTableViewCell
        
        cell?.display(object: object)
        return cell!
    
    }
}

