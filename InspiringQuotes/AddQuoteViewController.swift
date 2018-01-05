//
//  AddQuoteViewController.swift
//  InspiringQuotes
//
//  Created by Fabio Quintanilha on 1/5/18.
//  Copyright © 2018 Fabio Quintanilha. All rights reserved.
//

import UIKit
import Firebase

class AddQuoteViewController: UIViewController {
    
    @IBOutlet weak var quoteMessageTextView: UITextView!
    @IBOutlet weak var authorTextField: UITextField!
    
    var docReference : DocumentReference!

    override func viewDidLoad() {
        super.viewDidLoad()

        docReference = Firestore.firestore().document("messages/inspiration")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveTapped(_ sender : UIButton) {
        
        guard let quoteTxt = quoteMessageTextView.text, !quoteTxt.isEmpty else { return }
        guard let authorTxt = authorTextField.text, !authorTxt.isEmpty else { return }
        
        let dataToSave: [String : Any] = ["quote" : quoteTxt,
                                        "author" : authorTxt ]
        
        docReference.setData(dataToSave) { (error) in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
            }
            else {
                print("Data has been saved!")
            }
        }
        
    }
 

}
