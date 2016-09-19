//
//  EffectView.swift
//  sampleCoreImage
//
//  Created by CanDang on 12/29/15.
//  Copyright © 2015 CanDang. All rights reserved.
//

import Foundation
import UIKit
let kSampleImageName = "sample.png"
class EffectView: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout
{
    var filters = [CIFilter]()
    var defaultImgs = [UIImage]()
    var imageEffect = UIImage?()
    let filterDescriptions: [(filterName: String, filterDisplayName: String)] =
    [
        ("CIColorControls", "None"),
        ("CIPhotoEffectMono", "Mono"),
        ("CIPhotoEffectTonal", "Tonal"),
        ("CIPhotoEffectNoir", "Noir"),
        ("CIPhotoEffectFade", "Fade"),
        ("CIPhotoEffectChrome", "Chrome"),
        ("CIPhotoEffectProcess", "Process"),
        ("CIPhotoEffectTransfer", "Transfer"),
        ("CIPhotoEffectInstant", "Instant"),
        ("CIColorControls", "Cl Controls"),
        ("CIColorPosterize", "Cl Posterize"),
        ("CIExposureAdjust", "Exposure Adjust"),
        ("CIGammaAdjust", "Gamma Adjust")
    ]
    @IBAction func saveImage(sender: UIBarButtonItem)
    {
        UIImageWriteToSavedPhotosAlbum(imgView.image!, self, nil, nil)
    }
    @IBAction func openAlbum(sender: UIBarButtonItem)
    {
        let imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        imgPicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imgPicker, animated: true, completion: nil)
    }
    @IBOutlet weak var imgView: ViewFilter!
    
    @IBOutlet weak var colectionView: UICollectionView!
    //Image Picker Controller Delegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage:UIImage = (info[UIImagePickerControllerOriginalImage]) as? UIImage
        {
            imgView.image = pickedImage
            imageEffect = pickedImage
        }
        [self.dismissViewControllerAnimated(true, completion: nil)]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        for description in filterDescriptions
        {
            filters.append(CIFilter(name: description.filterName)!)
            if let img = UIImage(named: description.filterDisplayName)
            {
                defaultImgs.append(img)
            }
        }
        imageEffect = UIImage(named: kSampleImageName)
        imgView.image = imageEffect
    }
    
    //Mark : CollectionView
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterDescriptions.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CellColection", forIndexPath: indexPath) as! PhotoEffectColectionCell
        if (indexPath.item < 9)
        {
            cell.filteredImageView.image = defaultImgs[indexPath.item]
        }
        else
        {
            cell.filteredImageView.image = UIImage(named: "filter.png")
        }
        cell.filteredImageView.contentMode = .ScaleAspectFill
        cell.filter = filters[indexPath.item]
        cell.filterNameLabel.text = filterDescriptions[indexPath.item].filterDisplayName
        return cell
        
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.item < 9)
        {
            let tempCIImage = CIImage(image: imageEffect!)
            filters[indexPath.item].setValue(tempCIImage, forKey: kCIInputImageKey)
            let uiTemp = imgView.getImageFilter(filters[indexPath.item])
            imgView.image = uiTemp
            
        }
        else
        {
            let mapViewControllerObejct = self.storyboard?.instantiateViewControllerWithIdentifier("FilterView") as? FilterView
            mapViewControllerObejct?.filter = filters[indexPath.item]
            mapViewControllerObejct?.image = imgView.image
            self.navigationController?.pushViewController(mapViewControllerObejct!, animated: true)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
