//
//  ViewController.swift
//  GurunabiSampleApp
//
//  Created by t.koike on 2020/12/12.
//

import UIKit
import MapKit
import Lottie
import Keys

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, DoneCatchDataProtocol {
    
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    let apiKey = GurunabiSampleAppKeys().gurunabiAPIKey
    let locationManager = CLLocationManager()
    var annotaion = MKPointAnnotation()
    var latitude = Double()
    var longitude = Double()
    var shopData = [ShopData]()
    var totalHitCount = Int()
    var url = [String]()
    var shopImage = [String]()
    var name = [String]()
    var tel = [String]()
    var indexNumber = Int()
    

    
    
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
        let latitude = location?.coordinate.latitude
        let longitude = location?.coordinate.longitude
        
        self.latitude = latitude!
        self.longitude = longitude!
        
        
    }
    
    @IBAction func tappedSearchButton(_ sender: Any) {
    
        //テキストフィールドを閉じる
        searchTextField.resignFirstResponder()
        //loading時のアニメーションの表示
        startLoading()
        
        let url = "https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=\(apiKey)&latitude=\(latitude)&longitude=\(longitude)&range=3&hit_per_page=50&freeword=\(searchTextField.text!)"
        
        let analyticsModel = AnalytictsModel(latitude: latitude, longitude: longitude, url: url)
        
        analyticsModel.doneCatchProtocl = self
        analyticsModel.setData()
       
    }

    
    
    func addAnnotation(ShopData: [ShopData]){
        
        removeAnnotations()
        
        for i in 0...totalHitCount - 1{
            
            annotaion = MKPointAnnotation()
            annotaion.coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(shopData[i].latitude!)!, CLLocationDegrees(shopData[i].longitude!)!)
            
            annotaion.title = ShopData[i].name
            annotaion.subtitle = ShopData[i].tel
            url.append(ShopData[i].url!)
            shopImage.append(ShopData[i].shopImage!)
            name.append(ShopData[i].name!)
            tel.append(ShopData[i].tel!)
            
            mapView.addAnnotation(annotaion)

        }
        
//        searchTextField.resignFirstResponder()
        
    }
    
    
    func removeAnnotations() {

        mapView.removeAnnotations(mapView.annotations)
    
    }

    
    
    
    
    
    func catchData(arrayData: Array<ShopData>, resultCount: Int) {
        
        stopLoading()
        
        shopData = arrayData
        totalHitCount = resultCount
        
        //shopDataの中身を取り出しannotaionとして設置
        addAnnotation(ShopData: shopData)
        
        
    }

    
//    annotaionがタップされたときの処理
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        indexNumber = Int()
        if name.firstIndex(of: (view.annotation?.title)!!) != nil {
            
            indexNumber = name.firstIndex(of: (view.annotation?.title)!!)!
            
        }
        
        performSegue(withIdentifier: "detailVC", sender: nil)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let detailVC = segue.destination as! DetailViewController
        detailVC.name = name[indexNumber]
        detailVC.tel =  tel[indexNumber]
        detailVC.imageURL = shopImage[indexNumber]
        detailVC.url = url[indexNumber]
        
        
    }
    
    
}
