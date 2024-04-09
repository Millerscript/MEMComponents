//
//  MCTabItemModel.swift
//  MEMComponents
//
//  Created by Miller Mosquera on 26/03/24.
//

import Foundation
public struct MCTabItemModel {
    
    public var itemId: Int
    public var text: String
    public var selected: Bool = false
    public var icon: UIImage?
    
    public var type: TabStyle = .TEXT
    
    public init(itemId: Int, text: String, selected: Bool, icon: UIImage?) {
        self.itemId = itemId
        self.text = text
        self.selected = selected
        self.icon = icon
        setType()
    }
    
    private mutating func setType() {
        // Only text
        if !text.isEmpty && icon == nil {
            self.type = .TEXT
        }
        
        // Only image
        if text.isEmpty && icon != nil {
            self.type = .IMAGE
        }
        
        // Compouse
        if !text.isEmpty && icon != nil {
            self.type = .COMPOUSE
        }
    }
}
