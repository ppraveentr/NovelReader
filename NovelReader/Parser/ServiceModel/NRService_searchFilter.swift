//
//  NRService_searchFilter.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 13/10/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

final class FTServicesearchFilter: FTServiceClient {
    var inputStack: NRSearchModel?
    var serviceName = "searchFilter"
    var responseStackType: Any? = NRSearchFilterModel.self

    init(inputStack: FTServiceModel?) {
        self.inputStack = inputStack as? NRSearchModel
    }
}
