//
//  SwipingController.swift
//  FirstProject
//
//  Created by Fenominall on 14.06.2021.
//

import UIKit
    
class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let pages = [
        
        Page(imageName: "pirate", headerText: "Join us today in our un and games!", bodyText: "Are you ready for loads and loads of fun? Don`t wait any longer! We hope to see you in our stores soon."),
        Page(imageName: "laugh", headerText: "Subscribe and get coupons on our daily events", bodyText: "Get notified of the saving immidiatelly when we announce them on our website. make sure to also give us any feedback."),
        Page(imageName: "glasses", headerText: "VIP members special services", bodyText: "Smile is the best to respect our app/"),
        Page(imageName: "smile", headerText: "Don`t wait, connect!", bodyText: "Pirates are angry and they want some gold, go ahead, join the game for treausers"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.isPagingEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        
        let page = pages[indexPath.item]
        cell.page = page
//        cell.pirateHead.image = UIImage(named: page.imageName)
//        cell.descriptionTextView.text = page.headerText
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
}
