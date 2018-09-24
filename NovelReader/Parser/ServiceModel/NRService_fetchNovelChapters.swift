//
//  NRService_fetchNovelChapters.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

final class NRService_fetchNovelChapters: FTServiceClient {

    var serviceName = "fetchNovelChapters"
    var responseType: FTModelData.Type {
        return NRNovel.self
    }

    var inputStack: FTModelData?
    init(inputStack: FTModelData?) {
        self.inputStack = inputStack
    }

}
