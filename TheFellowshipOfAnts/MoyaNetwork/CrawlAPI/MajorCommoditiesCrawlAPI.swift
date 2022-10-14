//
//  MajorCommoditiesCrawlAPI.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/10/02.
//

import Foundation

struct MajorCommoditiesCrawlAPI: CrawlServiceAPI {
    var provider: CrawlProvider { .businessInside }
    var path: String { "/commodities" }
    var elementLinks: [String] {
        [
            ".font-color-black",
            ".push-data"
        ]
    }
}
