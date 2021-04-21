//
//  OurTownRankingTableViewCell.swift
//  wippysample
//
//  Created by Woncheol Heo on 2021/04/10.
//

import UIKit
import SnapKit

class OurTownRankingTableViewCell: UITableViewCell {
    let rankLabel = UILabel()
    let profileImageView = UIImageView()
    let meBoxImageView = UIImageView()
    let diffRankImageView = UIImageView()
    let infoLabel = UILabel()
    let diffRankLabel = UILabel()
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        rankLabel.text = ""
        infoLabel.text = ""
        profileImageView.image = nil
        meBoxImageView.image = nil
        diffRankLabel.text = ""
    }
    
    func setupWithDictionary( rankPerson : [String:Any]) {

        let isMe = rankPerson["is_me"] as! Bool
        if(isMe == true) {
            meBoxImageView.frame = CGRect(x: 26, y: 6, width: contentView.frame.width - 52, height: 58)
            meBoxImageView.layer.cornerRadius = 20
            meBoxImageView.image = UIImage(named:"mineBox")
            contentView.addSubview(meBoxImageView)
            
            let diffRank = rankPerson["diff_rank"] as! Int
            diffRankImageView.frame = CGRect(x: contentView.frame.width - 68, y: 30, width: 12, height: 10)
            if(diffRank > 0) {
                diffRankImageView.image = UIImage(named:"arrowUp")
            } else if(diffRank < 0){
                diffRankImageView.image = UIImage(named:"down")
            } else {
                diffRankImageView.image = nil
            }
            contentView.addSubview(diffRankImageView)

            diffRankLabel.frame = CGRect(x: contentView.frame.width - 90, y: 28, width: 18, height: 14)
            diffRankLabel.backgroundColor = .clear
            diffRankLabel.textColor = WSUtil.UIColorFromRGB(rgbValue: 0xA2A2A2)
            diffRankLabel.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 14)
            diffRankLabel.font = rankLabel.font.withSize(14)
            diffRankLabel.textAlignment = NSTextAlignment.center
            diffRankLabel.text = String(diffRank)
            contentView.addSubview(diffRankLabel)
        }
        
        rankLabel.frame = CGRect(x: 45, y: 22, width: 40, height: 26)
        rankLabel.backgroundColor = .clear
        rankLabel.textColor = WSUtil.UIColorFromRGB(rgbValue: 0xA2A2A2)
        rankLabel.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 22)
        rankLabel.font = rankLabel.font.withSize(22)
        rankLabel.textAlignment = NSTextAlignment.center
        rankLabel.text = String(rankPerson["rank"] as! Int)
        contentView.addSubview(rankLabel)
   
        profileImageView.frame = CGRect(x: 90, y: 16, width: 38, height: 38)
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.clear.cgColor
        profileImageView.clipsToBounds = true
        
        profileImageView.loadImage(urlString: rankPerson["profile_image"] as! String)
        contentView.addSubview(profileImageView)
        
        infoLabel.frame = CGRect(x: 140, y: 27, width: 200, height: 17)
        infoLabel.backgroundColor = .clear
        infoLabel.textColor = WSUtil.UIColorFromRGB(rgbValue: 0xA2A2A2)
        infoLabel.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 14)
        infoLabel.font = rankLabel.font.withSize(14)
        infoLabel.textAlignment = NSTextAlignment.left
        if(isMe == true) {
            let nickName = "나"
            let age = String(rankPerson["age"] as! Int)
            infoLabel.text = nickName + ", " + age
        } else {
            let nickName = rankPerson["nick_name"] as! String
            let age = String(rankPerson["age"] as! Int)
            infoLabel.text = nickName + ", " + age
        }
        contentView.addSubview(infoLabel)
    }
}


extension UIImageView {
    func loadImage(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
    }
}
