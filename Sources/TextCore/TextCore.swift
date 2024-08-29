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


public struct LineCaps {
  var leading: String
  var trailing: String
  var hasPadding: Bool
  
  public init(
    _ leading: String,
    _ trailing: String,
    hasPadding: Bool = true
  ) {
    self.leading = leading
    self.trailing = trailing
    self.hasPadding = hasPadding
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
    hasHorizontalPadding: Bool = true
  ) -> String {
    
    
    let components = text.split(separator: sliceCharacter, omittingEmptySubsequences: false)
    let contentWidth = components.reduce(0) { $0 + $1.count }
    
    let leadingCap = caps?.leading ?? ""
    let trailingCap = caps?.trailing ?? ""
    
    let capPadding = (caps?.hasPadding == true) ? "C" : ""
    let capPaddingWidth = capPadding.count * 2
    
    let horizontalPadding = hasHorizontalPadding ? "T" : ""
    let horizontalPaddingWidth = horizontalPadding.count * 2
    
    let totalFixedWidth = contentWidth + leadingCap.count + trailingCap.count + capPaddingWidth + horizontalPaddingWidth
    let availableSpace = max(0, width - totalFixedWidth)
    
    func distributeSpace(_ space: Int) -> (left: Int, right: Int) {
      switch alignment {
        case .leading:
          return (0, space)
        case .trailing:
          return (space, 0)
        default: // .center
          let left = space / 2
          return (left, space - left)
      }
    }
    
    if components.count <= 1 {
      let (leftPadding, rightPadding) = distributeSpace(availableSpace)
      
      return leadingCap + capPadding + horizontalPadding +
      String(repeating: paddingString, count: leftPadding) +
      text +
      String(repeating: paddingString, count: rightPadding) +
      horizontalPadding + capPadding + trailingCap
    } else {
      let spacesPerSlice = availableSpace / (components.count - 1)
      let extraSpaces = availableSpace % (components.count - 1)
      
      var result = leadingCap + capPadding + horizontalPadding
      
      for (index, component) in components.enumerated() {
        result += component
        if index < components.count - 1 {
          let spaces = spacesPerSlice + (index < extraSpaces ? 1 : 0)
          result += String(repeating: paddingString, count: spaces)
        }
      }
      
      result += horizontalPadding + capPadding + trailingCap
      
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
  
  var body: some View {
    
    VStack {
      
      Text(TextCore.widthCounter(self.width, style: .full))
      
      Text(TextCore.padLine(
          "Cap & text padding",
          with: "░",
          toFill: 42,
          alignment: .leading,
          caps: LineCaps("|", "|", hasPadding: true),
          hasHorizontalPadding: true
        ))
      
      Text(TextCore.padLine(
        "Has text padding",
        with: "░",
        toFill: 42,
        alignment: .center,
        hasHorizontalPadding: true
      ))
      
      Text(TextCore.padLine(
        "Has text-pad, no cap-pad",
        with: "░",
        toFill: 42,
        alignment: .trailing,
        caps: LineCaps("|", "|", hasPadding: false),
        hasHorizontalPadding: true
      ))
      
      Text(TextCore.padLine(
        "No text-pad. Has cap-pad",
        with: "░",
        toFill: 42,
        alignment: .center,
        caps: LineCaps("|", "|", hasPadding: true),
        hasHorizontalPadding: false
      ))
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


