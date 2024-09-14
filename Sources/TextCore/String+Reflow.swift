//
//  String+Reflow.swift
//  TextCore
//
//  Created by Dave Coleman on 14/9/2024.
//



public extension String {
  
  func reflowText(
    width: Int,
    maxLines: Int?,
    paddingCharacter: Character = " "
  ) -> [String] {
    
    var lines: [String] = []
    
    if let maxLines = maxLines {
      lines = Array(
        processReflow(
          text: self,
          width: width,
          paddingCharacter: paddingCharacter
        ).prefix(maxLines)
      )
    } else {
      lines = processReflow(
        text: self,
        width: width,
        paddingCharacter: paddingCharacter
      )
    }
    
    return lines
  }
  
  private func processReflow(
    text: String,
    width: Int,
    paddingCharacter: Character = " "
  ) -> [String] {
    
    let paragraphs = text.components(separatedBy: .newlines)
    var reflowedLines: [String] = []
    
    for paragraph in paragraphs {
      if paragraph.isEmpty {
        reflowedLines.append(String(repeating: paddingCharacter, count: width))
        continue
      }
      
      /// Splits up the paragraph, using the `seperator` to
      /// determine where the splitting should happen.
      ///
      let words = paragraph.split(separator: " ")
      var currentLine = ""
      
      for word in words {
        if currentLine.isEmpty {
          currentLine = String(word)
        } else if currentLine.count + word.count + 1 <= width {
          currentLine += " \(word)"
        } else {
          // Pad the current line with spaces to reach the full width
          currentLine += String(repeating: paddingCharacter, count: width - currentLine.count)
          reflowedLines.append(currentLine)
          currentLine = String(word)
        }
      }
      
      if !currentLine.isEmpty {
        // Pad the last line of the paragraph with spaces
        currentLine += String(repeating: paddingCharacter, count: width - currentLine.count)
        reflowedLines.append(currentLine)
      }
    }
    
    //    print(reflowedLines)
    return reflowedLines
  }
}
