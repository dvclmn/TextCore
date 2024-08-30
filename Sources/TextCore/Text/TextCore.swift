//
//  TextCore.swift
//  SwiftBox
//
//  Created by Dave Coleman on 27/8/2024.
//

/// Common operations
///
/// 1. Find just enough whitespace to fill out a row of character to x-length
///

import SwiftUI
import BaseHelpers

public extension CGSize {
  var widthOrHeightIsZero: Bool {
    return self.width.isZero || self.height.isZero
  }
}

public enum DimensionForCell {
  case width, height
}

public extension BinaryFloatingPoint {
  
  func snapToCell(cellSize: CGSize, dimension: DimensionForCell = .width) -> CGFloat {
    
    let cellDimension = dimension == .width ? cellSize.width : cellSize.height
    
    if let value = self as? CGFloat {
      
      let multiplier = (value / cellDimension).rounded()
      return multiplier * cellDimension
      
    } else if let value = self as? Double {
      
      let multiplier = (value / cellDimension).rounded()
      return multiplier * cellDimension
      
    } else {
      
      return .zero
    }
    
    
    
  }
}
