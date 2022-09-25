//
//  FontPickerView.swift
//  MobileCoreUI
//
//  Created by Praveen Prabhakar on 26/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

public protocol FontPickerViewProtocol: AnyObject {
    func pickerColor(textColor: UIColor, backgroundColor: UIColor)
    func fontSize(_ size: Float)
    func fontFamily(_ fontName: String?)
}

open class FontPickerModel {
    
    var fontSizeStepValue: Float = 10.0
    public var fontSize: Float = 140.0
    public var fontColor: UIColor = .black
    public var backgroundColor: UIColor = .white
    public var fontFamily: String?

    // TODO: To support Custom Fonts
    let fontTypes = ["Arial", "Courier", "Georgia", "Helvetica", "Palatino", "Times", "Verdana"]

    // Avaialble Fonts
    var fontSizeString: String {
        String(fontSize)
    }

    func avalilableFonts() -> [String] {
        fontTypes
    }

    func increaseSize() {
        (fontSize += fontSizeStepValue)
    }

    func decreaseSize() {
        (fontSize -= fontSizeStepValue)
    }
}

open class FontPickerView: UIView {
    
    weak var pickerDelegate: FontPickerViewProtocol?
    public var fontPickerModel = FontPickerModel() {
        didSet {
            // Update View-source
            pickerDelegate?.fontSize(fontPickerModel.fontSize)
            pickerDelegate?.fontFamily(fontPickerModel.fontFamily)
            pickerDelegate?.pickerColor(
                textColor: fontPickerModel.fontColor,
                backgroundColor: fontPickerModel.backgroundColor
            )

            selectedColorButton?.addBorder()
            fontTableView.reloadData()
        }
    }

    @IBOutlet weak var decrementFontButton: UIButton!
    @IBOutlet weak var incrementFontButton: UIButton!
    @IBOutlet weak var fontSizeLabel: UILabel!

    @IBOutlet weak var whiteColorButton: UIButton!
    @IBOutlet weak var creameColorButton: UIButton!
    @IBOutlet weak var lightGrayColorButton: UIButton!
    @IBOutlet weak var blackColorButton: UIButton!

    weak var selectedColorButton: UIButton?

    @IBOutlet weak var fontTableView: UITableView!

    @IBAction func fontColorSelected(_ sender: UIButton) {
        // Clear Previous selected Button
        selectedColorButton?.addBorder(color: .clear)
        // Update latest button color
        selectedColorButton = sender
        selectedColorButton?.addBorder()

        // Update Font Color and BG color in ViewModel
        fontPickerModel.fontColor = sender.titleLabel?.textColor ?? .black
        fontPickerModel.backgroundColor = sender.backgroundColor ?? .white

        // Update soruce-View
        pickerDelegate?.pickerColor(textColor: fontPickerModel.fontColor, backgroundColor: fontPickerModel.backgroundColor)
    }
    
    @IBAction func fontSizeChanged(_ sender: UIButton?) {
        // Increase / Decrease fontSize
        if let button = sender {
            (button == decrementFontButton) ? fontPickerModel.decreaseSize() : fontPickerModel.increaseSize()
        }

        fontSizeLabel.text = fontPickerModel.fontSizeString

        pickerDelegate?.fontSize(fontPickerModel.fontSize)
    }
    
    var selectedFont: String? {
        get {
            fontPickerModel.fontFamily
        }
        set {
            fontPickerModel.fontFamily = newValue
            pickerDelegate?.fontFamily(newValue)
        }
    }
    
    // Avaialble Fonts
    var fontTypes: [String] {
        fontPickerModel.avalilableFonts()
    }

    override open func awakeFromNib() {
        super .awakeFromNib()
        // Color Button
        whiteColorButton.imageView?.image = nil
        creameColorButton.imageView?.image = nil
        lightGrayColorButton.imageView?.image = nil
        blackColorButton.imageView?.image = nil
        // TextSize Label
//        fontSizeLabel.text = fontPickerModel.fontSizeString
        // Font TableView
        fontTableView.backgroundView = nil
        fontTableView.register(UITableViewCell.self, forCellReuseIdentifier: "kFontType")
        fontTableView.estimatedRowHeight = 30
    }
}

extension FontPickerView: UITableViewDataSource, UITableViewDelegate {

    public func numberOfSections(in tableView: UITableView) -> Int {
        fontTypes.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "kFontType", for: indexPath)
        cell.selectionStyle = .none
        cell.accessoryType = .none
        cell.backgroundColor = .clear

        let cur: String = fontTypes[indexPath.section]
        cell.textLabel?.text = cur
        cell.textLabel?.font = UIFont(name: cur, size: 14)

        if selectedFont == cur {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       tableView.deselectRow(at: indexPath, animated: true)
        
        if fontTypes[indexPath.section] == selectedFont {
            selectedFont = nil
        }
        else {
            selectedFont = fontTypes[indexPath.section]
        }
        
        tableView.reloadData()
    }
}
