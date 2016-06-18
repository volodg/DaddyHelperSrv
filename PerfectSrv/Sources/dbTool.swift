//
//  dbTool.swift
//  PerfectSrv
//
//  Created by Gorbenko Vladimir on 17/06/16.
//	Copyright (C) 2016 Volodymyr. All rights reserved.
//

import PerfectLib
import PostgreSQL

//doc: https://www.postgresql.org/docs/8.1/static/libpq.html
private let postgresTestConnInfo = "host=localhost dbname=logger_development user=volodg password=H4d3yl8x"

struct SrvError : ErrorProtocol {

    let message: String
}

extension PGConnection {

    func execConnection(block: () -> PGConnection.StatusType) throws {

        let status = block()

        if status != .OK {
            throw SrvError(message: "can not perform sql qeury: \(errorMessage())")
        }
    }

    func execStatement(block: () -> PGResult) throws -> PGResult {

        let result = block()

        if result.status() != .CommandOK {
            throw SrvError(message: "can not perform sql qeury: \(errorMessage())")
        }

        return result
    }
}

func getConnection() throws -> PGConnection {

    let result = PGConnection()
    try result.execConnection { result.connectdb(postgresTestConnInfo) }
    return result
}
