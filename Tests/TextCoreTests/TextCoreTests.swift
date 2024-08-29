//
//  TextCoreTests.swift
//  SwiftBox
//
//  Created by Dave Coleman on 29/8/2024.
//


import Foundation
import SwiftUI
import Testing

@testable import TextCore

@MainActor @Suite("TextCore tests")

struct MarkdownTextViewTests {
  
  let requiredColumnCount: Int = 32
  
  let exampleTitle: String = "Example title"
  
  
  @Test("Right line width and padding")
  func paddingAndLineWidth() {
    
    let result = TextCore.padLine(
      self.exampleTitle,
      with: "░",
      toFill: self.requiredColumnCount,
      caps: LineCaps("//", "//", hasExtraSpaces: true),
      hasSpaceAroundText: true
    )
    
    #expect(result.count == requiredColumnCount)
    
  }
  
}


