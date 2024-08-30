//
//  PadLine.swift
//  TextCore
//
//  Created by Dave Coleman on 29/8/2024.
//

import SwiftUI
import BaseHelpers
import Foundation



struct TextCoreExampleView: View {
  
  let width: Int = 42
  
  let capSpace: String = "%"
  let textSpace: String = "^"
  
  var body: some View {
    
    VStack {
      
      Text(TextCore.widthCounter(self.width, style: .full))
      
      Text(styledText)
      
    }
    .textSelection(.enabled)
    .border(Color.green.opacity(0.1))
    .monospaced()
    .font(.system(size: 16))
    .padding(40)
    .frame(width: 600, height: 770)
    //    .cellGrid(grid: GlyphGrid(cell: .example, dimensions: .example, type: .interface), autoSize: true)
    .background(.black.opacity(0.6))
    
  }
}

extension TextCoreExampleView {
  

  var styledText: AttributedString {
    
    var output = AttributedString()
    
    output.appendString("# LineCaps, with spacing")
    
    output.appendString(
      TextCore.padLine(
        "Cap & text padding",
        with: "░",
        toFill: 42,
        alignment: .leading,
        caps: LineCaps("|", "|", hasExtraSpaces: true),
        hasSpaceAroundText: true
      )
    )
    
    output.appendString(
      TextCore.padLine(
        "Has text-pad, no cap-pad",
        with: "░",
        toFill: 42,
        alignment: .center,
        caps: LineCaps("|", "|", hasExtraSpaces: true),
        hasSpaceAroundText: true
      )
    )
    
    output.appendString(
      TextCore.padLine(
        "No text-pad. Has cap-pad",
        with: "░",
        toFill: 42,
        alignment: .trailing,
        caps: LineCaps("|", "|", hasExtraSpaces: true),
        hasSpaceAroundText: true
      )
    )
    
    output.addLineBreak()
    
    output.appendString("# No LineCaps, with spacing")
    
    output.appendString(
      TextCore.padLine(
        "Text padding center",
        with: "░",
        toFill: 42,
        alignment: .leading,
        hasSpaceAroundText: true
      )
    )
    output.appendString(
      TextCore.padLine(
        "Text padding center",
        with: "░",
        toFill: 42,
        alignment: .center,
        hasSpaceAroundText: true
      )
    )
    output.appendString(
      TextCore.padLine(
        "Text padding center",
        with: "░",
        toFill: 42,
        alignment: .trailing,
        hasSpaceAroundText: true
      )
    )
    
    
    output.addLineBreak()
    
    output.appendString("# No LineCaps, with spacing:")
    
    output.appendString(
      TextCore.padLine(
        "Split ->@<- Split",
        with: "░",
        toFill: 42
      )
    )
    output.appendString(
      TextCore.padLine(
        "An icon@Some nice text",
        with: "░",
        toFill: 42
      )
    )
    output.appendString(
      TextCore.padLine(
        "@Two splits@Split at begin@ning",
        with: "░",
        toFill: 42
      )
    )
    
   
    
    
//    for characters in output.characters {
//      
////      print("Match: \(characters)")
//      
////      print()
//      
//      if characters.isNewline {
//        print("New line: \(characters)")
//      }
//      
//    }
    
    
    let pattern: Regex<Substring> = /\#\s.*/
    
    let ranges = output.getAllRanges(matching: pattern)
      
    print("How many ranges? \(ranges.count)")
//      output[range].setAttributes(.blackOnWhite)
      
    for range in ranges {
      print("Ranges: \(output[range])")
      output[range].setAttributes(.blackOnWhite)
    }
      
    
    
    
    
    return output
    
  }
  
  
}

#Preview {
  TextCoreExampleView()
}





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
    /// I could consider changing `omittingEmptySubsequences: true` to `false`,
    /// if I needed support for allowing `@` splits at the very beginning or end of the line.`
    ///
    /// For example, below I've placed an `@` at the beginning:
    ///
    /// ```
    /// TextCore.padLine(
    /// "@Two splits@Split at beggining",
    /// with: "░",
    /// toFill: 42
    /// )
    /// ```
    /// Content: `["", "Two splits", "Split at beggining"]`
    ///
    /// Result: `^░░░░░^Two splitsx░░░░░^Split at beggining`
    /// Or, result: `Two splits^░░░░░░░░░░^Split at beggining`
    let splitTextChunk: [String.SubSequence] = text.split(separator: sliceCharacter, omittingEmptySubsequences: false)
