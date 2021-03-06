//
//  DetailViewController.swift
//  GurunabiSampleApp
//
//  Created by t.koike on 2020/12/12.
//

import UIKit
import WebKit
import SDWebImage

class DetailViewController: UIViewController {
    
    var url = String()
    var name = String()
    var tel = String()
    var imageURL = String()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.sd_setImage(with: URL(string: imageURL), completed: nil)
        let request = URLRequest(url: URL(string: url)!)
        webView.load(request)
        
    }
    

    
    @IBAction func tappedCallButton(_ sender: Any) {
        //    電話をかけられるようにする
        let PhoneNumber = tel.replacingOccurrences(of: "-", with: "")
        
        UIApplication.shared.open(URL(string: "tel://\(PhoneNumber)")!, options: [:], completionHandler: nil)
        
        
        
    }


}
