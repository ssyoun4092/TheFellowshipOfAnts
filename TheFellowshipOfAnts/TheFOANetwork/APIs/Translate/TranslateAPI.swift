//
//  TranslateAPI.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/27.
//

import Foundation

import Moya

struct TranslateAPI: ServiceAPI {
    typealias ResponseDTO = DTO.Translate
    var text: String
    init(text: String) {
        self.text = text
    }
    var provider: APIProvider { .naver }
    var method: Moya.Method { .post }
    var path: String { "/v1/papago/n2mt" }
    var task: Moya.Task {
        .requestParameters(parameters: [
            "source": "ko",
            "target": "en",
            "text": text
        ], encoding: URLEncoding.default)
    }

    var headers: [String : String]? {
        return [
            "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
            "X-Naver-Client-ID": "ASAlIspGHK5XDC_9NdDi",
            "X-Naver-Client-Secret": apiKey
        ]
    }
}
