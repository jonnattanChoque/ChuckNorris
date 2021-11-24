//
//  ViewChuckModel.swift
//  ChuckApi
//
//  Created by jonnattan Choque on 23/11/21.
//

import Foundation


class ViewChuckModel{
    static let sharedInstance = ViewChuckModel()
    
    var delegate: ReloadViewDelegate? = nil
    private var network: AlamofireApi = AlamofireApi()
    private var chucks: [ChuckModel] = [ChuckModel]()
    
    
    init() {
        createObservers()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func createObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.onSuccess(_:)), name: Notification.Name(rawValue: "successChuck"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.onError(_:)), name: Notification.Name(rawValue: "errorChuck"), object: nil)
    }
    
    func getChucks(){
        network.getChucks()
    }
    
    
    func notifyDelegate(){
        if delegate != nil{
            delegate?.notifyDelegate()
        }
    }
    
    func notifyErrorDelegate(message: String){
        if delegate != nil{
            delegate?.notifyErrorDelegate(message: message)
        }
    }
    
    public func dataSource()->[ChuckModel]{
        return self.chucks
    }
    
    private func validID(chuck: ChuckModel)-> Bool{
        if self.chucks.contains(where: { name in name.id == chuck.id }) {
            return false
        } else {
            return true
        }
    }
    
    
    @objc func onSuccess(_ notification: NSNotification){
        let chucks = (notification.userInfo?["result"] as? ChuckModel)!
        
        let validChuck = self.validID(chuck: chucks)
        
        if validChuck{
            self.chucks.append(chucks)
        }
        
        if self.chucks.count < 10{
            self.network.getChucks()
        }else{
            self.notifyDelegate()
        }
    }
    
    @objc func onError(_ notification: NSNotification){
        let message = notification.userInfo?["error"] as? String
        notifyErrorDelegate(message: message ?? "Error generic")
    }
    
    
}
