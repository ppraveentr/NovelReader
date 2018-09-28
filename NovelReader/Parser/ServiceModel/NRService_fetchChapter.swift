//
//  NRService_fetchNovelList.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

final class NRServiceResponse_fetchChapter: FTServiceModel {
    var response: NRNovelChapter? 
}

final class NRService_fetchChapter: FTServiceClient {
    
    var serviceName = "fetchChapter"
    var inputStack: FTServiceModel?
    var responseModelType: Any? = NRServiceResponse_fetchChapter.self

    init(inputStack: FTServiceModel?) {
        self.inputStack = inputStack
    }
}
