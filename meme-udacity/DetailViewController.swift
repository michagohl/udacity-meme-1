//
//  DetailViewController.swift
//  meme-udacity
//
//  Created by Michael Gohl on 05.08.18.
//  Copyright © 2018 Michael Gohl. All rights reserved.
//

import Foundation
import UIKit;

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!;
    var memeId: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        let meme = MemeHelper().getMemeById(id: memeId);
        imageView.image = UIImage(contentsOfFile: meme.memeImage);
    }

}
