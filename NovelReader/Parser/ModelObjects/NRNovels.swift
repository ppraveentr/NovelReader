//
//  NRNovelObject.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

final class NRNovels: FTServiceModel {
    // TODO: Yet to setup model creator for Static data
    var state: String?
    var novelList: [NRNovel]?
    var page: String?
    var totalItems: String?
    var type: String?
    var category: String?
    var response: [NRNovel]?
}
