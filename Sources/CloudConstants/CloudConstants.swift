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
	
	public var defaultContainerIdentifier: String?
	
	public func defaultContainerIdentifier(_ id: String) {
		defaultContainerIdentifier = id
	}
	
	enum CloudConstantError: Error {
		case noContainerNameSpecified
	}
	
}
