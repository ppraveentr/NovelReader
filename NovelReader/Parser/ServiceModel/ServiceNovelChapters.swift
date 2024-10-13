//
//  ServiceNovelChapters.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import NetworkLayer

final class ServiceNovelChapters: ServiceClient {
    var serviceName = "fetchNovelChapters"
    var inputStack: ServiceModel?
    var responseStackType: Any? = NovelModel.self

    init(inputStack: ServiceModel?) {
        self.inputStack = inputStack
    }
}
