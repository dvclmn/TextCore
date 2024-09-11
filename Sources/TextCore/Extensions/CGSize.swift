//
//  CGSize.swift
//  TextCore
//
//  Created by Dave Coleman on 31/8/2024.
//

import Foundation

public extension CGSize {
  var widthOrHeightIsZero: Bool {
    return self.width.isZero || self.height.isZero
  }
  
}
