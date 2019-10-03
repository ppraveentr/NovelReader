//
//  NRBaseViewController+Utility.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 30/04/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

// MARK: Novel Cell protocol
protocol NRConfigureNovelCellProtocol {
    func configureContent(content: AnyObject)
    func configureContent(content: AnyObject, view: UICollectionView?, indexPath: IndexPath?)
}

extension NRConfigureNovelCellProtocol where Self: UIView {
    func configureContent(content: AnyObject) {
        // Optional Protocal implementation: intentionally empty
    }

    func configureContent(content: AnyObject, view: UICollectionView?, indexPath: IndexPath?) {
        // Optional Protocal implementation: intentionally empty
    }
}

// MARK: BaseView Controller utility
extension FTBaseViewController {
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kShowNovelChapterList {
            configureShowNovelChapterList(segue, sender: sender)
        }
        else if segue.identifier == kShowNovelReaderView {
           configureShowNovelReaderView(segue, sender: sender)
        }
        // segue for the popover configuration window
        else if segue.identifier == kShowFontPicker {
            configureShowFontPicker(segue, sender: sender)
        }
    }
}

// MARK: UIStoryboardSegue
fileprivate extension UIViewController {
    
    func configureShowNovelChapterList(_ segue: UIStoryboardSegue, sender: Any?) {
        if let nextViewController = segue.destination as? NRNovelChapterViewController {
            nextViewController.novel = sender as? NRNovel
        }
    }
    
    func configureShowNovelReaderView(_ segue: UIStoryboardSegue, sender: Any?) {
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
    
    func configureShowFontPicker(_ segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? FTFontPickerViewController {
            if let self = self as? FTFontPickerViewprotocol {
                controller.fontPickerViewDelegate = self
            }
            if let self = self as? UIPopoverPresentationControllerDelegate {
                controller.popoverPresentationController?.delegate = self
            }
            controller.preferredContentSize = CGSize(width: 250, height: 320)
        }
    }
}
