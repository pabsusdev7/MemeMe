//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Pablo Albuja on 3/29/19.
//  Copyright © 2019 Ingenuity Applications. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "impact", size: 20)!,
        NSAttributedString.Key.strokeWidth:  CGFloat(-3.5)
    ]
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        
        cell.topLabel.attributedText = NSMutableAttributedString(string: meme.topText,attributes: memeTextAttributes)
        cell.topLabel.textAlignment = .center
        cell.bottomLabel.attributedText = NSMutableAttributedString(string: meme.bottomText,attributes: memeTextAttributes)
        cell.bottomLabel.textAlignment = .center
        
        
        //cell.topLabel.text = meme.topText
        //cell.bottomLabel.text = meme.bottomText
        cell.memeImage?.image = meme.originalImage
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let memeController = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        
        let meme = memes[(indexPath as NSIndexPath).row]
        memeController.meme = meme
        
        navigationController!.pushViewController(memeController, animated: true)
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        collectionView!.reloadData()
    }
    

}
