//
//  NRService_fetchNovelList.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

final class NRService_fetchNovelList: FTServiceClient {

    var serviceName = "fetchNovelList"
//    var responseType: FTModelData.Type { return [NRNovel].self }

    var inputStack: NRNovels?
    init(inputStack: FTModelData?) {
        self.inputStack = inputStack as? NRNovels
    }
}
