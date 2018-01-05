//
//  ViewController.swift
//  InspiringQuotes
//
//  Created by Fabio Quintanilha on 1/5/18.
//  Copyright © 2018 Fabio Quintanilha. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    var docReference : DocumentReference!
    var quoteListener : ListenerRegistration!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        docReference = Firestore.firestore().document("messages/inspiration")
    }
    
    
    //Here the data is downloaded in the real time
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //quoteListener will listen to the snapshot and closes it when the viewController disappear using the viewWillDisappear
        quoteListener = docReference.addSnapshotListener { (docSnapshot, error) in
            guard let docSnapshot = docSnapshot, docSnapshot.exists else { return }
            let myData = docSnapshot.data()
            let latestQuote = myData["quote"] as? String ?? ""
            let quoteAutor = myData["author"] as? String ?? ""
            
            self.quoteLabel.text = latestQuote
            self.authorLabel.text = quoteAutor
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        quoteListener.remove()
    }
    
   // this function fetch the data. This function is not been used in this app, It is only for sample
    func fetchData () {
        docReference.getDocument { (docSnapshot, error) in
            guard let docSnapshot = docSnapshot, docSnapshot.exists else { return }
            let myData = docSnapshot.data()
            let latestQuote = myData["quote"] as? String ?? ""
            let quoteAutor = myData["author"] as? String ?? ""

            self.quoteLabel.text = latestQuote
            self.authorLabel.text = quoteAutor
        }
    }
}

