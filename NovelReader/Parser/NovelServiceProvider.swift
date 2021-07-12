//
//  NovelServiceProvider.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

enum NovelServiceProvider {
    // Get list of all Novels
    static func fetchRecentUpdateList(completionHandler: @escaping (_ novelsList: [NovelModel]?) -> Void) {
        LoadingIndicator.show()
        ServiceRecentUpdatesList.make { response in
            LoadingIndicator.hide()
            let response = response.status.responseModel as? NovelListModel
            completionHandler(response?.response)
        }
    }

    // Get list of all Novels
    static func fetchNovelList(novel: NovelListModel?, completionHandler: @escaping (_ novelsList: NovelListModel?) -> Void) {
        LoadingIndicator.show()
        ServiceNovelList.make(modelStack: nil) { response in
            LoadingIndicator.hide()
            let res = response.status.responseModel as? NovelListModel
            if let novelList = res?.response {
                let novel = novel ?? NovelListModel()
//                if(novel.novelList == nil) {
                    novel.novelList = []
//                }
                novel.novelList?.append(contentsOf: novelList)
            }
            completionHandler(novel)
//            //FIXIT: Has be done in ServiceClient
//            if let novelResponse = res?.responseStack as? NRNovels {
//                var novel = novel
//                novel!.merge(data: novelResponse)
//                completionHandler(novel)
//            }
        }
    }
    
    // Get list of all chapters from a single NRNovelObject
    static func getNovelChaptersList(_ novel: NovelModel,
                                     getChapters: Bool = true,
                                     completionHandler: @escaping (_ novel: NovelModel?) -> Void) {
        LoadingIndicator.show()
        let model: ServiceModel = ["id": novel.identifier]
        ServiceNovelChapters.make(modelStack: model) { response in
            LoadingIndicator.hide()
            let res = response.status.responseModel as? NovelModel
            completionHandler(res?.response)
        }
    }
    
    // Get chapter content
    static func getNovelChapter(_ identifier: String,
                                completionHandler: @escaping (_ chapterContent: NovelChapterModel?) -> Void) {
        LoadingIndicator.show()
        let model: ServiceModel = ["id": identifier]
        ServiceNovelChapter.make(modelStack: model) { response in
            LoadingIndicator.hide()
            let res = response.status.responseModel as? NovelChapterModel
            completionHandler(res?.response)
        }
    }

    // Serch Novel
    static func searchNovel(keyword: String, completionHandler: @escaping (_ novels: [NovelModel]?) -> Void) {
        LoadingIndicator.show()
        let model = SearchNovelModel()
        model.keyword = keyword
        ServiceSearchNovel.make(modelStack: model) { response in
            LoadingIndicator.hide()
            let res = response.status.responseModel as? NovelListModel
            completionHandler(res?.response)
        }
    }

    // Serch Novel
    static func searchFilter(completionHandler: @escaping (_ novels: SearchFilterModel?) -> Void) {
        LoadingIndicator.show()
        ServiceSearchFilter.make(modelStack: nil) { response in
            LoadingIndicator.hide()
            let res = response.status.responseModel as? SearchFilterModel
            completionHandler(res?.response)
        }
    }
}
