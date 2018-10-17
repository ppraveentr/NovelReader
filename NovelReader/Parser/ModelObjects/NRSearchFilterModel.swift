//
//  NRSearchFilterModel.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 13/10/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

final class NRFilterModel: FTServiceModel {
    var data: String? = nil
    var type: String? = nil
}

final class NRSearchFilterModel: FTServiceModel {
    var keyword: String? = nil

    var novelType: [NRFilterModel]? = nil
    var language: [NRFilterModel]? = nil
    var genres: [NRFilterModel]? = nil
    var completed: [NRFilterModel]? = nil

    var response: NRSearchFilterModel?
}
