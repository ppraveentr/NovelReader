//
//  FTPo.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 26/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

class FTFontPickerViewController: FTBaseViewController {
    
    var pickerView = FTFontPickerView.fromNib() as? FTFontPickerView
    
    var fontPickerViewDelegate: FTFontPickerViewprotocol? = nil {
        didSet {
            pickerView?.pickerDelegate = fontPickerViewDelegate
        }
    }
    
    override func loadView() {
        super.loadView()
        
        if pickerView != nil {
         self.mainView?.pin(view: pickerView!)
        }
    }
}
