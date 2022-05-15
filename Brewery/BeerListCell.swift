//
//  BearListCell.swift
//  Brewery
//
//  Created by 구희정 on 2022/05/12.
//

import UIKit
import SnapKit
import Kingfisher

class BeerListCell : UITableViewCell {
    let beerImageView = UIImageView()
    let nameLabel = UILabel()
    let taglineLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //ContentView 에 Add 시켜주기.
        [beerImageView, nameLabel, taglineLabel].forEach{
            contentView.addSubview($0)
        }
        
        beerImageView.contentMode = .scaleAspectFit
        
        nameLabel.font = .systemFont(ofSize: 18, weight : .bold)
        nameLabel.numberOfLines = 2
        
        taglineLabel.font = .systemFont(ofSize: 14, weight: .light)
        taglineLabel.textColor = .systemBlue
        taglineLabel.numberOfLines = 0
        
        //bearImageView AutoLayout
        beerImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.top.bottom.equalToSuperview().inset(20)
            $0.width.equalTo(80)
            $0.height.equalTo(120)
            
        }
        //nameLabel AutoLayout
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(beerImageView.snp.trailing).offset(10)
            $0.bottom.equalTo(beerImageView.snp.centerY)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        //taglineLabel AutoLayou
        taglineLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(nameLabel)
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
    }
    func configure(with beer: Beer) {
        let imageURL = URL(string: beer.imageUrl ?? "")
        beerImageView.kf.setImage(with: imageURL, placeholder: UIImage(named: "beer_icon"))
        nameLabel.text = beer.name ?? "이름 없는 맥주"
        taglineLabel.text = beer.tagLine
        
        //셀의 오른쪽에 > 모양이 생김
        accessoryType = .disclosureIndicator
        //셀을 클릭해도 음영이 발생하지 않음
        selectionStyle = .none
    }
}
