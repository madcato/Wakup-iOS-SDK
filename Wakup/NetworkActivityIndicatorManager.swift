//
//  NetworkActivityIndicatorManager.swift
//  Wuakup
//
//  Created by Guillermo Gutiérrez on 12/5/15.
//  Copyright (c) 2015 Yellow Pineapple. All rights reserved.
//

import Foundation

class NetworkActivityIndicatorManager {
    
    class var sharedInstance: NetworkActivityIndicatorManager {
        struct Static {
            static let instance: NetworkActivityIndicatorManager = NetworkActivityIndicatorManager()
        }
        return Static.instance
    }
    
    fileprivate let application = UIApplication.shared
    fileprivate var tasks = 0
    
    func startActivity() {
        DispatchQueue.main.async {
            if self.application.isStatusBarHidden {
                return
            }
            if !self.application.isNetworkActivityIndicatorVisible {
                self.application.isNetworkActivityIndicatorVisible = true
                self.tasks = 0
            }
            self.tasks += 1
        }
    }
    
    func endActivity() {
        DispatchQueue.main.async {
            if self.application.isStatusBarHidden {
                return
            }
            self.tasks -= 1
            
            if (self.tasks <= 0) {
                self.application.isNetworkActivityIndicatorVisible = false
                self.tasks = 0
            }
        }
    }
    
    func endAllActivities() {
        DispatchQueue.main.async {
            if self.application.isStatusBarHidden {
                return
            }
            self.application.isNetworkActivityIndicatorVisible = false
            self.tasks = 0
        }
    }
    
}
