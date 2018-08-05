//
//  Meme.swift
//  meme-udacity
//
//  Created by Michael Gohl on 05.08.18.
//  Copyright © 2018 Michael Gohl. All rights reserved.
//

import Foundation
class Meme: NSObject, NSCoding {
    let topText: String
    let bottomText: String
    let memeImage: String
    
    init(top: String, bottom: String, imagePath: String) {
        topText = top;
        bottomText = bottom;
        memeImage = imagePath;
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.topText = aDecoder.decodeObject(forKey: "top") as! String;
        self.bottomText = aDecoder.decodeObject(forKey: "bottom") as! String;
        self.memeImage = aDecoder.decodeObject(forKey: "path") as! String;
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(topText, forKey: "top");
        aCoder.encode(bottomText, forKey: "bottom")
        aCoder.encode(memeImage, forKey: "path")
    }
}
