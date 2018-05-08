//
//  NRService_fetchNovelList.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

final class NRService_fetchNovelList: FTServiceStack {
    override func serviceName() -> String { return "fetchNovelList" }

    override func responseType() -> FTModelData.Type {
        return [NRNovel].self
    }
}
