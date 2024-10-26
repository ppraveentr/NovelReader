//
//  ServiceRecentUpdatesList.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import NetworkLayer

final class ServiceRecentUpdatesList: ServiceClient {
    var inputStack: ServiceModel?
    var serviceName = "fetchRecentUpdatesList"
    var responseStackType: Any? = NovelListModel.self

    init(inputStack: ServiceModel?) {
        self.inputStack = inputStack
    }
}
