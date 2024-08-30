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
  
  @State var attStr: AttributedString?
  
  var body: some View {
    
    VStack(alignment: .leading) {
//      
//      Text(attStr ?? "nothing")
//        .onAppear {
//          let str = "Lorem ipsum dolor <test>first tag</test> sit Donec <test>second tag</test>"
//          attStr = transform(str, from: "<", to: "t", with: .red)
//        }
      
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
    
    var output = padLineString(width: self.width, cap: cap)
    
    
    let headingPattern: Regex<Substring> = /\#\s.*/
    let textSpacerPattern: Regex<Substring> = /\^/
    
    grid.cell.updateFont(fontName: .monaco)
    
    let headingRanges = output.getAllRanges(matching: headingPattern)
    let textSpacerRanges = output.getAllRanges(matching: textSpacerPattern)
    
    let string = String(output.characters)
    
//    print("String: \(string)")
    
    let spacerRanges: [Range<String.Index>] = string.ranges(of: textSpacerPattern)
    
    print("Find all instances of `^`. How many did we find? \(spacerRanges.count)")
    
    for spacerRange in spacerRanges {
      
      guard let attrRange = spacerRange.getAttributedRange(in: output) else { break }
      output[attrRange].mergeAttributes(.highlighter)
    }
    
//    print("How many ranges? \(headingRanges.count)")
    //      output[range].setAttributes(.blackOnWhite)
    
    for headingRange in headingRanges {
      //      print("Ranges: \(output[range])")
      output[headingRange].mergeAttributes(.blackOnWhite)
    }
    
    for textSpacerRange in textSpacerRanges {
      //      print("Ranges: \(output[range])")
      output[textSpacerRange].mergeAttributes(.highlighter)
    }
    
    output.mergeAttributes(fontContainer)
    
    
    return output
    
  }
  
//  func transform(_ input: String, from: String, to: String, with color: Color) -> AttributedString {
//    var attInput = AttributedString(input)
//    let _ = input.components(separatedBy: from).compactMap { sub in
//      (sub.range(of: to)?.lowerBound).flatMap { endRange in
//        let s = String(sub[sub.startIndex ..< endRange])
//        // use `s` for just the middle string
//        if let theRange = attInput.range(of: (from + s + to)) {
//          attInput[theRange].foregroundColor = color
//        }
//      }
//    }
//    return attInput
//  }
}

#Preview {
  TextCoreExampleView()
}




