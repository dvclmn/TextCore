//
//  MultilineString.swift
//  TextCore
//
//  Created by Dave Coleman on 14/9/2024.
//

import Foundation

public enum TrimMethod {
  case leaveSpace
  case crop
}

public struct MultilineString {
  
  private var grid: [[Character]]

  public init(_ grid: [[Character]]) {
    self.grid = grid
  }
  
  public init(_ string: String) {
    let lines = string.split(separator: "\n", omittingEmptySubsequences: false)
    self.init(lines.map { Array($0) })
  }

  
}

public extension MultilineString {
  
  
  public var string: String {
    grid.map { String($0) }.joined(separator: "\n")
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
    set {
      if row < grid.count {
        grid[row] = newValue
      } else if row == grid.count {
        grid.append(newValue)
      }
    }
  }
  
  var isEmpty: Bool {
    return grid.isEmpty || grid.allSatisfy { $0.isEmpty }
  }

}

extension MultilineString: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: [Character]...) {
    self.grid = elements
  }
  
}

extension MultilineString: CustomStringConvertible {
  public var description: String {
    self.string
  }
}

extension MultilineString: Sequence {
  
  public func makeIterator() -> IndexingIterator<[[Character]]> {
    return grid.makeIterator()
  }
  
  public func map<T>(_ transform: ([Character]) -> T) -> [T] {
    return grid.map(transform)
  }
  
  public func enumerated() -> EnumeratedSequence<[[Character]]> {
    return grid.enumerated()
  }
  
  
  
  mutating func append(_ row: [Character]) {
    grid.append(row)
  }
  
}

// Operator overloading for concatenation
public func + (lhs: MultilineString, rhs: MultilineString) -> MultilineString {
  let maxHeight = max(lhs.height, rhs.height)
  var result = MultilineString([])
  
  for i in 0..<maxHeight {
    let leftRow = i < lhs.height ? lhs[i] : []
    let rightRow = i < rhs.height ? rhs[i] : []
    result.append(leftRow + rightRow)
  }
  
  return result
}

// For repeating a MultilineString
public func * (lhs: MultilineString, rhs: Int) -> MultilineString {
  var result = MultilineString([])
  for _ in 0..<rhs {
    result = result + lhs
  }
  return result
}


