//
//  SearchFilterModel.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 13/10/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

final class FilterModel: ServiceModel {
    var data: String?
    var type: String?
}

final class SearchFilterModel: ServiceModel {
    var keyword: String?

    var novelType: [FilterModel]?
    var language: [FilterModel]?
    var genres: [FilterModel]?
    var completed: [FilterModel]?

    var response: SearchFilterModel?
}
