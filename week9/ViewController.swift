//
//  ViewController.swift
//  FirebaseHelloWorld
//
//  Created by Gustav Vingtoft Andersen on 28/02/2020.
//  Copyright © 2020 Gustav Vingtoft Andersen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // @IBOutlet weak var displayImage: UIImageView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var tableView: UITableView!

    var images = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CloudStorage.startListener()
        images.append("cat.png")
        images.append("model-x.jpg")
        images.append("tesla house.jpg")
        images.append("tesla-cycle.jpg")
        //CloudStorage.deleteNote(id: "TOHhtPFBOWrrIYJvZeOo")
    }
    @IBAction func btnClicked(_ sender: Any) {
        CloudStorage.updateNote(index: 0, head: "New Headline", body: "New Body")
    }
    
    @IBAction func downloadBtnPressed(_ sender: Any) {
        CloudStorage.downloadImage(name: images.randomElement()!, imgView: image) // Calls static method and prints method
        
    }
    
   /* func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1");cell?.textLabel?.text = CloudStorage.getNoteAt(index: indexPath.row).head
        return cell!
    }*/
}

