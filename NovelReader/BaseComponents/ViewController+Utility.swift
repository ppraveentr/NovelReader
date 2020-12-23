//
//  BaseViewController+Utility.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 30/04/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

// MARK: Novel Cell protocol
protocol ConfigureNovelCellProtocol {
    func configureContent(content: AnyObject)
    func configureContent(content: AnyObject, view: UICollectionView?, indexPath: IndexPath?)
}

extension ConfigureNovelCellProtocol where Self: UIView {
    func configureContent(content: AnyObject) {
        // Optional Protocal implementation: intentionally empty
    }

    func configureContent(content: AnyObject, view: UICollectionView?, indexPath: IndexPath?) {
        // Optional Protocal implementation: intentionally empty
    }
}

// MARK: BaseView Controller utility
extension UIViewController {
    open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
        if let nextViewController = segue.destination as? NovelChapterViewController {
            nextViewController.novel = sender as? NovelModel
        }
    }
    
    func configureShowNovelReaderView(_ segue: UIStoryboardSegue, sender: Any?) {
        let readerController: ReaderViewController?
        
        if let nav = segue.destination as? UINavigationController {
            readerController = nav.viewControllers.first as? ReaderViewController
        }
        else {
            readerController = segue.destination as? ReaderViewController
        }
        
        // Available from recent-novel-page
        readerController?.novel = sender as? NovelModel
        // Available from chapter-list-page
        readerController?.novelChapter = sender as? NovelChapterModel
    }
    
    func configureShowFontPicker(_ segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? FontPickerViewController {
            if let self = self as? FontPickerViewProtocol {
                controller.fontPickerViewDelegate = self
            }
            if let self = self as? UIPopoverPresentationControllerDelegate {
                controller.popoverPresentationController?.delegate = self
            }
            controller.preferredContentSize = CGSize(width: 250, height: 320)
        }
    }
}
