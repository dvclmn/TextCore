//
//  Attributes.swift
//  TextCore
//
//  Created by Dave Coleman on 30/8/2024.
//


import AppKit
import Foundation


public typealias Attributes = [NSAttributedString.Key: Any]

public struct AttributeSet: ExpressibleByDictionaryLiteral, Sendable {
  
  public var attributes: Attributes
  
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

public extension AttributeSet {
  
  static let white: AttributeSet = [
    .foregroundColor: NSColor.textColor.withAlphaComponent(0.9)
  ]
  
  static let highlighter: AttributeSet = [
    .foregroundColor: NSColor.yellow,
    .backgroundColor: NSColor.orange.withAlphaComponent(0.6)
  ]
  
  static let codeBlock: AttributeSet = [
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
