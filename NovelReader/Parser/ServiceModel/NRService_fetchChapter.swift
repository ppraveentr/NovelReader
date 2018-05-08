//
//  NRService_fetchNovelList.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

final class NRService_fetchChapter: FTServiceStack {
    override func serviceName() -> String { return "fetchChapter" }

    override func responseType() -> FTModelData.Type {
        return NRNovelChapter.self
    }
}
