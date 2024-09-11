//
//  Ranges.swift
//  TextCore
//
//  Created by Dave Coleman on 31/8/2024.
//

import Foundation

/// The attributed range as described below, pairs with the `ThreePartRegex` above,
/// and provides a mechism through which to identify where in the
/// `AttributedString` the resulting matches are located.
///
public typealias AttributedRange = Range<AttributedString.Index>

public typealias ThreePartRange = (AttributedRange, AttributedRange, AttributedRange)

