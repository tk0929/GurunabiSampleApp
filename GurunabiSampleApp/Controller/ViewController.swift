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
 
   
////    //位置情報取得許可ポップアップ
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
    
//位置情報を取得する際の精度と取得間隔を指定する
        func configureSubViews() {

            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = 10
            locationManager.startUpdatingLocation()
//mapViewのタイプとユーザー追跡モードの設定
            mapView.delegate = self
            mapView.mapType = .standard
            mapView.userTrackingMode = .follow
        }


    


    
}
