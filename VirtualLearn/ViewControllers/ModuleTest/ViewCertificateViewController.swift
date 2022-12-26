//
//  ViewCertificateViewController.swift
//  VirtualLearn
//
//  Created by Sushruth H G on 21/12/22.
//

import UIKit

class ViewCertificateViewController: UIViewController {
    var courseId = ""
    var imageUrl = ""
    let shared = mainViewModel.mainShared
    @IBOutlet weak var certificateImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        shared.chaptersDetailsViewModelShared.getCertificate(token: shared.token, courseId: courseId) { [self] result in
            imageUrl = result
            DispatchQueue.main.async {
                guard let url = URL(string: result ) else {return}
                guard let data = try? Data(contentsOf: url) else {return}
                self.certificateImage.image = UIImage(data: data)
            }
        } fail: { error in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
            
        }

    }
    

    @IBAction func onClickCancel(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickDownload(_ sender: Any) {
        shared.chaptersDetailsViewModelShared.downloadCertificate(imageUrl: imageUrl)
    }
}
