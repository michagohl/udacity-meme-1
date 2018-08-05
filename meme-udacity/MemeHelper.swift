//
//  MemeHelper.swift
//  meme-udacity
//
//  Created by Michael Gohl on 04.08.18.
//  Copyright © 2018 Michael Gohl. All rights reserved.
//

import Foundation
import UIKit;
class MemeHelper {
    let storage = UserDefaults.standard;
    let name = "memes"
    
    func getMemes() -> [Meme] {
        if let memes = self.storage.object(forKey: self.name) {
            return NSKeyedUnarchiver.unarchiveObject(with: memes as! Data) as! [Meme]
        } else {
            return [Meme]()
        }
    }
    
    func getMemeById(id: Int) -> Meme {
        return self.getMemes()[id];
    }
    
    func saveMeme(top: String, bottom: String, image: UIImage) {
        var memes = self.getMemes();
        let path = self.saveImage(image: image);
        memes.append(Meme(top: top, bottom: bottom, imagePath: path));
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: memes);
        self.storage.set(encodedData, forKey: self.name)
    }
    
    func saveImage(image: UIImage) -> String {
        let imageData = UIImageJPEGRepresentation(image, 1);
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(randomString(length: 100) + ".jpg");
        do {
            try imageData?.write(to: paths, options: .atomic);
        } catch {
            print("error");
        }
        return paths.path;
    }
    
    /** found on https://stackoverflow.com/questions/26845307/generate-random-alphanumeric-string-in-swift **/
    func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
}
