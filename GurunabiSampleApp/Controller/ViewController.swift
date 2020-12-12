//
//  ViewController.swift
//  GurunabiSampleApp
//
//  Created by t.koike on 2020/12/12.
//

import UIKit
import MapKit
import Lottie

class ViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    lazy var loadingAnimation:AnimationView = {
        
        let animationView = AnimationView(name: "1")
        animationView.frame = view.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        
        return animationView
        
    }()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
 
// アニメーションの開始
    func startLoading() {
        view.addSubview(loadingAnimation)
        loadingAnimation.play()
    }
    
// アニメーションの停止(削除)
    func stopLoading() {
        loadingAnimation.removeFromSuperview()
    }


}

