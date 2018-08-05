//
//  TableViewController.swift
//  meme-udacity
//
//  Created by Michael Gohl on 04.08.18.
//  Copyright © 2018 Michael Gohl. All rights reserved.
//

import UIKit

class OverViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    var memes : [Meme]!;
    @IBOutlet weak var tableViewOutlet: UITableView!
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        if let tableView = tableViewOutlet {
            tableView.delegate = self;
            tableView.dataSource = self;
        }
        if let collectionView = collectionViewOutlet {
            let space: CGFloat = 3.0
            let dimension = ((UIDevice.current.orientation.isLandscape ? view.frame.size.height : view.frame.size.width) - (2 * space)) / 3.0;
            flowLayout.minimumLineSpacing = space;
            flowLayout.minimumInteritemSpacing = space;
            flowLayout.itemSize = CGSize(width: dimension, height: dimension);
            collectionView.dataSource = self;
            collectionView.delegate = self;
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openCreateModal));
        navigationItem.title = "Sent Memes"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let helper = MemeHelper();
        memes = helper.getMemes();
        if let tableView = tableViewOutlet {
            tableView.reloadData();
        }
        if let collectionView = collectionViewOutlet {
            collectionView.reloadData();
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeIdentCollection", for: indexPath) as! MemeCollectionCell
        let meme = memes[(indexPath as NSIndexPath).row];
        
        cell.imageView.image = UIImage(contentsOfFile: meme.memeImage)
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showDetails(indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDetails(indexPath)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeIdentTable") as! MemeTableCell;
        let meme = memes[(indexPath as NSIndexPath).row];
        
        cell.memeImage.image = UIImage(contentsOfFile: meme.memeImage)
        cell.memeLabel.text = meme.topText + " ... " + meme.bottomText;
        
        return cell;
    }
    
    @objc func openCreateModal() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let add = storyboard.instantiateViewController(withIdentifier: "AddView") as! ViewController;
        self.present(add, animated: true, completion: nil);
    }
    
    func showDetails(_ indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detail = storyboard.instantiateViewController(withIdentifier: "DetailView") as! DetailViewController;
        detail.memeId = (indexPath as NSIndexPath).row
        navigationController?.pushViewController(detail, animated: true)
    }

}
