//
//  AttributedString.swift
//  SwiftBox
//
//  Created by Dave Coleman on 27/8/2024.
//

import Foundation

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
  
//  func setStyle(in range: AttributedRange, attrString: inout Self) {
//    
//  }
}
