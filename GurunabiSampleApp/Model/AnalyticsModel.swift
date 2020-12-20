//
//  AnalyticsModel.swift
//  GurunabiSampleApp
//
//  Created by t.koike on 2020/12/17.
//

import Foundation
import Alamofire
import SwiftyJSON


protocol DoneCatchDataProtocol {
    
    func catchData(arraayData: Array<ShopData>,resultCount: Int)
    
}



class AnalytictsModel{
    
    var latitude:Double?
    var longitude:Double?
    var url:String?
    var shopDateArray = [ShopData]()
    var doneCatchProtocl:DoneCatchDataProtocol?
    
    
    init(latitude:Double,longitude:Double,url:String){
        
        self.latitude = latitude
        self.longitude = longitude
        self.url = url
        
    }
    
    func setData() {
        
        //urlエンコーディング
        let encodedUrl:String = (url?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
        
        AF.request(encodedUrl, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
            
            print(response.debugDescription)
            
            switch response.result {
            
            case .success(_):
                do{
                    
                    let json:JSON = try JSON(data: response.data!)
                    
                    //                    print(json.debugDescription)
                    
                    var totalHitCount = json["total_hit_count"].int
                    
                    if totalHitCount! > 50{
                        
                        totalHitCount = 50
                        
                    }
                    
                    for i in 0...totalHitCount! - 1 {
                        
                        if json["rest"][i]["latitude"].string != "" && json["rest"][i]["longitude"].string != "" && json["rest"][i]["url"].string != "" && json["rest"][i]["name"].string != "" && json["rest"][i]["tel"].string != "" && (json["rest"][i]["image_url"]["shop_image1"].string != "") {
                            
                            
                            let shopData = ShopData(latitude: json["rest"][i]["latitude"].string ,
                                                                        longitude: json["rest"][i]["longitude"].string ,
                                                                        url: json["rest"][i]["url"].string ,
                                                                        name: json["rest"][i]["name"].string ,
                                                                        tel:json["rest"][i]["tel"].string ,
                                                                        restaurantImage: json["rest"][i]["image_url"]["shop_image1"].string)
                            
                            
                            self.shopDateArray.append(shopData)
                            //                            print(self.shopDateArray.debugDescription)
                            
                        }
                        
                    }
                    
                    
                    self.doneCatchProtocl?.catchData(arraayData: self.shopDateArray, resultCount: self.shopDateArray.count)
                    
                    
                }catch{
                    
                    print("エラー")
                    
                    
                }
                
            case .failure(_): break
                
                
            }
            
            
        }
        
        
        
        
    }
    
    
}

