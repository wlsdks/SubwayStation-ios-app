//
//  StationResponseModel.swift
//  SubwayStation-ios-app
//
//  Created by 최진안 on 2023/05/21.
//

import Foundation

struct StationResponseModel: Decodable {
    
    // private로 가져다 사용하지 못하게 하고 아래의 stations로 searchInfo의 row값을 가져다 사용해서 편의성을 높여준다.
    var stations: [Station] { searchInfo.row }
    
    private let searchInfo: SearchInfoBySubwayNameServiceModel
    
    enum CodingKeys: String, CodingKey {
        case searchInfo = "SearchInfoBySubwayNameService"
    }
    
    struct SearchInfoBySubwayNameServiceModel: Decodable {
        var row: [Station] = []
        
    }
}

struct Station: Decodable {
    let stationName: String
    let lineNumber: String
    
    // 실제 받아오는 값의 이름으로 바꿔준다.
    enum CodingKeys: String, CodingKey {
        case stationName = "STATION_NM"
        case lineNumber = "LINE_NUM"
    }
}
