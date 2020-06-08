//
//  ViewController.swift
//  MediaCaptureDemo
//
//  Created by Gustav Vingtoft Andersen on 27/03/2020.
//  Copyright © 2020 Gustav Vingtoft Andersen. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    var imagePicker = UIImagePickerController() // This will handle the task of fetching an image from the iOS syststem
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self // assign the object from this class to handle image picking events
        // Do any additional setup after loading the view.
    }
    
    fileprivate func launchCamera() {
        imagePicker.sourceType = .camera
        imagePicker.showsCameraControls = true
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    @IBAction func cameraPhotoBtnPressed(_ sender: UIButton) {
        print("Taking picture")
        launchCamera()
    }
    @IBAction func videoBtnPressed(_ sender: UIButton) {
        imagePicker.mediaTypes = ["public.movie"] // will launch the video
        imagePicker.videoQuality = .typeMedium // set quality level 
        launchCamera()
    }
    
    // Get the image from the imagepicker
    @IBAction func photoBtnPressed(_ sender: UIButton) {
        // What type of data do you want?
        imagePicker.sourceType = .photoLibrary // What type of task: camera or photoalbum
        imagePicker.allowsEditing = true; // if the user wishes to be able to zoom in before getting the image
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("returned from image picking")
        // we either have an image or video at this point
        // 1. if it's a video, do this:
        if let url = info[.mediaURL] as? URL { // this will only be true, if there is a video
        if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path) {
            UISaveVideoAtPathToSavedPhotosAlbum(url.path, nil, nil, nil) // minimal version of save
            
        } else {
            print("error in video")
            }
        // if we have an image
        } else {
            let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            imageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // register touch on mobile screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // print("touch")
    }
    
    // register slide touch on mobile screen
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let p = touches.first?.location(in: view) {
            // print("moved to: \(p)")
            // imageView.transform = CGAffineTransform(translationX: p.x, y: 0)
        }
    }
}
