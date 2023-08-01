//
//  CloudConstantSuite.swift
//  EyeFull
//
//  Created by Ben Gottlieb on 8/1/23.
//

import Foundation

public enum CloudConstantSuite {
	case current
	case specific(String)
	case shared
	
	var identifier: String? {
		switch self {
		case .current: return Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String
		case .specific(let id): return id
		case .shared: return "shared"
		}
	}
}
