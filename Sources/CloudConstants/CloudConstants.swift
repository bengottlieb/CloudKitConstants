//
//  CloudConstants.swift
//  
//
//  Created by Ben Gottlieb on 8/1/23.
//

import Foundation
import CloudKit

public class CloudConstants {
	public static let instance = CloudConstants()
	
	public var defaultContainerIdentifier: String? = CloudConstants.bundleBasedContainerIdentifier
	
	
	public static var bundleBasedContainerIdentifier: String? {
		guard let bundleIdentifier = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String else { return nil }
		return "iCloud." + bundleIdentifier
	}
	
	public func defaultContainerIdentifier(_ id: String) {
		defaultContainerIdentifier = id
	}
	
	enum CloudConstantError: Error {
		case noContainerNameSpecified
	}
	
}
