//
//  ViewCertificateViewController.swift
//  VirtualLearn
//
//  Created by Sushruth H G on 21/12/22.
//

import UIKit

class ViewCertificateViewController: UIViewController {

    @IBOutlet weak var certificateImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func onClickCancel(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickDownload(_ sender: Any) {
        
    }
}
