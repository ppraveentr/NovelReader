//
//  ServiceSearchNovel.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 05/10/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

final class ServiceSearchNovel: ServiceClient {
    var inputStack: SearchNovelModel?
    var serviceName = "searchNovel"
    var responseStackType: Any? = NovelListModel.self

    init(inputStack: ServiceModel?) {
        self.inputStack = inputStack as? SearchNovelModel
    }
}
