//
//  NRServiceProvider.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

class NRServiceProvider {

    //Get list of all Novels
    class func fetchRecentUpdateList(_ completionHandler: @escaping (_ novelsList: [NRNovel]?) -> Swift.Void) {

        FTServicefetchRecentUpdatesList.make { (status) in
            switch (status) {
            case .success(let res, _):
                completionHandler(res?.responseStack as? [NRNovel])
            case .failed(let res, _):
                completionHandler(res?.responseStack as? [NRNovel])
            }
        }
    }

    //Get list of all Novels
    class func fetchNovelList(novel: NRNovels?, _ completionHandler: @escaping (_ novelsList: NRNovels?) -> Swift.Void) {

        FTServicefetchNovelList.make(modelStack: nil) { (status) in
            switch (status) {
            case .success(let res, _):
                //FIXIT: Has be done in FTServiceClient
                if let novelResponse = res?.responseStack as? NRNovels {
                    var novel = novel
                    novel!.merge(data: novelResponse)
                    completionHandler(novel)
                }
                // TODO: To be removed once Mock is done
                else if let novelList = res?.responseStack as? [NRNovel] {
                    let novel = novel ?? NRNovels()
                    if(novel.novelList == nil) {
                        novel.novelList = []
                    }
                    novel.novelList?.append(contentsOf: novelList)
                    completionHandler(novel)
                } else {
                    completionHandler(res?.responseStack as? NRNovels)
                }
                break
            case .failed(let res, _):
                completionHandler(res?.responseStack as? NRNovels)
                break
            }
        }
    }
    
    //Get list of all chapters from a single NRNovelObject
    class func getNovelChaptersList(_ novel: NRNovel, getChapters: Bool = true,
                                completionHandler: @escaping (_ novel: NRNovel?) -> Swift.Void) {

        let model: FTModelData = ["id": novel.identifier]

        FTServicefetchNovelChapters.make(modelStack: model) { (status) in
            switch (status) {
            case .success(let res, _):
                if let novelResponse = res?.responseStack as? NRNovel {
                    completionHandler(novelResponse)
                }
                else {
                    completionHandler(res?.responseStack as? NRNovel)
                }
                break
            case .failed(let res, _):
                completionHandler(res?.responseStack as? NRNovel)
                break
            }
        }
    }
    
    //Get chapter content
    class func getNovelChapter(_ identifier: String,
                                completionHandler: @escaping (_ chapterContent: NRNovelChapter?) -> Swift.Void) {
        
        let model: FTModelData = ["id": identifier]

        FTServicefetchChapter.make(modelStack: model) { (status) in
            switch (status) {
            case .success(let res, _):
                completionHandler(res?.responseStack as? NRNovelChapter)
                break
            case .failed(let res, _):
                completionHandler(res?.responseStack as? NRNovelChapter)
                break
            }
        }
    }
}
