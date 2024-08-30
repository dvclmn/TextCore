//
//  AnotherPadTextView.swift
//  TextCore
//
//  Created by Dave Coleman on 30/8/2024.
//

import SwiftUI



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
    
    output.appendString("# Splits [✓], spaces [ ], caps [ ]")
    
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
    
    output.addLineBreak()
    output.appendString("# Splits [✓], spaces [ ], caps [ ]")
    
    output.appendString(
      TextCore.padLine(
        "Split ->@<- Split",
        with: "░",
        toFill: 42,
        hasSpaceAroundText: false
      )
    )
    output.appendString(
      TextCore.padLine(
        "An icon@Some nice text",
        with: "░",
        toFill: 42,
        hasSpaceAroundText: false
      )
    )
    output.appendString(
      TextCore.padLine(
        "@Two splits@Split at begin@ning",
        with: "░",
        toFill: 42,
        hasSpaceAroundText: false
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




