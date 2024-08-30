//
//  AttributeContainer+Presets.swift
//  TextCore
//
//  Created by Dave Coleman on 30/8/2024.
//

import Foundation
import SwiftUI

public extension AttributeContainer {
  static var blackOnWhite: AttributeContainer {
    return quickContainer()
  }
  
  static var whiteOnBlack: AttributeContainer {
    return quickContainer(with: .white, background: .black)
  }
  
  static func quickContainer(
    with foreground: Color = .black,
    background: Color = .white
  ) -> AttributeContainer {
    
    var container = AttributeContainer()
    container.foregroundColor = foreground
    container.backgroundColor = background
    
    return container
    
  }
}
