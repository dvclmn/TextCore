//
//  Artwork.swift
//  SwiftBox
//
//  Created by Dave Coleman on 29/8/2024.
//

import Foundation

public typealias Artwork = [[Character]]


public extension Artwork {
  static let `default`: Artwork = [["N"],["o"],[" "],["a"],["r"],["t"]]
  
  static let empty: Artwork = [[Character(" ")]]
}
