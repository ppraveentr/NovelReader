//
//  NRService_searchFilter.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 13/10/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

final class NRServiceResponse_searchFilter: FTServiceModel {
    var response: NRSearchFilterModel?
}

final class NRService_searchFilter: FTServiceClient {
    var inputStack: NRSearchModel?
    var serviceName = "searchFilter"
    var responseModelType: Any? = NRServiceResponse_searchFilter.self

    init(inputStack: FTServiceModel?) {
        self.inputStack = inputStack as? NRSearchModel
    }

}
