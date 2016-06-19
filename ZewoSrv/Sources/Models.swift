//
//  Models.swift
//  ZewoSrv
//
//  Created by Gorbenko Vladimir on 19/06/16.
//
//

import Foundation
import class PostgreSQL.Connection
import SQL

struct IosLog {

    let text           : String?
    let events         : String?
    let userId         : String?
    let date           : Date
    let osVersion      : String?
    let appVersion     : String?
    let idfa           : String?
    let context        : String?
    let bundle         : String?
    let apiKey         : String?
    let apiVersion     : String?
    let appBuildVersion: String?
    let level          : String?
    let modelName      : String?
    let schema         : String?//live dev beta
}

private enum SqlVal {

    case StringVal(String?)
    case DateVal(Date)

    func sqlValue() -> String {

        let result: String
        switch self {
        case .DateVal(let date):
            let formatter = DateFormatter.dbDateFormat()
            result = formatter.string(from: date)
        case .StringVal(let str):
            result = str ?? ""
        }
        return "'\(result)'"
    }
}

extension IosLog {

    func putToDb(connection: PostgreSQL.Connection) throws {

        let fields = "text,events,userId,date,osVersion,appVersion,idfa,context,bundle,apiKey,apiVersion,appBuildVersion,level,modelName,schema"

        let values: [SqlVal] = [
            .StringVal(text),
            .StringVal(events),
            .StringVal(userId),
            .DateVal(date),
            .StringVal(osVersion),
            .StringVal(appVersion),
            .StringVal(idfa),
            .StringVal(context),
            .StringVal(bundle),
            .StringVal(apiKey),
            .StringVal(apiVersion),
            .StringVal(appBuildVersion),
            .StringVal(level),
            .StringVal(modelName),
            .StringVal(schema),
        ]

        let sqlValues = values.map { $0.sqlValue() }
        let values_ = sqlValues.joined(separator: ",")

        let stmt = "INSERT into \(tableName) (\(fields)) VALUES(\(values_)) RETURNING id"

        _ = try connection.execute(stmt)
    }
}
