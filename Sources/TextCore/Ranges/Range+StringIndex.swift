//
//  Range+StringIndex.swift
//  TextCore
//
//  Created by Dave Coleman on 30/8/2024.
//

import Foundation

/// This is *very* helpful — don't delete willy-nilly!
///
/// This allows me to use `ranges(of:)`, on `String`, which returns `Range<String.Index>`
/// and then convert that (using the below) to `Range<AttributedString.Index>`
/// (`https://developer.apple.com/documentation/swift/bidirectionalcollection/ranges(of:)-9qfdo`)
///
public extension Range where Bound == String.Index {
  
  func getAttributedRange(in attrString: AttributedString) -> Range<AttributedString.Index>? {
    
    /// Convert String.Index range to AttributedString.Index range
    ///
    let startIndex = AttributedString.Index(self.lowerBound, within: attrString)
    let endIndex = AttributedString.Index(self.upperBound, within: attrString)

    /// Check if both indices are valid
    ///
    guard let start = startIndex, let end = endIndex else {
      print("Invalid range")
      return nil
    }

    /// Create the AttributedString range
    ///
    let attributedStringRange: Range<AttributedString.Index> = start..<end
    
    return attributedStringRange
  }
}



//public extension Range where Bound == String.Index {
//  func textRange(in string: String, provider: NSTextElementProvider) -> NSTextRange? {
//    
//    let documentLocation: NSTextLocation = provider.documentRange.location
//    
//    let oldStart: Int = self.lowerBound.utf16Offset(in: string)
//    let oldEnd: Int = self.upperBound.utf16Offset(in: string)
//    
//    guard let newStart = provider.location?(documentLocation, offsetBy: oldStart),
//          let newEnd = provider.location?(documentLocation, offsetBy: oldEnd)
//    else { return nil }
//    
//    let finalResult = NSTextRange(location: newStart, end: newEnd)
//    
//    return finalResult
//    
//  }
//}
