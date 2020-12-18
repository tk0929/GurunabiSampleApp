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
    var lattiudeValue = Double()
    var longitudeValue = Double()
    
    
    lazy var loadingAnimation:AnimationView = {
        
        let animationView = AnimationView(name: "1")
        animationView.frame = view.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        
        return animationView
        
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startUpdationgLocation()
        configureSubViews()
        
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
 
// 位置情報取得の許可を促すポップアップ
    func startUpdationgLocation() {
        
        locationManager.requestWhenInUseAuthorization()
        //　正確な位置情報を取得
        let status = CLAccuracyAuthorization.fullAccuracy
        if status == .fullAccuracy{
            
            locationManager.startUpdatingLocation()
            
        }
        
        
    }
   
//////    //位置情報取得許可ポップアップ
//    func startUpdatingLocation(){
//
//        if #available(iOS 14.0, *) {
//
//            let status = locationManager.authorizationStatus
//
//            switch status {
//            case .notDetermined:
//                locationManager.requestWhenInUseAuthorization()
//            default:
//                break
//            }
//
//        }else{
//
//            let status = CLLocationManager.authorizationStatus()
//
//            switch status {
//            case .notDetermined:
//                locationManager.requestWhenInUseAuthorization()
//            default:
//                break
//
//            }
//
//            locationManager.startUpdatingLocation()
//
//        }
//    }
//

    
        func configureSubViews() {
            //位置情報を取得する際の精度と取得間隔を指定する
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
//            locationManager.requestWhenInUseAuthorization()
            locationManager.distanceFilter = 10
            locationManager.startUpdatingLocation()
//mapViewのタイプとユーザー追跡モードの設定
            mapView.delegate = self
            mapView.mapType = .standard
            mapView.userTrackingMode = .follow
        }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.first
        let lattiude = location?.coordinate.latitude
        let longitude = location?.coordinate.longitude
        
        lattiudeValue = lattiude!
        longitudeValue = longitude!
        
        
    }
    
    @IBAction func tappedSearchButton(_ sender: Any) {
    
        //テキストフィールドを閉じる
        searchTextField.resignFirstResponder()
        //loading時のアニメーションの表示
        startLoading()
        
        
        
   
        
        
    }


    
    
}
