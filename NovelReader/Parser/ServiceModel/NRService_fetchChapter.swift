//
//  NRService_fetchNovelList.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

final class NRService_fetchChapter: FTServiceClient {
    var serviceName = "fetchChapter"
    var inputStack: FTModelData?

//    var responseType: FTModelData.Type {
//        return NRNovelChapter.self
//    }
    init(inputStack: FTModelData?) {
        self.inputStack = inputStack
    }
}
