//
//  NRServiceProvider.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

class NRServiceProvider {

    // Get list of all Novels
    static func fetchRecentUpdateList(_ completionHandler: @escaping (_ novelsList: [NRNovel]?) -> Swift.Void) {

        FTLoadingIndicator.show()

        FTServicefetchRecentUpdatesList.make { (response) in
            FTLoadingIndicator.hide()

            let response = response.status.responseModel as? NRServiceResponse_fetchRecentUpdatesList
            completionHandler(response?.response)
        }
    }

    // Get list of all Novels
    static func fetchNovelList(novel: NRNovels?, _ completionHandler: @escaping (_ novelsList: NRNovels?) -> Swift.Void) {

        FTLoadingIndicator.show()
        FTServicefetchNovelList.make(modelStack: nil) { (response) in
            FTLoadingIndicator.hide()

            let res = response.status.responseModel as? NRServiceResponse_fetchNovelList

            if let novelList = res?.response {
                let novel = novel ?? NRNovels()
                if(novel.novelList == nil) {
                    novel.novelList = []
                }
                novel.novelList?.append(contentsOf: novelList)
            }
            completionHandler(novel)

//            //FIXIT: Has be done in FTServiceClient
//            if let novelResponse = res?.responseStack as? NRNovels {
//                var novel = novel
//                novel!.merge(data: novelResponse)
//                completionHandler(novel)
//            }
        }
    }
    
    // Get list of all chapters from a single NRNovelObject
    static func getNovelChaptersList(_ novel: NRNovel, getChapters: Bool = true,
                                completionHandler: @escaping (_ novel: NRNovel?) -> Swift.Void) {

        FTLoadingIndicator.show()

        let model: FTServiceModel = ["id": novel.identifier]

        FTServicefetchNovelChapters.make(modelStack: model) { (response) in
            FTLoadingIndicator.hide()

            let res = response.status.responseModel as? NRServiceResponse_fetchNovelChapters
            completionHandler(res?.response)
        }
    }
    
    // Get chapter content
    static func getNovelChapter(_ identifier: String,
                                completionHandler: @escaping (_ chapterContent: NRNovelChapter?) -> Swift.Void) {

        FTLoadingIndicator.show()

        let model: FTServiceModel = ["id": identifier]

        FTServicefetchChapter.make(modelStack: model) { (response) in
            FTLoadingIndicator.hide()

            let res = response.status.responseModel as? NRServiceResponse_fetchChapter
            completionHandler(res?.response)
        }
    }
    
}
