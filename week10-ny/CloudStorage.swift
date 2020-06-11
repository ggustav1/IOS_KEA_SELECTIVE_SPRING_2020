//
//  CloudStorage.swift
//  CloudStorage
//
//  Created by Gustav Vingtoft Andersen on 11/06/2020.
//  Copyright © 2020 Gustav Vingtoft Andersen. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class CloudStorage {
    
    private static var list = [Note]()
    private static let db = Firestore.firestore()
    private static let storage = Storage.storage() // get the instance
    private static let notes = "note"
    private static let storageRef = storage.reference()
    
    static func uploadImage(image:UIImage) {
        let storageRef = storage.reference().child("testImage.png")
        if let uploadData = image.pngData() {
           storageRef.putData(uploadData, metadata: nil)
          }
    }
    
    
    
    static func downloadImage(name:String, image:UIImageView) {
        let imgRef = storage.reference(withPath: name) // get filehandle
        imgRef.getData(maxSize: 4500000) { (data, error) in
            print("success downloading image!")
            let img = UIImage(data: data!)
            DispatchQueue.main.async {
                image.image = img
            }
        }
    }
    
    static func startListener(tableView:UITableView) {
        print("starting listener")
    db.collection(notes).addSnapshotListener { (snap, error)  in
            if error == nil {
                self.list.removeAll() // clears the list
                for note in snap!.documents {
                    let map = note.data()
                    let head = map["head"] as! String
                    let body = map["body"] as! String
                    // This way we change the image text to "empty" if the value returns "nil"
                    let image = map["image"] as? String ?? "empty"
                    let newNote = Note(id: note.documentID, head: head, body: body, image: image)
                    self.list.append(newNote)
                }
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            }
        }
    }
    
    static func createNote(head:String, body:String, image:String) {
        var map = [String:String]()
        map["head"] = head
        map["body"] = body
        map["image"] = image
        db.collection(notes).addDocument(data: map)
    }
    
    
       static func getNoteAt(index:Int) -> Note {
        return list[index]
       }
    
    static func getSize() -> Int {
        return list.count
    }

    
    static func deleteNote(id:String) {
        let docRef = db.collection(notes).document(id)
        docRef.delete()
    }
    
    static func updateNote(index:Int, head:String, body:String, image:String) {
        let note = list[index]
        let docRef = db.collection(notes).document(note.id)
        var map = [String:String]()
        map["head"] = head
        map["body"] = body
        map["image"] = image
        docRef.setData(map)
    }
    
}
