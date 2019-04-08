//
//  ViewController.swift
//  PDFReader
//
//  Created by tramp on 2019/4/8.
//  Copyright © 2019 tramp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let reader = PDFReader.init(url: URL.init(string: "xxxxxxx")!)
        present(reader, animated: true, completion: nil)
    }

}

