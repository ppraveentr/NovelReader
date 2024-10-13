//
//  FontPickerViewController.swift
//  MobileCoreUI
//
//  Created by Praveen Prabhakar on 26/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

open class FontPickerViewController: UIViewController {
    
    lazy var pickerView: FontPickerView? = try? FontPickerView.loadNibFromBundle()
    
    open var fontPickerViewDelegate: FontPickerViewProtocol? {
        didSet {
            pickerView?.pickerDelegate = fontPickerViewDelegate
        }
    }

    open var fontPickerModel: FontPickerModel? {
        get { pickerView?.fontPickerModel }
        set {
            if let model = newValue {
                pickerView?.fontPickerModel = model
            }
        }
    }

    override open func loadView() {
       super.loadView()
         // Setup MobileCore
        setupCoreView()
        if let pickerView = pickerView {
         self.mainView?.pin(view: pickerView)
        }
    }
    
    @discardableResult
    open func setUpPopoverPresentation(from sender: UIView?, delegate: UIPopoverPresentationControllerDelegate? = nil, contentSize: CGSize = CGSize(width: 250, height: 300)) -> UIPopoverPresentationController? {
        self.modalPresentationStyle = .popover
        self.preferredContentSize = contentSize
        
        let ppc = self.popoverPresentationController
        ppc?.permittedArrowDirections = .any
        ppc?.delegate = delegate ?? self

        if let sender = sender {
            ppc?.sourceView = sender
            ppc?.sourceRect = sender.bounds
        }
        
        return ppc
    }
}

extension FontPickerViewController: UIPopoverPresentationControllerDelegate {
    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
}
