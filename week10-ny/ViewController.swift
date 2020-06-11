//
//  ViewController.swift
//  CloudStorage
//
//  Created by Gustav Vingtoft Andersen on 11/06/2020.
//  Copyright © 2020 Gustav Vingtoft Andersen. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var header: UITextView!
    @IBOutlet weak var body: UITextView!
    @IBOutlet weak var imageText: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    var rowNumber = 0
    
    @IBAction func btnClicked(_ sender: UIButton) {
        CloudStorage.createNote(head: header.text, body: body.text, image: imageText.text)
    }
    
    @IBAction func presentPhoto(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .photoLibrary
            self.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let note = CloudStorage.getNoteAt(index: rowNumber)
        header.text = note.head
        body.text = note.body
        if note.image != "empty" {
            imageText.text = note.image; CloudStorage.downloadImage(name: note.image, image: imageView)
        } else {
            print("image is empty")
        }
    }
    
    
    
    func imgPickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var image: UIImage
        if let possibleImage = info[.editedImage] as? UIImage {
            image = possibleImage
        } else {
            return
        }
        print(image.size)
        dismiss(animated: true)
        CloudStorage.uploadImage(image: image)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}

