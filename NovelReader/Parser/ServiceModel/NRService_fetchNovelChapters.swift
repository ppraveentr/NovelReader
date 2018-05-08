//
//  NRService_fetchNovelChapters.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

final class NRService_fetchNovelChapters: FTServiceStack {
    override func serviceName() -> String { return "fetchNovelChapters" }

    override func responseType() -> FTModelData.Type {
        return NRNovel.self
    }
}
