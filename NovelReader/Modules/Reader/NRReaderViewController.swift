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
    static let backButton = #selector(NRReaderViewController.back)

    @IBOutlet var fontPickerBarItem: UIBarButtonItem?
//    @IBOutlet var chapterToolBarItem: UIToolbar?
//    var sortedToolBarItems: [UIBarButtonItem]? {
//        get{
//            return self.chapterToolBarItem?.items?.sorted(by: { $0.tag > $1.tag })
//        }
//    }

    var textSize: Int = 140
    let contentView = FTContentView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViewContent()
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupViewContent() {
        
        self.title = novelChapter?.shortTitle ?? novelChapter?.title ?? novel?.title
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: NRReaderViewController.backButton)
        
        self.navigationItem.rightBarButtonItem = fontPickerBarItem

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
        textSize += (size == .increment) ? 10 : -10;
        contentView.webView.setContentFontSize(textSize)
    }
    
    func pickerColor(textColor: UIColor, backgroundColor: UIColor) {
        contentView.webView.setContentColor(textColor: textColor, backgroundColor: backgroundColor)
    }
    
    func fontFamily(_ fontName: String?) {
        contentView.webView.setContentFontFamily(fontName)
    }
}

extension NRReaderViewController: UIPopoverPresentationControllerDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segue for the popover configuration window
        if segue.identifier == "kShowFontPicker" {
            if let controller = segue.destination as? FTFontPickerViewController {
                controller.fontPickerViewDelegate = self
                controller.popoverPresentationController!.delegate = self
                controller.preferredContentSize = CGSize(width: 250, height: 320)
            }
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

}
