//
//  Bear.swift
//  Brewery
//
//  Created by 구희정 on 2022/05/12.
//

import Foundation

struct Bear: Decodable {
    
    let id : Int?
    let name, taglineString, description, brewersTips, imageUrl : String?
    let foodParing : [String]?
    
    var tagLine: String {
        let tags = taglineString?.components(separatedBy: ". ")
        let hashtags = tags?.map {
            "#" + $0.replacingOccurrences(of: " ", with: "")
                .replacingOccurrences(of: ".", with: "")
                .replacingOccurrences(of: ",", with: "#")
        }
        //joined : 배열을 문자열로 만들어주는 메소드
        return hashtags?.joined(separator: " ") ?? ""       //ex) #tag #good #nie
    }
    
    // 서버에서 받을 키 값과 프로그램에서 사용할 키 값이 다를 경우
    // enum을 사용하여 인식을 시켜준다.
    enum CodingKeys : String, CodingKey {
        case id, name, description
        case taglineString = "tagline"
        case imageUrl = "image_url"
        case brewersTips = "brewers_tips"
        case foodParing = "food_pairing"
    }
}
