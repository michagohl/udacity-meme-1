//
//  NavigationController.swift
//  meme-udacity
//
//  Created by Michael Gohl on 05.08.18.
//  Copyright © 2018 Michael Gohl. All rights reserved.
//

import UIKit;

class NavigationBar: UINavigationBar {
    override init(coder: NSCoder) {
        super.init(coder: coder);
        self.pushItem(<#T##item: UINavigationItem##UINavigationItem#>, animated: <#T##Bool#>)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New", style: .plain, target: self, action: #selector(openCreate));
    }
    
    @objc func openCreate() {
        
    }
}
