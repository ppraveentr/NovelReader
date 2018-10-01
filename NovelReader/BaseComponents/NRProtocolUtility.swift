//
//  NRProtocolUtility.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 30/04/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

protocol NRConfigureNovelCellProtocol {
    func configureContent(novel: NRNovel)
    func configureContent(novel: NRNovel, view: UICollectionView?, indexPath: IndexPath?)
}

extension NRConfigureNovelCellProtocol where Self: UIView {

    func configureContent(novel: NRNovel) {
    }

    func configureContent(novel: NRNovel, view: UICollectionView?, indexPath: IndexPath?) {
    }

}

extension FTBaseViewController {

    open override var prefersStatusBarHidden: Bool {
        return true
    }

    open override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.prepareSegue(segue, sender: sender)
    }

    public func prepareSegue(_ segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == kShowNovelChapterList {
            if let nextViewController = segue.destination as? NRNovelChapterViewController {
                nextViewController.novel = sender as? NRNovel
            }
        }
        else if segue.identifier == kShowNovelReaderView {
            let readerController: NRReaderViewController?

            if let nav = segue.destination as? UINavigationController {
                readerController = nav.viewControllers.first as? NRReaderViewController
            }
            else {
                readerController = segue.destination as? NRReaderViewController
            }

            // Available from recent-novel-page
            readerController?.novel = sender as? NRNovel
            // Available from chapter-list-page
            readerController?.novelChapter = sender as? NRNovelChapter
        }
        // segue for the popover configuration window
        else if segue.identifier == kShowFontPicker {
            if let controller = segue.destination as? FTFontPickerViewController {
                if let self = self as? FTFontPickerViewprotocol {
                    controller.fontPickerViewDelegate = self
                }
                if let self = self as? UIPopoverPresentationControllerDelegate {
                    controller.popoverPresentationController!.delegate = self
                }
                controller.preferredContentSize = CGSize(width: 250, height: 320)
            }
        }
    }
    
}