//    print("Component count: \(splitTextChunk.count)")
//    print("Components: \(splitTextChunk)\n\n")
    
    /// This is the number of characters in the text content only. This will be added
    /// to the total count, including caps/padding, to compare against the
    /// `toFill width: Int` parameter.
    ///
    let contentWidth = splitTextChunk.reduce(0) { $0 + $1.count }
    
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
    
    let totalFixedWidth = contentWidth + leadingCap.count + trailingCap.count + capExtraSpaceWidth + textExtraSpaceWidth
    
    
    /// Calculates the space left after accounting for all the text content, caps, and
    /// padding — and ensures the value does not fall below zero.
    ///
    let availableSpace = max(0, width - totalFixedWidth)
    
    let metrics: String = """
    Content: \(splitTextChunk)
    Total width added up: \(totalFixedWidth)
    Content width: \(contentWidth)
    Caps: \(leadingCap.count + trailingCap.count), and their spaces: \(capExtraSpaceWidth)
    Text extra spaces count: \(textExtraSpaceWidth)
    
    Provided space: \(width)
    Final available width: \(availableSpace)
    
    
    
    """
    
//    print(metrics)
    
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
    if splitTextChunk.count <= 1 {
      
      let (leftPadding, rightPadding) = distributeDynamicPadding(availableSpace)
      
      return leadingCap + capExtraSpaceSingle
      + String(repeating: paddingString, count: leftPadding)
      + textExtraSpace.0 + text + textExtraSpace.1
      + String(repeating: paddingString, count: rightPadding)
      + capExtraSpaceSingle + trailingCap
      
      
    } else {
      
      /// There *was* a split character provided.
      ///
      /// `components.count - 1` gives us the total number of gaps between
      /// components — always one less than the number of components.
      ///
      
      
      let paddingPerSlice: Int = availableSpace / (splitTextChunk.count - 1)
      
      /// Suppose we have the string `Hello@World@Swift` and 10 available spaces.
      ///
      /// - `components` would be `["Hello", "World", "Swift"]`
      /// - `components.count` is 3
      /// - `components.count - 1` is 2 (number of gaps)
      ///
      /// Now, let's calculate:
      ///
      /// 1. `spacesPerSlice = 10 / 2 = 5`
      /// This means we can put 5 spaces between each component.
      ///
      /// 2. `extraSpaces = 10 % 2 = 0`
      /// There are no extra spaces left over.
      ///
      /// The result would be: `Hello     World     Swift`
      ///
      /// Let's look at another example with 11 available spaces:
      ///
      /// 1. `spacesPerSlice = 11 / 2 = 5`
      /// We can still put 5 spaces between each component.
      ///
      /// 2. `extraSpaces = 11 % 2 = 1`
      /// We have 1 extra space left over.
      ///
      /// In this case, we'd distribute the extra space in the first gap:
      /// `Hello      World     Swift`
      ///
      /// This approach ensures that we use all available space and distribute it as evenly as possible between components.
      ///
      let leftoverPadding = availableSpace % (splitTextChunk.count - 1)
      
      var result = leadingCap + capExtraSpaceSingle
      
      /// Enumerates the components. More than one split character is supported.
      ///
      for (index, textContent) in splitTextChunk.enumerated() {
        
        var leadingSpace = index == 0 ? textExtraSpace.0 : "x"
        var trailingSpace = textExtraSpace.1
        
        result += textContent
        
        /// The below (`if index < components.count - 1`) makes sure the current
        /// component is not the *last* one in the array of components. We use this to determine
        /// whether to add padding after the current component.
        ///
        /// We don't want to add padding after the last component, as that would put unnecessary
        /// spacing at the end of the string.
        ///
        /// Let's break it down further:
        ///
        /// - `components.count` gives us the total number of components.
        /// - `components.count - 1` is the index of the last component.
        /// - `index < components.count - 1` is true for all components except the last one.
        ///
        /// For example, if we have a string "Hello@World" split by "@":
        ///
        /// - `components` would be `["Hello", "World"]`
        /// - `components.count` would be 2
        /// - `components.count - 1` would be 1
        ///
        /// So, when we iterate:
        /// - For "Hello" `(index 0): 0 < 1` is true, so we add padding after it.
        /// - For "World" `(index 1): 1 < 1` is false, so we don't add padding after it.
        ///
        /// This ensures that we add padding between components but not after the final component,
        /// which helps maintain the correct overall width and appearance of the padded line.
        ///
        if index < splitTextChunk.count - 1 {
          
          let padding = paddingPerSlice + (index < leftoverPadding ? 1 : 0)
          
          /// This is where the padding is actually added, for each split
          ///
          result += leadingSpace
          + String(repeating: paddingString, count: padding)
          + trailingSpace
          
        } else {
          //          result += "Butts"
        }
        
      }
      
      result += capExtraSpaceSingle + trailingCap
      
      return result
    }
    
    
  } // END pad line
  
}

