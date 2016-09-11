//
//  ViewController.swift
//  PDF Lib
//
//  Created by Marco Moreira on 11/09/16.
//  Copyright © 2016 MarcoMoreira92. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ReaderViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func OpenPDFButtonAction(sender: AnyObject) {
        let pdfs = NSBundle.mainBundle().pathsForResourcesOfType("pdf", inDirectory: nil)
        let filePath = pdfs.last!
        openPDF(filePath)
    }
    
    // TIP:
    // If you want to open a file from the internet you should download
    // it and save in  a folder ( for example the documents folder in your 
    // app and then pass it to this function to open the file.
    func openPDF(filePath : String){
        
        let document: ReaderDocument? = ReaderDocument.withDocumentFilePath(filePath, password: nil)
        if document != nil {
            let readerViewController: ReaderViewController = ReaderViewController(readerDocument: document)
            readerViewController.delegate = self
            readerViewController.modalTransitionStyle = .CoverVertical
            self.presentViewController(readerViewController, animated: true, completion: { _ in })
        }
        
    }
    
    func dismissReaderViewController(viewController: ReaderViewController) {
        self.dismissViewControllerAnimated(true, completion: { _ in })
    }
    
    
}

