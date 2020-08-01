//
//  ServiceNovelList.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

final class ServiceNovelList: ServiceClient {

    var serviceName = "fetchNovelList"
    var inputStack: NovelListModel?
    var responseStackType: Any? = NovelListModel.self

    init(inputStack: ServiceModel?) {
        self.inputStack = inputStack as? NovelListModel
    }
}
