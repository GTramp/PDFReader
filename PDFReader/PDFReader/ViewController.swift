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
        
        guard let fileUrl = Bundle.main.url(forResource: "objccn-core-data.pdf", withExtension: nil) else { return }
        let reader = PDFReader.init(fileUrl: fileUrl)
        present(reader, animated: true, completion: nil)
    }
    
}

