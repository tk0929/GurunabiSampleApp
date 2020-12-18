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
    
    var lattiudeValue:Double?
    var longitudeValue:Double?
    var urlString:String?

    init(lattiude:Double,longitude:Double,url:String){
        
        lattiudeValue = lattiude
        longitudeValue = longitude
        urlString = url
        
        
    }


}

