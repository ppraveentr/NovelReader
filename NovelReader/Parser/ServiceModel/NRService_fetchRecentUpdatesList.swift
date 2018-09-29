//
//  NRService_fetchRecentUpdatesList.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

final class NRServiceResponse_fetchRecentUpdatesList: FTServiceModel {
    var response: [NRNovel]?
}

final class NRService_fetchRecentUpdatesList: FTServiceClient {

    var inputStack: FTServiceModel?
    var serviceName = "fetchRecentUpdatesList"
    var responseModelType: Any? = NRServiceResponse_fetchRecentUpdatesList.self

    init(inputStack: FTServiceModel?) {
        self.inputStack = inputStack
    }
    
}
