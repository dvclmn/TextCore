//
//  PadLineTests.swift
//  TextCore
//
//  Created by Dave Coleman on 30/8/2024.
//

import Foundation

extension TextCoreExampleView {
  
  func padLineString(width: Int, cap: String) -> AttributedString {
    
    var output = AttributedString()
    
    output.appendString(TextCore.widthCounter(self.width, style: .full).string)
    
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
        "@Here is some@ text to@ split",
        with: "░",
        toFill: width,
        caps: LineCaps(cap, cap)
      )
    )
    
    return output
  }
  
}
