//
//  NRService_fetchRecentUpdatesList.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

typealias FTServicefetchRecentUpdatesList = NRService_fetchRecentUpdatesList
final class NRService_fetchRecentUpdatesList: FTServiceClient {
    var inputStack: FTServiceModel?
    var serviceName = "fetchRecentUpdatesList"
    var responseStackType: Any? = NRNovels.self

    init(inputStack: FTServiceModel?) {
        self.inputStack = inputStack
    }
    
}
