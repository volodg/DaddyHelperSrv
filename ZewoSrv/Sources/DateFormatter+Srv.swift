//
//  DateFormatter+Srv.swift
//  ZewoSrv
//
//  Created by Gorbenko Vladimir on 19/06/16.
//
//

import Foundation

extension DateFormatter {

    static func dbDateFormat() -> DateFormatter {

        let result = DateFormatter()
        result.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZZ"
        result.locale = Locale(localeIdentifier: "en_US_POSIX")

        return result
    }
}
