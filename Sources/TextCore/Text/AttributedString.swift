//
//  AttributedString.swift
//  SwiftBox
//
//  Created by Dave Coleman on 27/8/2024.
//

import Foundation

//public typealias

/// The first `Substring` is reserved for the full match. The subsequent three can be used
/// in whatever way makes sense. E.g. for content surrounded by syntax, such as `*italics*`.
///
/// In that example, substrings 2, 3 and 4 would hold the leading asterisk, text content,
/// and trailing asterisk respectively.
///
public typealias ThreePartRegex = Regex<(Substring, Substring, Substring, Substring)>

/// The attributed range as described below, pairs with the `ThreePartRegex` above,
/// and provides a mechism through which to identify where in the
/// `AttributedString` the resulting matches are located.
///
public typealias AttributedRange = Range<AttributedString.Index>

public typealias ThreePartRange = (AttributedRange, AttributedRange, AttributedRange)


public extension AttributedString {
  
  ///
  ///
  /// ```
  /// var output = attrString
  ///
  /// let numberByNumberPattern: ThreePartRegex = /([\d\.]+)(x)([\d\.]+)/
  ///
  /// if let ranges = getRange(for: numberByNumberPattern, in: output) {
  ///   output[ranges.0].setAttributes(style(for: part, subPart: .number))
  ///   output[ranges.1].setAttributes(style(for: part, subPart: .operator))
  ///   output[ranges.2].setAttributes(style(for: part, subPart: .number))
  /// }
  ///
  /// return output
  /// ```
  ///
  func getRange(for pattern: ThreePartRegex) -> ThreePartRange? {
    
    //    var range: Range<AttributedString.Index>
    
    //    var output = ThreePartRegex.AttributedRange()
    
    let string = String(self.characters)
    
    let matches = string.matches(of: pattern)
    
    for match in matches {
      guard let range01 = self.range(of: match.output.1),
            let range02 = self.range(of: match.output.2),
            let range03 = self.range(of: match.output.3)
      else {
        
        break
      }
      
      return (range01, range02, range03)
      
    }
    return nil
  }
  
  func getAllRanges(matching pattern: Regex<Substring>) -> [AttributedRange] {
    let string = String(self.characters)
    let matches = string.matches(of: pattern)
    
    var ranges: [Range<AttributedString.Index>] = []
    
    for match in matches {
      if let range = self.range(of: match.output) {
        ranges.append(range)
      }
    }
    
    return ranges
  }
  
  func getRange(matching pattern: Regex<Substring>) -> AttributedRange? {

    let string = String(self.characters)
    
    let matches = string.matches(of: pattern)
    
    for match in matches {
      
      guard let range = self.range(of: match.output) else { break }
      
      return range
      
    }
    return nil
  }

//  func getAllRangesIncremental(matching pattern: Regex<Substring>) -> [Range<AttributedString.Index>] {
//    let string = String(self.characters)
//    var ranges: [Range<AttributedString.Index>] = []
//    var searchRange = string.startIndex..<string.endIndex
//    
//    while let match = string.range(of: pattern, range: searchRange) {
//      if let attrRange = self.range(of: string[match]) {
//        ranges.append(attrRange)
//      }
//      searchRange = match.upperBound..<string.endIndex
//    }
//    
//    return ranges
//  }
  
//  func setStyle(in range: AttributedRange, attrString: inout Self) {
//    
//  }
}


//
//extension AttributedString {
//  func getAllRangesParallel(matching pattern: Regex<Substring>) -> [Range<AttributedString.Index>] {
//    let string = String(self.characters)
//    let chunkSize = max(1000, string.count / ProcessInfo.processInfo.activeProcessorCount)
//    
//    let ranges = string.chunks(ofCount: chunkSize).parallelMap { chunk in
//      string.ranges(of: pattern, range: chunk.startIndex..<chunk.endIndex)
//    }.flatMap { $0 }
//    
//    return ranges.compactMap { self.range(of: string[$0]) }
//  }
//}
//
//extension Sequence {
//  func parallelMap<T>(_ transform: @escaping (Element) -> T) -> [T] {
//    let result = Array<T?>(repeating: nil, count: self.underestimatedCount)
//    DispatchQueue.concurrentPerform(iterations: result.count) { idx in
//      result[idx] = transform(self[self.index(self.startIndex, offsetBy: idx)])
//    }
//    return result.compactMap { $0 }
//  }
//  }

//
//extension AttributedString {
//  
//  func getAllRanges(matching pattern: Regex<Substring>) -> [AttributedRange] {
//    
//    let string = String(self.characters)
//    let matches = string.matches(of: pattern)
//    
//    var ranges: [AttributedRange] = []
//    
//    var searchStartIndex = self.startIndex
//    
//    for match in matches {
//      let matchString = String(match.output)
//      
//      while true {
//        guard let matchStartIndex = self.index(of: matchString, from: searchStartIndex) else {
//          break // No more matches found
//        }
//        
//        let matchEndIndex = self.index(matchStartIndex, offsetByCharacters: matchString.count)
//        
//        ranges.append(matchStartIndex..<matchEndIndex)
//        
//        // Move the search start index just past this match
//        searchStartIndex = self.index(afterCharacter: matchStartIndex)
//        
//        // If we've reached the end of the string, break
//        if searchStartIndex >= self.endIndex {
//          break
//        }
//      }
//    }
//    
//    return ranges
//  }
//  
//  private func index(of substring: String, from startIndex: AttributedString.Index) -> AttributedString.Index? {
//    var currentIndex = startIndex
//    while currentIndex < self.endIndex {
//      let endIndex = self.index(currentIndex, offsetByCharacters: substring.count)
//      let subAttString = self[currentIndex..<endIndex]
//      if String(subAttString.characters) == substring {
//        return currentIndex
//      }
//      currentIndex = self.index(afterCharacter: currentIndex)
//    }
//    return nil
//  }
//}
