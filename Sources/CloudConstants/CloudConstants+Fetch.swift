//
//  CloudConstants+Fetch.swift
//  
//
//  Created by Ben Gottlieb on 8/1/23.
//

import Foundation
import CloudKit

public extension CloudConstants {
	func fetch<Kind: CloudConstantType>(container id: String? = nil, suite: CloudConstantSuite = .current, key: String, subKey: String? = nil) async -> Kind? {
		guard let identifier = id ?? defaultContainerIdentifier else { return nil }
		
		let container = CKContainer(identifier: identifier)
		let db = container.publicCloudDatabase
		let recordID = generateRecordID(for: key, suite: suite, kind: subKey == nil ? Kind.self : nil)

		do {
			let record = try await db.record(for: recordID)
			let raw = record[subKey ?? "value"]
			
			return .init(recordValue: raw)
		} catch {
			if (error as? CKError)?.code != .unknownItem {
				print("Failed to fetch CloudKit Record: \(error)")
			}
			return nil
		}
	}
	
	func fetch(container id: String? = nil, suite: CloudConstantSuite = .current, dictionaryNamed name: String) async -> [String: CloudConstantType]? {
		guard let identifier = id ?? defaultContainerIdentifier else { return nil }
		
		let container = CKContainer(identifier: identifier)
		let db = container.publicCloudDatabase
		let recordID = generateRecordID(for: name, suite: suite, kind: nil)

		do {
			let record = try await db.record(for: recordID)
			var results: [String: CloudConstantType] = [:]
			
			for (key, value) in record {
				if let constantValue = value.cloudConstantType as? CloudConstantType {
					results[key] = constantValue
				}
			}
			
			return results
		} catch {
			print("Failed to fetch CloudKit Record: \(error)")
			return nil
		}
	}
	
	func generateRecordID(for key: String, suite: CloudConstantSuite, kind: CloudConstantType.Type?) -> CKRecord.ID {
		var prefix = suite.identifier ?? ""
		if !prefix.isEmpty { prefix += "-" }
		prefix += key
		
		if let kind { return CKRecord.ID(recordName: prefix + "-\(kind)") }
		return CKRecord.ID(recordName: prefix + "-dictionary")
	}
	
	var recordType: CKRecord.RecordType { "CloudConstantRecord" }
}

