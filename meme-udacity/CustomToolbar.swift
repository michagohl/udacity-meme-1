//
//  CustomToolbar.swift
//  meme-udacity
//
//  Created by Michael Gohl on 04.08.18.
//  Copyright © 2018 Michael Gohl. All rights reserved.
//

import Foundation
import UIKit;

class CustomToolbar : UIToolbar {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let albumButton = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(openCreate(_:)));
        items?.append(flexible);
        items?.append(albumButton);
    }
    
    @objc func openCreate(_ notification:Notification) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let create = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController;
    
        
    }
}
