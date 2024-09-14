//
//  Joining.swift
//  TextCore
//
//  Created by Dave Coleman on 14/9/2024.
//

public extension MultilineString {
  
  func joinHorizontally(with other: MultilineString, padding: Character = " ") -> MultilineString {
    let maxHeight = Swift.max(self.height, other.height)
    var result = MultilineString([])
    
    for i in 0..<maxHeight {
      let leftRow = i < self.height ? self[i] : [Character](repeating: padding, count: self.width)
      let rightRow = i < other.height ? other[i] : [Character](repeating: padding, count: other.width)
      result.append(leftRow + rightRow)
    }
    
    return result
  }
  
  func joinVertically(with other: MultilineString, padding: Character = " ") -> MultilineString {
    let maxWidth = Swift.max(self.width, other.width)
    var result = self
    
    for row in other {
      let paddedRow = row + [Character](repeating: padding, count: maxWidth - row.count)
      result.append(paddedRow)
    }
    
    return result
  }
  
  
  func joinWithCaps(
    leading: MultilineString,
    trailing: MultilineString,
    errorGlyph: Character = "!"
  ) -> MultilineString {
    let maxHeight = Swift.max(height, leading.height, trailing.height)
    var result = MultilineString([])
    
    for i in 0..<maxHeight {
      let leadingRow = i < leading.height ? leading[i] : [Character](repeating: errorGlyph, count: leading.width)
      let contentRow = i < height ? self[i] : [Character](repeating: " ", count: width)
      let trailingRow = i < trailing.height ? trailing[i] : [Character](repeating: errorGlyph, count: trailing.width)
      
      
      /// I didn't know this until just recently, but if you supply `String` with
      /// an array (or even, as below, multiple concatenated arrays!) of
      /// `[Character]`, Swift will initialise this as... a `String`.
      ///
      /// It makes sense, but it wasn't something I would have assumed until
      /// it was shown to me.
      ///
      /// That's what's happening here:
      /// `String(leadingCapRow + row + trailingCapRow)`
      ///
      result.append(leadingRow + contentRow + trailingRow)
    }
    
    return result
  }
}
