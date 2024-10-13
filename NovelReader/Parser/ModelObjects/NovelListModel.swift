//
//  NovelListModel.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import NetworkLayer

final class NovelListModel: ServiceModel {
    // TODO: Yet to setup model creator for Static data
    var state: String?
    var novelList: [NovelModel]?
    var page: String?
    var totalItems: String?
    var type: String?
    var category: String?
    var response: [NovelModel]?
}
