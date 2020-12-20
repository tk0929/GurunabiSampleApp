//
//  AnalyticsModel.swift
//  GurunabiSampleApp
//
//  Created by t.koike on 2020/12/17.
//

import Foundation
import Alamofire
import SwiftyJSON

class AnalytictsModel{
    
    var lattiude:Double?
    var longitude:Double?
    var url:String?
    var shopDateArray = [GurunabiRestaurantData]()
    
    init(lattiude:Double,longitude:Double,url:String){
        
        self.lattiude = lattiude
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
                        
                        if json["rest"][i]["lattiude"].string != "" && json["rest"][i]["longitude"].string != "" && json["rest"][i]["url"].string != "" && json["rest"][i]["name"].string != "" && json["rest"][i]["tel"].string != "" && (json["rest"][i]["image_url"]["shop_image1"].string != "") {
                            
                            
                            let restaurantData = GurunabiRestaurantData(latitude: json["rest"][i]["lattiude"].string ,
                                                                         longitude: json["rest"][i]["longitude"].string ,
                                                                         url: json["rest"][i]["url"].string ,
                                                                         name: json["rest"][i]["name"].string ,
                                                                         tel:json["rest"][i]["tel"].string ,
                                                                         restaurantImage: json["rest"][i]["image_url"]["shop_image1"].string)
                            
                            
                            self.shopDateArray.append(restaurantData)
//                            print(self.shopDateArray.debugDescription)
                            
                        }
                        
                    }
                    
                }catch{
                    
                    print("エラー")
                    
                    
                }
                
            case .failure(_): break
                
                
            }
            
            
        }
        
        
        
        
    }


}

