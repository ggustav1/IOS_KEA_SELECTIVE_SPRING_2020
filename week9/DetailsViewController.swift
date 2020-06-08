//
//  DetailsViewController.swift
//  FirebaseHelloWorld
//
//  Created by Gustav Vingtoft Andersen on 06/03/2020.
//  Copyright © 2020 Gustav Vingtoft Andersen. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var head: UITextView!
    @IBOutlet weak var body: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // CloudStorage.startListener(tableView: <#T##UITableView#>)
        CloudStorage.downloadImage(name: "cat.png", imgView: image)
        CloudStorage.getNote(id: "hpqjD8jEeeo1NlXPOAwD", headView: head, bodyView: body)
    }
}
