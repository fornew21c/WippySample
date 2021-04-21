//
//  OurTownRankingService.swift
//  wippysample
//
//  Created by Woncheol Heo on 2021/04/09.
//

import Foundation
import Alamofire

class OurTownRankingService {
    var rankList: [Any] = []
    var myInfo: MyInfo!
    
    func getRankList(_ callBack:@escaping ([Any]) -> Void) {
        
        let urlStr = "https://static.wippy.io/c/nrise_data/nrise_data.json"
        
        Alamofire.request(
            urlStr,
            method: .get,
            parameters: [:],
            encoding: URLEncoding.default,
            headers: [:])
            .validate(statusCode: 200..<500)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    self.myInfo = MyInfo()
                    self.myInfo.location = json["location"] as? String
                    self.myInfo.myProfileImage = json["my_profile_image"] as? String
                    self.myInfo.myRank = json["my_rank"] as? Int
                    self.myInfo.segment = json["segment"] as? String
                    self.myInfo.percent =  json["percent"] as? String
                    
                    self.rankList = json["rank_list"] as! [Any]
                    callBack(self.rankList)
                }
            }
    }
    
    func getMyInfo(_ callBack:@escaping (MyInfo) -> Void) {
        callBack(self.myInfo)
    }
}
