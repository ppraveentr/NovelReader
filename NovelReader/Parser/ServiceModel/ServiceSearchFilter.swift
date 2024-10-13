//
//  ServiceSearchFilter.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 13/10/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import NetworkLayer

final class ServiceSearchFilter: ServiceClient {
    var inputStack: SearchNovelModel?
    var serviceName = "searchFilter"
    var responseStackType: Any? = SearchFilterModel.self

    init(inputStack: ServiceModel?) {
        self.inputStack = inputStack as? SearchNovelModel
    }
}
