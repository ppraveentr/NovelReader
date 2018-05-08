//
//  NRService_fetchRecentUpdatesList.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

final class NRService_fetchRecentUpdatesList: FTServiceStack {
    override func serviceName() -> String { return "fetchRecentUpdatesList" }

    override func responseType() -> FTModelData.Type {
        return [NRNovel].self
    }
}
