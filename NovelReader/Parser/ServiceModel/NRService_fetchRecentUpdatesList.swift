//
//  NRService_fetchRecentUpdatesList.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

final class NRService_fetchRecentUpdatesList: FTServiceClient {


    var inputStack: FTModelData?

    var serviceName = "fetchRecentUpdatesList"
//    var responseType: FTModelData.Type {
//        return [NRNovel].self
//    }

    init(inputStack: FTModelData?) {
        self.inputStack = inputStack
    }
}
