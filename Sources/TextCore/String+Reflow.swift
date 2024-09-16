//
//  String+Reflow.swift
//  TextCore
//
//  Created by Dave Coleman on 14/9/2024.
//


public enum WordWrapStrategy: Sendable {
  case hyphenate
  case wrap
//  case crop
}
public enum PaddingBookend {
  case none
  case both(width: Int)
}

public extension String {
  
  func reflowText(
    width: Int,
    maxLines: Int = 0,
    paddingWidth: Int = 1, // leading and trailing
    paddingCharacter: Character = " ",
    wrappingOption: WordWrapStrategy = .wrap
  ) -> [String] {
    
    guard width > 0 else {
      print("Error: Width must be positive")
      return []
    }
    
    // Calculate the effective width for text content
    let effectiveWidth = width - (2 * paddingWidth)
    guard effectiveWidth > 0 else {
      print("Error: Width is too small to accommodate padding")
      return []
    }
    
    let paragraphs = self.components(separatedBy: .newlines)
    var reflowedLines: [String] = []
    
    for paragraph in paragraphs {
      if paragraph.isEmpty {
        reflowedLines.append(String(repeating: paddingCharacter, count: width))
        continue
      }
      
      let words = paragraph.split(separator: " ")
      var currentLine = ""
      
      for word in words {
        if currentLine.isEmpty && word.count <= effectiveWidth {
          currentLine = String(word)
        } else if currentLine.count + word.count + 1 <= effectiveWidth {
          currentLine += " \(word)"
        } else {
          
          reflowedLines.append(currentLine.padLine(toFill: width, with: paddingCharacter, bookends: .both(width: paddingWidth)))
          
          // Handle word exceeding width
          if word.count > effectiveWidth {
            let wrappedWords = wrapLongWord(String(word), width: effectiveWidth, option: wrappingOption)
            
            
            reflowedLines.append(contentsOf: wrappedWords.dropLast().map {
              $0.padLine(toFill: width, with: paddingCharacter, bookends: .both(width: paddingWidth))
            })
            currentLine = wrappedWords.last ?? ""
          } else {
            currentLine = String(word)
          }
        }
      }
      
      if !currentLine.isEmpty {
        reflowedLines.append(currentLine.padLine(toFill: width, with: paddingCharacter, bookends: .both(width: paddingWidth)))
      }
    }
    
    if maxLines > 0 {
      reflowedLines = Array(reflowedLines.prefix(maxLines))
    }
    
    return reflowedLines
  }

  private func padLine(
    toFill width: Int,
    with character: Character,
    bookends: PaddingBookend = .none
  ) -> String {
    
    var result: String = self
    
    switch bookends {
      case .both(let bookendWidth):
        let bookendPadding = String(repeating: character, count: bookendWidth)
        result = bookendPadding + result + bookendPadding
      case .none:
        break
    }
    
    let remainingWidth = max(0, width - result.count)
    result += String(repeating: character, count: remainingWidth)
    
    return result

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
