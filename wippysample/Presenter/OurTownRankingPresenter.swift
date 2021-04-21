//
//  OurTownRankingPresenter.swift
//  wippysample
//
//  Created by Woncheol Heo on 2021/04/09.
//

import UIKit

protocol OurTownRankingViewDelgate: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    
    func setRankList(rankList: [Any])
    func setMyInfo(myInfo: MyInfo)
    func setEmpatyRankList()
}

class OurTownRankingPresenter {
    private let ourTownRankingService: OurTownRankingService
    private var ourTownRankingViewDelegate: OurTownRankingViewDelgate?
    
    init(ourTownRankingService: OurTownRankingService) {
        self.ourTownRankingService = ourTownRankingService
    }
    
    func setViewDelegate(ourTownRankingViewDelegate: OurTownRankingViewDelgate) {
        self.ourTownRankingViewDelegate = ourTownRankingViewDelegate
    }
    
    func getRankList() {
        ourTownRankingService.getRankList { [weak self] rankList in
            self?.ourTownRankingViewDelegate?.setRankList(rankList: rankList)
            
        }
    }
    
    func getMyInfo() {
        ourTownRankingService.getMyInfo{ [weak self]  myInfo in
            self?.ourTownRankingViewDelegate?.setMyInfo(myInfo: myInfo)
        }
    }
}
