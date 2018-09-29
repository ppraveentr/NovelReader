//
//  FTFontPickerView.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 26/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

public enum FontSizePicker {
    case increment
    case decrement
}

public protocol FTFontPickerViewprotocol {
    
    func pickerColor(textColor: UIColor, backgroundColor: UIColor)
    func fontSize(_ size: FontSizePicker)
    func fontFamily(_ fontName: String?)
}

open class FTFontPickerView: FTView {
    
    var pickerDelegate: FTFontPickerViewprotocol?
    
    @IBOutlet weak var decrementFontButton: FTButton!
    @IBOutlet weak var incrementFontButton: FTButton!
    
    @IBOutlet weak var whiteColorButton: FTButton!
    @IBOutlet weak var creameColorButton: FTButton!
    @IBOutlet weak var lightGrayColorButton: FTButton!
    @IBOutlet weak var blackColorButton: FTButton!
    
    @IBOutlet weak var fontTableView: FTTableView!
    
    @IBAction func fontColorSelected(_ sender: FTButton) {
        pickerDelegate?.pickerColor(textColor: sender.titleLabel?.textColor ?? .black, backgroundColor: sender.backgroundColor ?? .white)
    }
    
    @IBAction func fontSizeChanged(_ sender: FTButton) {
        if sender == decrementFontButton {
            pickerDelegate?.fontSize(.decrement)
        } else{
            pickerDelegate?.fontSize(.increment)
        }
    }
    
    var selectedFont: String? {
        didSet {
             pickerDelegate?.fontFamily(selectedFont)
        }
    }
    
    // Avaialble Fonts
    let fontTypes = ["Arial","Courier","Georgia","Helvetica","Palatino","Times","Verdana"]

    open override func awakeFromNib() {
        super .awakeFromNib()
        
        whiteColorButton.imageView?.image = nil
        creameColorButton.imageView?.image = nil
        lightGrayColorButton.imageView?.image = nil
        blackColorButton.imageView?.image = nil
        
        fontTableView.backgroundView = nil
        fontTableView.register(UITableViewCell.self, forCellReuseIdentifier: "kFontType")
    }
    
}

extension FTFontPickerView: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return fontTypes.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "kFontType", for: indexPath)
        
        cell.selectionStyle = .none
        cell.accessoryType = .none
        
        let cur: String = fontTypes[indexPath.section]
            
//         {
        
            cell.backgroundColor = .clear
            
            cell.textLabel?.text = cur
            
            cell.textLabel?.font = UIFont(name: cur, size: 14)
        
        if selectedFont == cur {
            cell.accessoryType = .checkmark
        }
//        }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       tableView.deselectRow(at: indexPath, animated: true)
        
        if fontTypes[indexPath.section] == selectedFont {
            selectedFont = nil
        } else {
            selectedFont = fontTypes[indexPath.section]
        }
        
        tableView.reloadData()
    }
    
}
