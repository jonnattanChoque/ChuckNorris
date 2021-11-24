//
//  ReloadViewDelegate.swift
//  ChuckApi
//
//  Created by jonnattan Choque on 23/11/21.
//

import Foundation


protocol ReloadViewDelegate{
    func notifyDelegate()
    func notifyErrorDelegate(message: String)
}
