//
//  CloudKitConstants+Store.swift
//  
//
//  Created by Ben Gottlieb on 8/1/23.
//

import Foundation
import CloudKit

public extension CloudConstants {
	func store<Kind: CloudConstantType>(container identifier: String, suite: CloudConstantSuite = .current, key: String, subKey: String? = nil, value: Kind) async throws {
		let container = CKContainer(identifier: identifier)
		let db = container.publicCloudDatabase
		let recordID = generateRecordID(for: key, suite: suite, kind: subKey == nil ? Kind.self : nil)
		
		let record = (try? await db.record(for: recordID)) ?? CKRecord(recordType: recordType, recordID: recordID)
		record[subKey ?? "value"] = value.asCKRecordValue
		
		try await db.save(record)
	}
	
	func store(container identifier: String, key: String, suite: CloudConstantSuite = .current,  values: [String: any CloudConstantType]) async throws {
		let container = CKContainer(identifier: identifier)
		let db = container.publicCloudDatabase
		let recordID = generateRecordID(for: key, suite: suite, kind: nil)
		
		let record = (try? await db.record(for: recordID)) ?? CKRecord(recordType: recordType, recordID: recordID)
		for (key, value) in values {
			record[key] = value.asCKRecordValue
		}
		
		try await db.save(record)
	}
}
