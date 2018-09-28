//
//  NRService_fetchNovelChapters.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

final class NRServiceResponse_fetchNovelChapters: FTServiceModel {
    var response: NRNovel?
}

final class NRService_fetchNovelChapters: FTServiceClient {
    var serviceName = "fetchNovelChapters"
    var inputStack: FTServiceModel?
    var responseModelType: Any? = NRServiceResponse_fetchNovelChapters.self

    init(inputStack: FTServiceModel?) {
        self.inputStack = inputStack
    }

}
