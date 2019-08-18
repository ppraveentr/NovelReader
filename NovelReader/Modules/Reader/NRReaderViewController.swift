//
//  NRReaderViewController.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 26/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

class NRReaderViewController: NRBaseViewController {
    
    var novelChapter: NRNovelChapter?
    var novel: NRNovel?

    @IBOutlet var fontPickerBarItem: UIBarButtonItem?
//    @IBOutlet var chapterToolBarItem: UIToolbar?
//    var sortedToolBarItems: [UIBarButtonItem]? {
//        get{
//            return self.chapterToolBarItem?.items?.sorted(by: { $0.tag > $1.tag })
//        }
//    }

    let contentView = FTContentView()

    var fontPicker: FTFontPickerModel? {
        set {
            if let fontPicker = newValue {
                FTUserCache.setCacheObject(fontPicker, forType: FTFontPickerModel.self)
            }
        }
        get {
            return FTUserCache.getCachedObject(forType: FTFontPickerModel.self) as? FTFontPickerModel
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
        self.setupNavigationbar(title: title,
                                leftButton: self.navigationBarButton(buttonType: .stop),
                                rightButton: fontPickerBarItem)

        self.mainView?.pin(view: contentView)

        if let url = novelChapter?.identifier ?? novel?.identifier {
            NRServiceProvider.getNovelChapter(url) { [unowned self] (chapter) in

                if let content = chapter?.shortTitle {
                    self.title = content
                }
                if let content = chapter?.content {
                    self.loadWebContent(contnet: content)
                }
            }
        }

        // FTFontPickerViewprotocol
        if let fontPicker = fontPicker {
            fontSize(fontPicker.fontSize)
            pickerColor(textColor: fontPicker.fontColor, backgroundColor: fontPicker.backgroundColor)
            fontFamily(fontPicker.fontFamily)
        }

    }
    
    func loadWebContent(contnet: String) {
        contentView.webView.loadHTMLBody(contnet)
    }
}

extension NRReaderViewController: FTFontPickerViewprotocol {

    func fontSize(_ size: Float) {
        contentView.webView.setContentFontSize(size)
    }
    
    func pickerColor(textColor: UIColor, backgroundColor: UIColor) {
        contentView.webView.setContentColor(textColor: textColor, backgroundColor: backgroundColor)
        self.view.backgroundColor = backgroundColor
        self.mainView?.backgroundColor = backgroundColor
    }
    
    func fontFamily(_ fontName: String?) {
        contentView.webView.setContentFontFamily(fontName)
    }
}

extension NRReaderViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        if let fontPickerController = controller.presentedViewController as? FTFontPickerViewController {
            if self.fontPicker == nil {
                self.fontPicker = fontPickerController.fontPickerModel
            } else {
                fontPickerController.fontPickerModel = self.fontPicker
            }
        }
        return .none
    }
}
