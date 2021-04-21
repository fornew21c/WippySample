//
//  OurTownRankingViewController.swift
//  wippysample
//
//  Created by Woncheol Heo on 2021/04/09.
//

import UIKit
import SnapKit

class OurTownRankingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView: UITableView = UITableView()
    var rankList: [Any] = []
    var myInfo: MyInfo = MyInfo()
    
    lazy var titleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var myInfoView: UIView = {
        let view = UIView()
        //view.backgroundColor = WSUtil.UIColorFromRGB(rgbValue: 0x745FFF)
        view.backgroundColor = .white
        return view
    }()
    
    let ourTownRankPresenter = OurTownRankingPresenter(ourTownRankingService: OurTownRankingService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.register(OurTownRankingTableViewCell.self, forCellReuseIdentifier: "OurTownRankingTableViewCell")
        view.backgroundColor = .white
        
        ourTownRankPresenter.setViewDelegate(ourTownRankingViewDelegate: self)
        ourTownRankPresenter.getRankList()
        
        
        let backButton = UIButton()
        let buttonImage : UIImage = UIImage(named:"back")!
        backButton.setImage(buttonImage, for: .normal)
        backButton.frame = CGRect(x: 20, y: 23, width: 12, height: 17)
        titleView.addSubview(backButton)
        
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 44, y: 22, width: 108, height: 22)
        titleLabel.backgroundColor = .white
        titleLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        titleLabel.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 18)
        titleLabel.text = "우리 동네 랭킹"
       
        titleView.addSubview(titleLabel)
       
        view.addSubview(titleView)
        titleView.snp.makeConstraints{ (make) in
            make.width.equalTo(view)
            make.height.equalTo(64)
            make.top.equalTo(view).offset(20)
        }
        
        let bgImageView = UIImageView()
        bgImageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 247)
        bgImageView.image = UIImage(named: "myInfo_bg")
        myInfoView.addSubview(bgImageView)
        
        let waveImageView = UIImageView()
        waveImageView.frame = CGRect(x: 0, y: 223, width: view.frame.width, height: 24)
        waveImageView.image = UIImage(named: "wave")
        myInfoView.addSubview(waveImageView)
        
 
        view.addSubview(myInfoView)
        myInfoView.snp.makeConstraints { (make) in
            make.width.equalTo(view)
            make.height.equalTo(247)
            make.top.equalTo(titleView.snp.bottom).offset(0)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.width.equalTo(view)
            make.top.equalTo(myInfoView.snp.bottom).offset(0)
            make.bottom.equalTo(view).offset(0)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "OurTownRankingTableViewCell", for: indexPath) as! OurTownRankingTableViewCell
        
        if let rankPerson = rankList[indexPath.row] as? [String:Any] {
            cell.setupWithDictionary(rankPerson: rankPerson)
           
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension OurTownRankingViewController: OurTownRankingViewDelgate {
    func setMyInfo(myInfo: MyInfo) {
        self.myInfo = myInfo
        let locationLabel = UILabel()
        locationLabel.text = self.myInfo.location
        locationLabel.frame = CGRect(x: view.frame.width/2 - 63, y: 40, width: 130, height: 26)
        locationLabel.backgroundColor = .clear
        locationLabel.textColor = .white
        locationLabel.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 24)
        locationLabel.font = locationLabel.font.withSize(24)
        myInfoView.addSubview(locationLabel)
        
        let profileImageView = UIImageView()
        profileImageView.frame = CGRect(x: 128, y: 85, width: 34, height: 34)
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.clear.cgColor
        profileImageView.clipsToBounds = true
        do {
            let url : URL! = URL(string: self.myInfo.myProfileImage)
            let data = try Data(contentsOf: url)
            profileImageView.image = UIImage(data: data)
        }
        catch{
            print(error)
        }
        myInfoView.addSubview(profileImageView)
        
        let myRankLabel = UILabel()
        myRankLabel.text = String(self.myInfo.myRank)
        myRankLabel.frame = CGRect(x: 172, y: 79, width: 54, height: 53)
        myRankLabel.backgroundColor = .clear
        myRankLabel.textColor = .white
        myRankLabel.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 44)
        myRankLabel.font = locationLabel.font.withSize(44)
        myInfoView.addSubview(myRankLabel)
        
        let textLabel = UILabel()
        textLabel.text = "위"
        textLabel.frame = CGRect(x: 227, y: 100, width: 19, height: 24)
        textLabel.backgroundColor = .clear
        textLabel.textColor = .white
        textLabel.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 20)
        textLabel.font = textLabel.font.withSize(20)
        myInfoView.addSubview(textLabel)
        
        let segmentLabel = UILabel()
        segmentLabel.text = "오늘 위피를 이용한 " + self.myInfo.segment + " 동성 친구들 중 "
        segmentLabel.frame = CGRect(x: view.frame.width/2 - 120, y: 146, width: 240, height: 26)
        segmentLabel.backgroundColor = .clear
        segmentLabel.textColor = .white
        segmentLabel.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 12)
        segmentLabel.font = textLabel.font.withSize(12)
        myInfoView.addSubview(segmentLabel)
        
        let staticLabel1 = UILabel()
        staticLabel1.text = "인기도는 "
        staticLabel1.frame = CGRect(x: 114, y: 169, width: 45, height: 14)
        staticLabel1.backgroundColor = .clear
        staticLabel1.textColor = .white
        staticLabel1.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 12)
        staticLabel1.font = textLabel.font.withSize(12)
        myInfoView.addSubview(staticLabel1)

        let percentLabel = UILabel()
        percentLabel.text = self.myInfo.percent
        percentLabel.frame = CGRect(x: 162, y: 169, width: 59, height: 17)
        percentLabel.backgroundColor = .clear
        percentLabel.textColor = .white
        percentLabel.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 14)
        percentLabel.font = textLabel.font.withSize(14)
        myInfoView.addSubview(percentLabel)
        
        let staticLabel2 = UILabel()
        staticLabel2.text = " 입니다"
        staticLabel2.frame = CGRect(x: 224, y: 169, width: 45, height: 14)
        staticLabel2.backgroundColor = .clear
        staticLabel2.textColor = .white
        staticLabel2.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 12)
        staticLabel2.font = textLabel.font.withSize(12)
        myInfoView.addSubview(staticLabel2)
//
    }
    
    func setRankList(rankList: [Any]) {
        self.rankList = rankList
        print("self.ranklist : \(self.rankList)")
        tableView.reloadData()
        ourTownRankPresenter.getMyInfo()
    }
    
    func setEmpatyRankList() {
    }
    
    //start indicator
    func startLoading() {
       // startIndicator()
    }

    //finish indicator
    func finishLoading() {
       // stopIndicator()
    }
    
    func reload() {
        //tableView.reloadData()
    }
}
