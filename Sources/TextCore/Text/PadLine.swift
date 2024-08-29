//
//  PadLine.swift
//  TextCore
//
//  Created by Dave Coleman on 29/8/2024.
//

import SwiftUI
import BaseHelpers


public enum PaddedContentType {
  case text
  case cap
}

public struct LineCaps {
  var leading: String
  var trailing: String
  var hasExtraSpaces: Bool
  
  public init(
    _ leading: String,
    _ trailing: String,
    hasExtraSpaces: Bool = true
  ) {
    self.leading = leading
    self.trailing = trailing
    self.hasExtraSpaces = hasExtraSpaces
  }
}

public struct TextCore {
  
  static public func padLine(
    _ text: String = "",
    with paddingString: String = " ",
    toFill width: Int,
    alignment: Alignment = .center,
    sliceCharacter: Character = "@",
    caps: LineCaps? = nil, /// This is `String` in case of multi-character caps
    hasSpaceAroundText: Bool = true
  ) -> String {
    
    /// If there is no split character present in the provided `text`, this will simply return a
    /// `[String.SubSequence]` with the full text.
    ///
    let components: [String.SubSequence] = text.split(separator: sliceCharacter, omittingEmptySubsequences: false)
    print("Component count: \(components.count)")
    print("Components: \(components)\n")
    
    /// This is the number of characters in the text content only. This will be added
    /// to the total count, including caps/padding, to compare against the
    /// `toFill width: Int` parameter.
    ///
    let contentWidth = components.reduce(0) { $0 + $1.count }
    print("Content width: \(contentWidth)")
    
    
    let leadingCap: String = caps?.leading ?? ""
    let trailingCap: String = caps?.trailing ?? ""
    
    
    
    let capExtraSpaceSingle: String = (caps?.hasExtraSpaces == true) ? "%" : ""
    let capExtraSpaceWidth: Int = 2
    
    let textExtraSpaceSingle: String = hasSpaceAroundText ? "^" : ""
    var textExtraSpaceWidth: Int
    var textExtraSpace: (String, String)
    
    
    switch alignment {
      case .leading:
        textExtraSpace = ("", textExtraSpaceSingle)
        textExtraSpaceWidth = 1
        
      case .trailing:
        textExtraSpace = (textExtraSpaceSingle, "")
        textExtraSpaceWidth = 1
        
      default: // .center
        textExtraSpace = (textExtraSpaceSingle, textExtraSpaceSingle)
        textExtraSpaceWidth = 2
        
    }
    
    
    
    //    let leadingPadding = (capPadding + textPadding).replacingOccurrences(of: "CT", with: "C")
    //    let trailingPadding = (textPadding + capPadding).replacingOccurrences(of: "TC", with: "C")
    
    
    let totalFixedWidth = contentWidth + leadingCap.count + trailingCap.count + capExtraSpaceWidth + textExtraSpaceWidth
    
    /// Calculates the space left after accounting for all the text content, caps, and
    /// padding — and ensures the value does not fall below zero.
    ///
    let availableSpace = max(0, width - totalFixedWidth)
    
    
    func distributeDynamicPadding(_ padding: Int) -> (left: Int, right: Int) {
      
      switch alignment {
        case .leading:
          return (0, padding)
        case .trailing:
          return (padding, 0)
        default: // .center
          let left = max(0, padding / 2)
          return (left, max(0, padding - left))
      }
    }
    
    
    
    /// This condition applies when there was no split character found in the text,
    /// so the `alignment` argument is used to determine where the padding
    /// should be placed.
    ///
    if components.count <= 1 {

      let (leftPadding, rightPadding) = distributeDynamicPadding(availableSpace)
      
      return leadingCap + capExtraSpaceSingle
      + String(repeating: paddingString, count: leftPadding)
      + textExtraSpace.0 + text + textExtraSpace.1
      + String(repeating: paddingString, count: rightPadding)
      + capExtraSpaceSingle + trailingCap

      
    } else {
      
      /// There *was* a split character provided
      ///
      let paddingPerSlice: Int = availableSpace / (components.count - 1)
      let extraPadding = availableSpace % (components.count - 1)
      
      var result = leadingCap + capExtraSpaceSingle
      
      for (index, component) in components.enumerated() {
        
        result += textExtraSpace.0 + component + textExtraSpace.1
        if index < components.count - 1 {
          let spaces = paddingPerSlice + (index < extraPadding ? 1 : 0)
          result += String(repeating: paddingString, count: spaces)
        }
      }
      
      result += capExtraSpaceSingle + trailingCap
      
      return result
    }
    
    
  } // END pad line
  
}

