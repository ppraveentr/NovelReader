//
//  NRService_fetchNovelList.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

final class NRServiceResponse_fetchNovelList: FTServiceModel {
    var response: [NRNovel]?
}

final class NRService_fetchNovelList: FTServiceClient {

    var serviceName = "fetchNovelList"

    var inputStack: NRNovels?
    var responseModelType: Any? = NRServiceResponse_fetchNovelList.self

    init(inputStack: FTServiceModel?) {
        self.inputStack = inputStack as? NRNovels
    }
    
}
