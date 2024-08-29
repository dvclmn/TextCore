//
//  TextCore.swift
//  SwiftBox
//
//  Created by Dave Coleman on 27/8/2024.
//

/// Common operations
///
/// 1. Find just enough whitespace to fill out a row of character to x-length
///

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
    var capExtraSpaceWidth: Int
    var capExtraSpace: (String, String)
    
    let textExtraSpaceSingle: String = hasSpaceAroundText ? "^" : ""
    var textExtraSpaceWidth: Int
    var textExtraSpace: (String, String)
    
    
    switch alignment {
      case .leading:
        capExtraSpace = ("", capExtraSpaceSingle)
        capExtraSpaceWidth = 1
        
        textExtraSpace = ("", textExtraSpaceSingle)
        textExtraSpaceWidth = 1
        
      case .trailing:
        capExtraSpace = (capExtraSpaceSingle, "")
        capExtraSpaceWidth = 1
        
        textExtraSpace = (textExtraSpaceSingle, "")
        textExtraSpaceWidth = 1
        
      default: // .center
        capExtraSpace = (capExtraSpaceSingle, capExtraSpaceSingle)
        capExtraSpaceWidth = 2
        
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
      
//      if caps != nil {
        
//        return "Caps"
//        let (leftPadding, rightPadding) = distributeDynamicPadding(availableSpace)
//        
//        return leadingCap + capExtraSpace + textExtraSpace +
//        String(repeating: paddingString, count: leftPadding) +
//        text +
//        String(repeating: paddingString, count: rightPadding) +
//        textExtraSpace + capExtraSpace + trailingCap
        
        
//      } else {
        
        let (leftPadding, rightPadding) = distributeDynamicPadding(availableSpace)
        
        
        
      return leadingCap + capExtraSpace.0
        + String(repeating: paddingString, count: leftPadding)
      + textExtraSpace.0 + text + textExtraSpace.1
        + String(repeating: paddingString, count: rightPadding)
      + capExtraSpace.1 + trailingCap
//      }
      

      
      
      
    } else {
      
      /// There *was* a split character provided
      ///
      let spacesPerSlice = availableSpace / (components.count - 1)
      let extraSpaces = availableSpace % (components.count - 1)
      
      var result = leadingCap + capExtraSpaceSingle + textExtraSpaceSingle
      
      for (index, component) in components.enumerated() {
        result += component
        if index < components.count - 1 {
          let spaces = spacesPerSlice + (index < extraSpaces ? 1 : 0)
          result += String(repeating: paddingString, count: spaces)
        }
      }
      
      result += textExtraSpaceSingle + capExtraSpaceSingle + trailingCap
      
      
      
      return result
    }
    
    
  } // END pad line
  
}


public extension CGSize {
  var widthOrHeightIsZero: Bool {
    return self.width.isZero || self.height.isZero
  }
}

public enum DimensionForCell {
  case width, height
}

//protocol Flouble {
//
//
//
//  var width:
//}

public extension BinaryFloatingPoint {
  
  func snapToCell(cellSize: CGSize, dimension: DimensionForCell = .width) -> CGFloat {
    
    let cellDimension = dimension == .width ? cellSize.width : cellSize.height
    
    if let value = self as? CGFloat {
      
      let multiplier = (value / cellDimension).rounded()
      return multiplier * cellDimension
      
    } else if let value = self as? Double {
      
      let multiplier = (value / cellDimension).rounded()
      return multiplier * cellDimension
      
    } else {
      
      return .zero
    }
    
    
    
  }
}


struct TextCoreExampleView: View {
  
  let width: Int = 42
  
  let capSpace: String = "%"
  let textSpace: String = "^"
  
  var body: some View {
    
    VStack {
      
      Text(TextCore.widthCounter(self.width, style: .full))
      
      let text: String = """

      LineCap spacing = \(capSpace)
      Text spacing = \(textSpace)
      
      LineCaps, with spacing:
      \(TextCore.padLine(
          "Cap & text padding",
          with: "░",
          toFill: 42,
          alignment: .leading,
          caps: LineCaps("|", "|", hasExtraSpaces: true),
          hasSpaceAroundText: true
        ))
      \(TextCore.padLine(
        "Has text-pad, no cap-pad",
        with: "░",
        toFill: 42,
        alignment: .center,
        caps: LineCaps("|", "|", hasExtraSpaces: true),
        hasSpaceAroundText: true
      ))
      \(TextCore.padLine(
        "No text-pad. Has cap-pad",
        with: "░",
        toFill: 42,
        alignment: .trailing,
        caps: LineCaps("|", "|", hasExtraSpaces: true),
        hasSpaceAroundText: true
      ))
      

      ---
      
      No LineCaps, with spacing:
      \(TextCore.padLine(
        "Text padding center",
        with: "░",
        toFill: 42,
        alignment: .leading,
        hasSpaceAroundText: true
      ))
      \(TextCore.padLine(
        "Text padding center",
        with: "░",
        toFill: 42,
        alignment: .center,
        hasSpaceAroundText: true
      ))
      \(TextCore.padLine(
        "Text padding center",
        with: "░",
        toFill: 42,
        alignment: .trailing,
        hasSpaceAroundText: true
      ))
      
      ---
      
      
      \(TextCore.padLine(
        "Split ->@<- Split",
        with: "░",
        toFill: 42
      ))
      
      """
      
      Text(text)
//      .border(Color.green.opacity(0.3))
    }
    .textSelection(.enabled)
    .border(Color.green.opacity(0.1))
    .monospaced()
    .font(.system(size: 16))
    .padding(40)
    .frame(width: 600, height: 700)
//    .cellGrid(grid: GlyphGrid(cell: .example, dimensions: .example, type: .interface), autoSize: true)
    .background(.black.opacity(0.6))
    
  }
}
#Preview {
  TextCoreExampleView()
}


