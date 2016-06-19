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

extension IosLog {

    func putToDb(connection: PostgreSQL.Connection) throws {

        let fields = "text,events,userId,date,osVersion,appVersion,idfa,context,bundle,apiKey,apiVersion,appBuildVersion,level,modelName,schema"

        let values = "'\(text)','\(events)','\(userId),'\(date),'\(osVersion),'\(appVersion),'\(idfa),'\(context),'\(bundle),'\(apiKey),'\(apiVersion),'\(appBuildVersion),'\(level),'\(modelName),'\(schema)"

        let stmt = "INSERT into \(tableName) (\(fields)) VALUES(\(values)) RETURNING id"

        _ = try connection.execute(stmt)
    }
}
