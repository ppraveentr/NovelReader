//
//  ConfigureNovelCellProtocol.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 30/04/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

// MARK: Novel Cell protocol
typealias ConfigureNovelCellProtocol = DSConfigureContentProtocol 

// MARK: UIStoryboardSegue
protocol StoryboardSegueProtocol {
    func configure(segue: UIStoryboardSegue, sender: Any?)
}

extension StoryboardSegueProtocol {
    func configure(segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.Segue.showNovelDetailsView {
            // configureShowNovelDetailsView(segue, sender: sender)
        }
        else if segue.identifier == Storyboard.Segue.showNovelChapterList {
            configureShowNovelChapterList(segue, sender: sender)
        }
        else if segue.identifier == Storyboard.Segue.showNovelReaderView {
           configureShowNovelReaderView(segue, sender: sender)
        }
        // segue for the popover configuration window
        else if segue.identifier == Storyboard.Segue.showFontPicker {
            configureShowFontPicker(segue, sender: sender)
        }
    }
}

fileprivate extension StoryboardSegueProtocol {
    func configureShowNovelChapterList(_ segue: UIStoryboardSegue, sender: Any?) {
        if let nextViewController = segue.destination as? ChapterListViewController {
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
