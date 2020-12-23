//
//  ReaderViewController.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 26/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

class ReaderViewController: BaseViewController, WebViewControllerProtocol {
    
    var novelChapter: NovelChapterModel?
    var novel: NovelModel?

    @IBOutlet
    private var fontPickerBarItem: UIBarButtonItem?
//    @IBOutlet var chapterToolBarItem: UIToolbar?
//    var sortedToolBarItems: [UIBarButtonItem]? {
//        get{
//            return self.chapterToolBarItem?.items?.sorted(by: { $0.tag > $1.tag })
//        }
//    }

    var fontPicker: FontPickerModel? {
        set {
            if let fontPicker = newValue {
                UserCacheManager.setCacheObject(fontPicker, forType: FontPickerModel.self)
            }
        }
        get {
            return UserCacheManager.getCachedObject(forType: FontPickerModel.self) as? FontPickerModel
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // setup view content
        self.setupViewContent()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    func setupViewContent() {
        
        let title = novelChapter?.shortTitle ?? novelChapter?.title ?? novel?.title ?? ""
        self.setupNavigationbar(
            title: title,
            leftButton: UIBarButtonItem(itemType: .stop),
            rightButton: fontPickerBarItem
        )

        self.mainView?.pin(view: contentView)

        if let url = novelChapter?.identifier ?? novel?.identifier {
            NovelServiceProvider.getNovelChapter(url) { [unowned self] (chapter) in

                if let content = chapter?.shortTitle {
                    self.title = content
                }
                if let content = chapter?.content {
                    self.loadWebContent(contnet: content)
                }
                
                self.configureWebview()
            }
        }
    }
    
    func loadWebContent(contnet: String) {
        contentView.loadHTMLBody(contnet)
    }
    
    func configureWebview() {
        // FontPickerViewprotocol
        if let fontPicker = fontPicker {
            fontSize(fontPicker.fontSize)
            pickerColor(textColor: fontPicker.fontColor, backgroundColor: fontPicker.backgroundColor)
            fontFamily(fontPicker.fontFamily)
        }
    }
}

extension ReaderViewController: FontPickerViewProtocol {
    func fontSize(_ size: Float) {
        contentView.setContentFontSize(size)
    }
    
    func pickerColor(textColor: UIColor, backgroundColor: UIColor) {
        contentView.setContentColor(textColor: textColor, backgroundColor: backgroundColor)
        self.view.backgroundColor = backgroundColor
        self.mainView?.backgroundColor = backgroundColor
    }
    
    func fontFamily(_ fontName: String?) {
        contentView.setContentFontFamily(fontName)
    }
}

extension ReaderViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        if let fontPickerController = controller.presentedViewController as? FontPickerViewController {
            if self.fontPicker == nil {
                self.fontPicker = fontPickerController.fontPickerModel
            }
            else {
                fontPickerController.fontPickerModel = self.fontPicker
            }
        }
        return .none
    }
}
