//
//  NRService_fetchNovelList.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

final class FTServicefetchChapter: ServiceClient {
    
    var serviceName = "fetchChapter"
    var inputStack: ServiceModel?
    var responseStackType: Any? = NovelChapterModel.self

    init(inputStack: ServiceModel?) {
        self.inputStack = inputStack
    }
}
