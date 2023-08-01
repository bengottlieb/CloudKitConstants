//
//  CloudConstants+Fetch.swift
//  
//
//  Created by Ben Gottlieb on 8/1/23.
//

import Foundation
import CloudKit

public extension CloudConstants {
	func fetch<Kind: CloudConstantType>(container id: String? = nil, key: String, subKey: String? = nil, defaultValue: Kind) async throws -> Kind {
		guard let identifier = id ?? defaultContainerIdentifier else { throw CloudConstantError.noContainerNameSpecified }
		
		let container = CKContainer(identifier: identifier)
		let db = container.publicCloudDatabase
		let recordID = generateRecordID(for: key, kind: subKey == nil ? Kind.self : nil)

		let record = try await db.record(for: recordID)
		let raw = record[subKey ?? "value"]
		
		return .init(recordValue: raw) ?? defaultValue
	}
	
	func fetch(container id: String? = nil, dictionaryNamed name: String) async throws -> [String: CloudConstantType]? {
		guard let identifier = id ?? defaultContainerIdentifier else { throw CloudConstantError.noContainerNameSpecified }
		
		let container = CKContainer(identifier: identifier)
		let db = container.publicCloudDatabase
		let recordID = generateRecordID(for: name, kind: nil)

		let record = try await db.record(for: recordID)
		var results: [String: CloudConstantType] = [:]
		
		for (key, value) in record {
			if let constantValue = value.cloudConstantType as? CloudConstantType {
				results[key] = constantValue
			}
		}
		
		return nil
	}
	
	func generateRecordID(for key: String, kind: CloudConstantType.Type?) -> CKRecord.ID {
		if let kind { return CKRecord.ID(recordName: key + "-\(kind)") }
		return CKRecord.ID(recordName: key + "-dictionary")
	}
	
	var recordType: CKRecord.RecordType { "CloudConstantRecord" }
}

