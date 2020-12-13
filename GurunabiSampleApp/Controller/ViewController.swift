//
//  ViewController.swift
//  GurunabiSampleApp
//
//  Created by t.koike on 2020/12/12.
//

import UIKit
import MapKit
import Lottie

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    lazy var loadingAnimation:AnimationView = {
        
        let animationView = AnimationView(name: "1")
        animationView.frame = view.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        
        return animationView
        
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startUpdatingLocation()
        
        
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
    
    //
    func startUpdatingLocation(){
        
        if #available(iOS 14.0, *) {
            
            let status = locationManager.authorizationStatus
            
            switch status {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            default:
                break
            }
            
        }else{
            
            let status = CLLocationManager.authorizationStatus()
            
            switch status {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            default:
                break
                
            }
            
            locationManager.startUpdatingLocation()
            
        }
        
        
        
        
        
        
        
    }
    
}
