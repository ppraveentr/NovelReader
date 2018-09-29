//
//  NRReaderViewController.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 26/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

class NRReaderViewController: FTBaseViewController {
    
    var novelChapter: NRNovelChapter?
    var novel: NRNovel?

    @IBOutlet var fontPickerBarItem: UIBarButtonItem?
//    @IBOutlet var chapterToolBarItem: UIToolbar?
//    var sortedToolBarItems: [UIBarButtonItem]? {
//        get{
//            return self.chapterToolBarItem?.items?.sorted(by: { $0.tag > $1.tag })
//        }
//    }

    var textSize: Int = kReaderInitalFontSize
    let contentView = FTContentView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setup view content
        self.setupViewContent()
    }

    override func shouldSetSafeAreaLayoutGuide() -> Bool {
        return false
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
            NRServiceProvider.getNovelChapter(url) { (chapter) in

                if let content = chapter?.shortTitle {
                    self.title = content
                }
                if let content = chapter?.content {
                    self.loadWebContent(contnet: content)
                }
            }
        }
    }
    
    func loadWebContent(contnet: String) {
        contentView.webView.loadHTMLBody(contnet)
    }
    
}

extension NRReaderViewController: FTFontPickerViewprotocol {

    func fontSize(_ size: FontSizePicker) {
        textSize += (size == .increment) ? kReaderFontSize : -kReaderFontSize;
        contentView.webView.setContentFontSize(textSize)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.prepareSegue(segue, sender: sender)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

}
