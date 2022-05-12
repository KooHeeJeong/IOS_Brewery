//
//  BearListCell.swift
//  Brewery
//
//  Created by 구희정 on 2022/05/12.
//

import UIKit
import SnapKit
import Kingfisher

class BearListCell : UITableViewCell {
    let bearImageView = UIImageView()
    let nameLabel = UILabel()
    let taglineLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //ContentView 에 Add 시켜주기.
        [bearImageView, nameLabel, taglineLabel].forEach{
            contentView.addSubview($0)
        }
        
        bearImageView.contentMode = .scaleAspectFit
        
        nameLabel.font = .systemFont(ofSize: 18, weight : .bold)
        nameLabel.numberOfLines = 2
        
        taglineLabel.font = .systemFont(ofSize: 14, weight: .light)
        taglineLabel.textColor = .systemBlue
        taglineLabel.numberOfLines = 0
        
        //bearImageView AutoLayout
        bearImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
            $0.width.equalTo(80)
            $0.height.equalTo(120)
            
        }
        //nameLabel AutoLayout
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(bearImageView.snp.trailing).offset(10)
            $0.bottom.equalTo(bearImageView.snp.centerY)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        //taglineLabel AutoLayou
        taglineLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(nameLabel)
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
        
        
    }
}
