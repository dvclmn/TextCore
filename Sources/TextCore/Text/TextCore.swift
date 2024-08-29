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

      Splits and caps:      
      \(TextCore.padLine(
        "Split ->@<- Split",
        with: "░",
        toFill: 42,
      caps: LineCaps("|", "|", hasExtraSpaces: true)
      ))
      \(TextCore.padLine(
        "An icon@Some nice text",
        with: "░",
        toFill: 42,
      caps: LineCaps("|", "|", hasExtraSpaces: true)
      ))
      \(TextCore.padLine(
        "@Two splits@Split at beggining",
        with: "░",
        toFill: 42,
      caps: LineCaps("|", "|", hasExtraSpaces: true)
      ))
      
      ---
      
      Splits and no caps:
      \(TextCore.padLine(
        "Split ->@<- Split",
        with: "░",
        toFill: 42
      ))
      \(TextCore.padLine(
        "An icon@Some nice text",
        with: "░",
        toFill: 42
      ))
      \(TextCore.padLine(
        "@Two splits@Split at beggining",
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


