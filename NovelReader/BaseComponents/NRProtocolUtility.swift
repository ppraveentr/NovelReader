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
    func getSize(baseView: UIView) -> CGSize
}

extension NRConfigureNovelCellProtocol where Self: UIView {

    func configureContent(novel: NRNovel) { }
    func configureContent(novel: NRNovel, view: UICollectionView?, indexPath: IndexPath?) { }

    // FIXIT: Not working
    func getSize(baseView: UIView) -> CGSize {
        
        //let compressedSize = self.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)

//        if (compressedSize.width*2 + 15*3) < baseView.frame.width/2 {
//            return CGSize(width: compressedSize.width, height: compressedSize.height)
//        }

        let width = baseView.frame.width

        let size = self.systemLayoutSizeFitting( CGSize(width: width, height: 0),
                                                 withHorizontalFittingPriority: UILayoutPriority.required,
                                                 verticalFittingPriority: UILayoutPriority.fittingSizeLevel)
//size.height ??
        return CGSize(width: size.width - 38, height:  162)

    }
    
}

extension UIViewController {

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

            readerController?.novel = sender as? NRNovel
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
