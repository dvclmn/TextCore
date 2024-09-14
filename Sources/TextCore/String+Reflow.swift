//
//  String+Reflow.swift
//  TextCore
//
//  Created by Dave Coleman on 14/9/2024.
//


public enum WordWrapStrategy {
  case hyphenate
  case wrap
//  case crop
}

public extension String {
  
  func reflowText(
    width: Int,
    maxLines: Int = 0,
    paddingCharacter: Character = " ",
    wrappingOption: WordWrapStrategy = .wrap
  ) -> [String] {

    guard width > 0 else {
      print("Error: Width must be positive")
      return []
    }
    
    let paragraphs = self.components(separatedBy: .newlines)
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
        if currentLine.isEmpty && word.count <= width {
          currentLine = String(word)
        } else if currentLine.count + word.count + 1 <= width {
          currentLine += " \(word)"
        } else {
          // Add the current line to reflowedLines
          reflowedLines.append(padLine(currentLine, toFill: width, with: paddingCharacter))
          
          // Handle word exceeding width
          if word.count > width {
            let wrappedWords = wrapLongWord(String(word), width: width, option: wrappingOption)
            reflowedLines.append(contentsOf: wrappedWords.dropLast())
            currentLine = wrappedWords.last ?? ""
          } else {
            currentLine = String(word)
          }
        }
      }
      
      
      
      
      if !currentLine.isEmpty {
        reflowedLines.append(padLine(currentLine, toFill: width, with: paddingCharacter))
      }
    }
    
    if maxLines > 0 {
      reflowedLines = Array(reflowedLines.prefix(maxLines))
    }
    
    return reflowedLines
  }
  
  
  
  private func padLine(
    _ line: String,
    toFill width: Int,
    with character: Character
  ) -> String {
    let paddingCount = max(0, width - line.count)
    return line + String(repeating: character, count: paddingCount)
  }
  
  private func wrapLongWord(_ word: String, width: Int, option: WordWrapStrategy) -> [String] {
    var wrappedWords: [String] = []
    var remainingWord = word
    
    while !remainingWord.isEmpty {
      if remainingWord.count <= width {
        wrappedWords.append(remainingWord)
        break
      }
      
      switch option {
        case .hyphenate:
          let splitIndex = width - 1 // Leave space for hyphen
          let line = remainingWord.prefix(splitIndex) + "-"
          wrappedWords.append(String(line))
          remainingWord = String(remainingWord.dropFirst(splitIndex))
        case .wrap:
          let splitIndex = width
          let line = remainingWord.prefix(splitIndex)
          wrappedWords.append(String(line))
          remainingWord = String(remainingWord.dropFirst(splitIndex))
//        case .crop:
//          let line = remainingWord.prefix(width)
//          wrappedWords.append(String(line))
//          break // Stop processing after cropping
      }
    }
    
    return wrappedWords
  }
  
  
  
}
