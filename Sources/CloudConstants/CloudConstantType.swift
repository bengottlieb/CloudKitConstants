//
//  CloudConstantType.swift
//  
//
//  Created by Ben Gottlieb on 8/1/23.
//

import Foundation
import CloudKit

public protocol CloudConstantType {
	var asCKRecordValue: CKRecordValue { get }
	init?(recordValue: CKRecordValue?)
}

extension String: CloudConstantType {
	public var asCKRecordValue: CKRecordValue { self as CKRecordValue }
	public init?(recordValue: CKRecordValue?) {
		guard let result = recordValue as? String else { return nil }
		self = result
	}
}

extension Int: CloudConstantType  {
	public var asCKRecordValue: CKRecordValue { self as CKRecordValue }
	public init?(recordValue: CKRecordValue?) {
		guard let result = recordValue as? Int else { return nil }
		self = result
	}
}

extension Double: CloudConstantType  {
	public var asCKRecordValue: CKRecordValue { self as CKRecordValue }
	public init?(recordValue: CKRecordValue?) {
		guard let result = recordValue as? Double else { return nil }
		self = result
	}
}

extension Date: CloudConstantType  {
	public var asCKRecordValue: CKRecordValue { self as CKRecordValue }
	public init?(recordValue: CKRecordValue?) {
		guard let result = recordValue as? Date else { return nil }
		self = result
	}
}

extension Bool: CloudConstantType  {
	public var asCKRecordValue: CKRecordValue { self as CKRecordValue }
	public init?(recordValue: CKRecordValue?) {
		guard let result = recordValue as? Bool else { return nil }
		self = result
	}
}

extension Array: CloudConstantType where Element: CloudConstantType  {
	public var asCKRecordValue: CKRecordValue { self as CKRecordValue }
	public init?(recordValue: CKRecordValue?) {
		guard let result = recordValue as? [Element] else { return nil }
		self = result
	}
}

extension CKRecordValueProtocol {
	var cloudConstantType: Any? {
		if let string = String(recordValue: self as? CKRecordValue) { return string }
		if let int = Int(recordValue: self as? CKRecordValue) { return int }
		if let double = Double(recordValue: self as? CKRecordValue) { return double }
		if let date = Date(recordValue: self as? CKRecordValue) { return date }
		if let bool = Bool(recordValue: self as? CKRecordValue) { return bool }
		
		if let array = [String](recordValue: self as? CKRecordValue) { return array }
		if let array = [Int](recordValue: self as? CKRecordValue) { return array }
		if let array = [Double](recordValue: self as? CKRecordValue) { return array }
		if let array = [Date](recordValue: self as? CKRecordValue) { return array }
		if let array = [Bool](recordValue: self as? CKRecordValue) { return array }
		return nil
	}
}
