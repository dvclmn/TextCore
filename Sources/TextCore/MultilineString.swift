//
//  MultilineString.swift
//  TextCore
//
//  Created by Dave Coleman on 14/9/2024.
//

import Foundation

struct MultilineString: ExpressibleByArrayLiteral, CustomStringConvertible {
  private var grid: [[Character]]
  
  var description: String {
    grid.map { String($0) }.joined(separator: "\n")
  }
  
  init(arrayLiteral elements: [Character]...) {
    self.grid = elements
  }
  
  init(_ grid: [[Character]]) {
    self.grid = grid
  }
  
  var height: Int {
    return grid.count
  }
  
  var width: Int {
    return grid.map { $0.count }.max() ?? 0
  }
  
  subscript(row: Int) -> [Character] {
    get {
      guard row < grid.count else { return [] }
      return grid[row]
    }
  }
}

// Operator overloading for concatenation
func + (lhs: MultilineString, rhs: MultilineString) -> MultilineString {
  let maxHeight = max(lhs.height, rhs.height)
  var result: [[Character]] = []
  
  for i in 0..<maxHeight {
    let leftRow = i < lhs.height ? lhs[i] : []
    let rightRow = i < rhs.height ? rhs[i] : []
    result.append(leftRow + rightRow)
  }
  
  return MultilineString(result)
}

// For repeating a MultilineString
func * (lhs: MultilineString, rhs: Int) -> MultilineString {
  var result = lhs
  for _ in 1..<rhs {
    result = result + lhs
  }
  return result
}
