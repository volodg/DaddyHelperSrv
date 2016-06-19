//
//  LinuxSupport.swift
//  ZewoSrv
//
//  Created by Gorbenko Vladimir on 19/06/16.
//
//

import Foundation

#if os(Linux)
    typealias Date = NSDate
    typealias DateFormatter = NSDateFormatter

    extension DateFormatter {
        func date(from string: String) -> Date? {
            return dateFromString(string)
        }
    }
#endif
