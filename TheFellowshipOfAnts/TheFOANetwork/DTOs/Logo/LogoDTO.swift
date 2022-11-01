//
//  LogoDTO.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/26.
//

import Foundation

extension DTO {
    struct Logo: Decodable {
        let meta: Meta?
        let url: String?

    }
    
    struct Meta: Decodable {
        let symbol: String
    }
}
