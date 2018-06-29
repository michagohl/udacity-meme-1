//
//  TextFieldDelegate.swift
//  meme-udacity
//
//  Created by Michael Gohl on 29.06.18.
//  Copyright © 2018 Michael Gohl. All rights reserved.
//

import Foundation
import UIKit

// MARK: - EmojiTextFieldDelegate : NSObject, UITextFieldDelegate

class TextFieldDelegate : NSObject, UITextFieldDelegate {

    var status = false
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    
}
