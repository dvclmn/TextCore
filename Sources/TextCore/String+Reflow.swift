//
//  String+Reflow.swift
//  TextCore
//
//  Created by Dave Coleman on 14/9/2024.
//



public extension String {
  
  enum WrappingOption {
    case hyphenate
    case wrap
  }
  
  func reflowText(
    width: Int,
    maxLines: Int = 0,
    paddingCharacter: Character = " "
  ) -> [String] {
    
    var lines: [String] = []
    
    if maxLines > 0 {
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
    paddingCharacter: Character = " ",
    wrappingOption: WrappingOption = .wrap
  ) -> [String] {
    
    guard width > 0 else {
      print("Error: Width must be positive")
      return []
    }
    
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
        if currentLine.isEmpty && word.count <= width {
          currentLine = String(word)
        } else if currentLine.count + word.count + 1 <= width {
          currentLine += " \(word)"
        } else {
          // Add the current line to reflowedLines
          reflowedLines.append(padLine(currentLine, toWidth: width, with: paddingCharacter))
          
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
        // Safely pad the last line of the paragraph
        let paddingCount = max(0, width - currentLine.count)
        currentLine += String(repeating: paddingCharacter, count: paddingCount)
        reflowedLines.append(currentLine)
      }
    }
    
    //    print(reflowedLines)
    return reflowedLines
  }
  
  
  
  private func padLine(_ line: String, toWidth width: Int, with character: Character) -> String {
    let paddingCount = max(0, width - line.count)
    return line + String(repeating: character, count: paddingCount)
  }

  
  
  private func wrapLongWord(_ word: String, width: Int, option: WrappingOption) -> [String] {
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
      }
    }
    
    return wrappedWords
  }

  
  
  
}
