//
//  CloudStorage.swift
//  FirebaseHelloWorld
//
//  Created by Gustav Vingtoft Andersen on 28/02/2020.
//  Copyright © 2020 Gustav Vingtoft Andersen. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class CloudStorage {
    
    private static var list = [Note]()
    private static let db = Firestore.firestore()
    private static let notes = "notes"
    private static let storage = Storage.storage() // Get the instance
    private static let docRef = db.collection("notes").document("hpqjD8jEeeo1NlXPOAwD")
    
    static func downloadImage(name:String, imgView: UIImageView){
        let imgRef = storage.reference(withPath: name) // get filehandle
        imgRef.getData(maxSize: 4000000) { (data, error) in
            if (error == nil) {
                print("Succes, downloading image! ")
                    // Now set image, using vc
                    let img = UIImage(data: data!)
                    DispatchQueue.main.async {
                    imgView.image = img
                }
            }
        }
    }

    static func startListener(){
        db.collection(notes).addSnapshotListener { (snap, error) in
            if error == nil {
                self.list.removeAll()
                for note in snap!.documents {
                    let map = note.data()
                    let head = map["head"] as! String
                    let body = map["body"] as! String
                   // let img = map["img"] as! String
                    let newNote = Note(id: note.documentID, head: head, body: body)
                    self.list.append(newNote)

                }
                /*DispatchQueue.main.async {
                    tableView.reloadData()
                }*/
            }
        }
    }
    
    static func deleteNote(id:String){
        let docRef = db.collection(notes).document(id)
        docRef.delete()
    }
    
    static func getNote(id:String, headView: UITextView, bodyView: UITextView){
        let docRef = db.collection(notes).document(id)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                
                let head = dataDescription
                
                headView.text = head
                
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
       
    }
    
    static func updateNote(index:Int, head:String, body:String)
    {
        let note = list[index]
        let docRef = db.collection(notes).document(note.id)
        var map = [String:String]()
        map["head"] = head
        map["body"] = body
       //  map["img"] = img
        docRef.setData(map)
    }
    
   

       
    
    static func getSize() -> Int {
        return list.count
    }
    
    static func getNoteAt(index:Int) -> Note {
        return list[index]
    }
    
}
