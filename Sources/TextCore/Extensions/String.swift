//
//  String.swift
//  TextCore
//
//  Created by Dave Coleman on 11/9/2024.
//


public extension String {
  static func repeating(
    _ mainChar: Character,
    alternating altChar: Character,
    every n: Int,
    totalCount: Int,
    startingAt offset: Int = 0
  ) -> String {
    var result = ""
    for i in 0..<totalCount {
      if (i + offset) % n == 0 {
        result.append(altChar)
      } else {
        result.append(mainChar)
      }
    }
    return result
  }
  
  
  
  func reflowText(width: Int, maxLines: Int?) -> [String] {
    
    return trimLines(width: width, maxLines: maxLines)
  }
  
  func reflowText(width: Int, maxLines: Int?) -> String {
    
    let lines = trimLines(width: width, maxLines: maxLines)
    
    let joinedResult = lines.map { line in
      line
    }.joined(separator: "\n")
    
    return joinedResult
  }
  
  private func trimLines(width: Int, maxLines: Int?) -> [String] {
    
    var lines: [String] = []
    
    if let maxLines = maxLines {
      lines = Array(processReflow(text: self, width: width).prefix(maxLines))
    } else {
      lines = processReflow(text: self, width: width)
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
