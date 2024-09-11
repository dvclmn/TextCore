//
//  Attributes.swift
//  TextCore
//
//  Created by Dave Coleman on 30/8/2024.
//


import AppKit
import Foundation

/// Is this a bit like `AttributeContainer`, for `NSAttributedString`?
///

public typealias Attributes = [NSAttributedString.Key: Any]

public extension Attributes {
  
  static let white: Attributes = [
    .foregroundColor: NSColor.textColor.withAlphaComponent(0.9)
  ]
  
  static let highlighter: Attributes = [
    .foregroundColor: NSColor.yellow,
    .backgroundColor: NSColor.orange.withAlphaComponent(0.6)
  ]
  
  static let codeBlock: Attributes = [
    .foregroundColor: NSColor.white,
    .backgroundColor: NSColor.darkGray,
    .font: NSFont.monospacedSystemFont(ofSize: 12, weight: .regular)
  ]
  
}

extension Attributes: Sendable {
  
}

public struct AttributeSet: ExpressibleByDictionaryLiteral, Sendable {
  nonisolated(unsafe) public var attributes: Attributes
  
  public init(dictionaryLiteral elements: (Attributes.Key, Attributes.Value)...) {
    self.attributes = Dictionary(uniqueKeysWithValues: elements)
  }
  
  public init(_ attributes: Attributes) {
    self.attributes = attributes
  }
  
  public subscript(_ key: Attributes.Key) -> Any? {
    get { attributes[key] }
    set { attributes[key] = newValue }
  }
}

extension AttributeSet {
  
  public static let highlighter: AttributeSet = [
    .foregroundColor: NSColor.yellow,
    .backgroundColor: NSColor.orange.withAlphaComponent(0.6)
  ]
  
  public static let codeBlock: AttributeSet = [
    .foregroundColor: NSColor.white,
    .backgroundColor: NSColor.darkGray,
    .font: NSFont.monospacedSystemFont(ofSize: 12, weight: .regular)
  ]
}

extension AttributeSet: Sequence {
  
  public func makeIterator() -> Dictionary<NSAttributedString.Key, Any>.Iterator {
    return attributes.makeIterator()
  }
}
