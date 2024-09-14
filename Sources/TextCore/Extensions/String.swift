//
//  String.swift
//  TextCore
//
//  Created by Dave Coleman on 11/9/2024.
//



public extension Character {
  var string: String {
    String(self)
  }
}

@resultBuilder
struct PatternBuilder {
  static func buildBlock(_ components: PatternComponent...) -> [PatternComponent] {
    return components
  }
}

public protocol PatternComponent {
  func apply(to string: inout String, remainingCount: inout Int)
}

struct ForEach: PatternComponent {
  let components: [PatternComponent]
  
  func apply(to string: inout String, remainingCount: inout Int) {
    for component in components {
      component.apply(to: &string, remainingCount: &remainingCount)
      if remainingCount == 0 { break }
    }
  }
}

public struct CharacterPattern: PatternComponent {
  let char: Character
  let count: Int
  
  public func apply(to string: inout String, remainingCount: inout Int) {
    let repeatCount = min(count, remainingCount)
    string += String(repeating: char, count: repeatCount)
    remainingCount -= repeatCount
  }
}

extension ForEach {
  init(@PatternBuilder _ builder: () -> [PatternComponent]) {
    self.components = builder()
  }
}


public extension String {
  static func pattern(totalCount: Int, @PatternBuilder _ builder: () -> [PatternComponent]) -> String {
    var result = ""
    var remainingCount = totalCount
    let components = builder()
    
    while remainingCount > 0 {
      for component in components {
        component.apply(to: &result, remainingCount: &remainingCount)
        if remainingCount == 0 { break }
      }
    }
    
    return result
  }

  init(pattern: (Character, Int)..., totalCount: Int) {
    self = String.pattern(totalCount: totalCount) {
      ForEach(components: pattern.map { repeating($0.0, count: $0.1) })
    }
  }
  
  static var dashDotPattern: (Int) -> String {
    return { count in
      String.pattern(totalCount: count) {
        character("-")
        character(".")
      }
    }
  }
}

func character(_ char: Character) -> PatternComponent {
  return CharacterPattern(char: char, count: 1)
}

func repeating(_ char: Character, count: Int) -> PatternComponent {
  return CharacterPattern(char: char, count: count)
}







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
