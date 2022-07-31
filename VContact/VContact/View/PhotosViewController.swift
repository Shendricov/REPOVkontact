//
//  PhotosViewController.swift
//  VContact
//
//  Created by Mikhail Shendrikov on 10.05.2022.
//

import UIKit
import Alamofire
import RealmSwift

private let reuseIdentifier = "Cell"

class PhotosViewController: UICollectionViewController {
    
//    var photosArrayFromAPI: Array<Photos> = []
//    var loadedPhotos: [Photos] = []
    var photosArray: Array<UIImageView> = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//       let service = VKService()
//
//        service.getCollectionPhotos(completion: {[weak self] in
//            self?.loadData()
//            service.getImageViewPhoto(photos: self!.loadedPhotos, complation: {image in
//                self?.photosArray = image
//                self?.collectionView.reloadData()
//            })
//        })
//
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photosArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendPhotoCell", for: indexPath) as! PhotosViewCell
        cell.photoImage.image = photosArray[indexPath.row].image
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    @IBAction func toTheFullScreenPhotos(_ sender: UIBarButtonItem){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewDestination = storyboard.instantiateViewController(withIdentifier: "FullScreenPhotoViewController") as! FullScreenPhotoViewController
        viewDestination.photosArrayFullScreen = photosArray
        self.navigationController?.pushViewController(viewDestination, animated: true)
    }
    
//    func loadData() {
//        do {
//        let realm = try Realm()
//        let photos = realm.objects(Photos.self)
//            self.loadedPhotos = Array(photos)
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
    
}
