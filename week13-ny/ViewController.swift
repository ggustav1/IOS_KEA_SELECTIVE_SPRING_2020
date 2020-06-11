//
//  ViewController.swift
//  MemeProject
//
//  Created by Gustav Vingtoft Andersen on 08/06/2020.
//  Copyright © 2020 Gustav Vingtoft Andersen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    
    var imagePicker = UIImagePickerController() // will handle the task of fetching an image from the iOS system
    
    @IBAction func photosBtnPressed(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary // this sets the source of the imagepicker to the photolibrary - can also be set to camera
        imagePicker.allowsEditing = true // should the user be able to zoom in before getting the image
        present(imagePicker, animated: true, completion: nil) // the present method is included in ViewController and is an alternative to segue
    }
    
    @IBAction func cameraVideoBtnPressed(_ sender: UIButton) {
        imagePicker.mediaTypes = ["public.movie"] // will launch the video in the camera app
        imagePicker.videoQuality = .typeMedium // set quality
        launchCamera()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self // assign the object from this class to handle image picking return - references the objet
    }
    
    fileprivate func launchCamera() {
        imagePicker.sourceType = .camera
        imagePicker.showsCameraControls = true
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraPhotoBtnPressed(_ sender: UIButton) {
        launchCamera()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // we either have an image or a video
        
        if let url = info[.mediaURL] as? URL { // this will only be true if there was a video
            if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path) {
                UISaveVideoAtPathToSavedPhotosAlbum(url.path, nil, nil, nil) // minimal version of save
            }
            picker.dismiss(animated: true, completion: nil)
        } else { // if we have an image
            if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                imageView.image = image
            }
            picker.dismiss(animated: true, completion: nil)
        }
        
        print("returned from image picking")
        
    }
    
    var startPoint = CGFloat(0)
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch began")
        if let p = touches.first?.location(in: view) {
            startPoint = p.x
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let p = touches.first?.location(in: view) {
            let diff = p.x - startPoint // calculate the difference between the first touch and the current finger position
            imageView.transform = CGAffineTransform(translationX: diff, y: 0)
        }

    }
    
}
