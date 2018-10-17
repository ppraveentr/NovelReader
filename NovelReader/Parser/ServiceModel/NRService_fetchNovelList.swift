//
//  NRService_fetchNovelList.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

typealias FTServicefetchNovelList = NRService_fetchNovelList
final class NRService_fetchNovelList: FTServiceClient {

    var serviceName = "fetchNovelList"
    var inputStack: NRNovels?
    var responseStackType: Any? = NRNovels.self

    init(inputStack: FTServiceModel?) {
        self.inputStack = inputStack as? NRNovels
    }
    
}
