//
//  PadTextView.swift
//  SwiftBox
//
//  Created by Dave Coleman on 27/8/2024.
//

import SwiftUI

struct PadTextExampleView: View {
  
  @State private var isSelectFontActive: Bool = true
  
  let width: CGFloat = 280
  
  var body: some View {
    
    VStack{
      Text("Select font")
      Button {
        isSelectFontActive.toggle()
      } label: {
        Text(menuArt("Example Font", icon: "Aa"))
      }
      .buttonStyle(.plain)
    }
    .frame(width: width)
    
    .frame(width: 600, height: 700)
    .background(.purple.opacity(0.1))
    .background(.black.opacity(0.6))
    .font(.system(size: 14, weight: .regular, design: .monospaced))
  }
}

extension PadTextExampleView {
  func menuArt(
    _ text: String,
    icon: String
  ) -> AttributedString {
    var output = AttributedString()
//    
//    let cellSize: CGSize =
////    let cellSize: CGSize = TextCore.cellSize(fontName: "SF Mono")
//    let columnCount: Int = TextCore.cellColumnCount(for: self.width, cellSize: cellSize)
//    
//    let expandIcon: String = self.isSelectFontActive ? "-" : "+"
    
    var horizontalLine: String = ""
    var content: String = ""
    var bottomLine: String = ""
    var bottomLineAlt: String = ""
    var shadow: String = ""
    
    
    
    
    //    output.appendString(horizontalLine)
    //    output.addLineBreak()
    //    output.appendString(content)
    //    output.addLineBreak()
    //    output.appendString(bottomLine)
    
    if self.isSelectFontActive {
      output.appendString(horizontalLine)
    } else {
      output.addLineBreak()
      output.appendString(horizontalLine)
      
    }
    output.addLineBreak()
    output.appendString(content)
    output.addLineBreak()
    
    if self.isSelectFontActive {
      output.appendString(bottomLine)
      output.appendString(shadow)
      output.appendString(bottomLineAlt)
    } else {
      output.appendString(bottomLine)
      
    }
    
    
    
    //    if self.isSelectFontActive {
    //      for (index, font) in FontName.allCases.enumerated() {
    //
    //        let fontContent = TextCore.padLine(font.rawValue, toFill: fullWidth, caps: ("│", "│"))
    //
    //
    //        var line: String = ""
    //
    //        if index == 0 {
    //          // First line
    //
    //          line = TextCore.padLine(font.rawValue, with: "─", toFill: fullWidth, caps: ("┌", "┐"))
    //
    //        } else {
    //          // Subsequent lines
    //          line = TextCore.padLine(font.rawValue, with: "─", toFill: fullWidth, caps: ("├", "┤"))
    //
    //        }
    //
    //        output.appendString(line)
    //        output.addLineBreak()
    //        output.appendString(fontContent)
    //        output.addLineBreak()
    //      }
    //
    //      output.appendString(bottomLine)
    //    }
    
    
    
    
    
    return output
  }
  
  
}

#Preview {
  PadTextExampleView()
}

