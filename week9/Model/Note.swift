//
//  Note.swift
//  FirebaseHelloWorld
//
//  Created by Gustav Vingtoft Andersen on 28/02/2020.
//  Copyright © 2020 Gustav Vingtoft Andersen. All rights reserved.
//

import Foundation

class Note {
    var id:String
    var head:String
    var body:String
    // var img:String
    
    init(id:String, head:String, body:String){ // img:String
        self.id = id
        self.head = head
        self.body = body
       // self.img = img
    }
}
