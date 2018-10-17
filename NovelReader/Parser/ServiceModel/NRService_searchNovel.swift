//
//  NRService_searchNovel.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 05/10/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

typealias FTServicesearchNovel = NRService_searchNovel
final class NRService_searchNovel: FTServiceClient {
    var inputStack: NRSearchModel?
    var serviceName = "searchNovel"
    var responseStackType: Any? = NRNovels.self

    init(inputStack: FTServiceModel?) {
        self.inputStack = inputStack as? NRSearchModel
    }

}
