//
//  NRService_searchNovel.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 05/10/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

final class FTServicesearchNovel: ServiceClient {
    var inputStack: NRSearchModel?
    var serviceName = "searchNovel"
    var responseStackType: Any? = NovelListModel.self

    init(inputStack: ServiceModel?) {
        self.inputStack = inputStack as? NRSearchModel
    }
}
