//
//  NRNovelObject.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

final class NRNovels: FTServiceModel {
    //  TODO: Yet to setup model creator for Static data
    var state: String? = nil
    var novelList: [NRNovel]? = nil
    var page: String? = "1"
    var totalItems: String? = nil
    var type: String? = nil
    var category: String? = nil

    /* Coding Keys */
    enum CodingKeys: String, CodingKey  {
        case state
        case novelList
        case page
        case totalItems
        case type
        case category

    }
}
