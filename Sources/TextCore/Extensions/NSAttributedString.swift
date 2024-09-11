//
//  NSAttributedString.swift
//  TextCore
//
//  Created by Dave Coleman on 31/8/2024.
//

import AppKit

public extension NSMutableAttributedString {
  
  @MainActor func setAttributesCustom(
    _ attributeSet: AttributeSet,
    range: NSRange,
    with typingAttributes: Attributes? = nil
  ) {
    
    if let typingAttributes = typingAttributes {
      
      //      setAttributes(attributeSet.attributes.merging(typingAttributes, uniquingKeysWith: { key, value in
      //
      //      }), range: range)
      setAttributes(attributeSet.attributes, range: range)
      addAttributes(typingAttributes, range: range)
    } else {
      setAttributes(attributeSet.attributes, range: range)
    }
  }
}
