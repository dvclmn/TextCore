//
//  AnotherPadTextView.swift
//  TextCore
//
//  Created by Dave Coleman on 30/8/2024.
//

import SwiftUI



struct TextCoreExampleView: View {
  
  let width = 41
  
  let capSpace: String = "%"
  let textSpace: String = "^"
  
  @State private var grid = GlyphGrid(cell: .example, dimensions: .example, type: .interface)
  
  var body: some View {
    
    VStack(alignment: .leading) {
      
      Text(styledText)
      
    }
    .textSelection(.enabled)
    .border(Color.green.opacity(0.1))

    .frame(width: 420.snapToCell(cellSize: grid.cell.size), height: 770, alignment: .topLeading)
        .cellGrid(grid: grid)
    .background(.black.opacity(0.6))
    
  }
}

extension TextCoreExampleView {
  
  var fontContainer: AttributeContainer {
    var container = AttributeContainer()
    container.font = .custom(grid.cell.fontName.rawValue, size: GlyphGrid.baseFontSize)
    
    return container
  }
  
  
  var styledText: AttributedString {
    
    let cap = "╳"
    
    var output = AttributedString("")
    
    print("Font name: \(output)")
    
//    output[AttributeScopes.AppKitAttributes.FontAttribute.self] = .init(name: grid.cell.fontName.rawValue, size: GlyphGrid.baseFontSize)
    
    output.appendString(TextCore.widthCounter(self.width, style: .full).asString)
    
    output.appendString("# LineCaps, with spacing")
    
    output.appendString(
      TextCore.padLine(
        "Cap & text padding",
        with: "░",
        toFill: width,
        alignment: .leading,
        caps: LineCaps(cap, cap, hasExtraSpaces: true),
        hasSpaceAroundText: true
      )
    )
    
    output.appendString(
      TextCore.padLine(
        "Has text-pad, no cap-pad",
        with: "░",
        toFill: width,
        alignment: .center,
        caps: LineCaps(cap, cap, hasExtraSpaces: true),
        hasSpaceAroundText: true
      )
    )
    
    output.appendString(
      TextCore.padLine(
        "No text-pad. Has cap-pad",
        with: "░",
        toFill: width,
        alignment: .trailing,
        caps: LineCaps(cap, cap),
        hasSpaceAroundText: true
      )
    )
    
    output.addLineBreak()
    
    output.appendString("# No LineCaps, with spacing")
    
    output.appendString(
      TextCore.padLine(
        "Text padding center",
        with: "░",
        toFill: width,
        alignment: .leading,
        hasSpaceAroundText: true
      )
    )
    output.appendString(
      TextCore.padLine(
        "Text padding center",
        with: "░",
        toFill: width,
        alignment: .center,
        hasSpaceAroundText: true
      )
    )
    output.appendString(
      TextCore.padLine(
        "Text padding center",
        with: "░",
        toFill: width,
        alignment: .trailing,
        hasSpaceAroundText: true
      )
    )
    
    
    output.addLineBreak()
    
    output.appendString("# Splits [✓], spaces [✓], caps [ ]")
    
    output.appendString(
      TextCore.padLine(
        "Split ->@<- Split",
        with: "░",
        toFill: width
      )
    )
    output.appendString(
      TextCore.padLine(
        "An icon@Some nice text",
        with: "░",
        toFill: width
      )
    )
    output.appendString(
      TextCore.padLine(
        "@Two splits@Split at begin@ning",
        with: "░",
        toFill: width
      )
    )
    
    output.addLineBreak()
    output.appendString("# Splits [✓], spaces [ ], caps [ ]")
    
    output.appendString(
      TextCore.padLine(
        "Split ->@<- Split",
        with: "░",
        toFill: width,
        hasSpaceAroundText: false
      )
    )
    output.appendString(
      TextCore.padLine(
        "An icon@Some nice text",
        with: "░",
        toFill: width,
        hasSpaceAroundText: false
      )
    )
    output.appendString(
      TextCore.padLine(
        "@Two splits@Split at begin@ning",
        with: "░",
        toFill: width,
        hasSpaceAroundText: false
      )
    )
    
    
    output.addLineBreak()
    output.appendString("# Splits [✓], spaces [✓], caps [✓]")
    
    output.appendString(
      TextCore.padLine(
        "Split ->@<- Split",
        with: "░",
        toFill: width,
        caps: LineCaps(cap, cap)
      )
    )
    output.appendString(
      TextCore.padLine(
        "An iconSome ni@ce text@",
        with: "░",
        toFill: width,
        caps: LineCaps(cap, cap)
      )
    )
    output.appendString(
      TextCore.padLine(
        "@Two splits@Split at begin@ning",
        with: "░",
        toFill: width,
        caps: LineCaps(cap, cap)
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
    
    
    let headingPattern: Regex<Substring> = /\#\s.*/
    let textSpacerPattern: Regex<Substring> = /^/
    
    let ranges = output.getAllRanges(matching: headingPattern)
    
    print("How many ranges? \(ranges.count)")
    //      output[range].setAttributes(.blackOnWhite)
    
    for range in ranges {
      print("Ranges: \(output[range])")
//      output[range].mergeAttributes(.blackOnWhite)
    }
    
    output.setAttributes(fontContainer)
    
    grid.cell.updateFont(fontName: .monaco)
    
    return output
    
  }
}

#Preview {
  TextCoreExampleView()
}




