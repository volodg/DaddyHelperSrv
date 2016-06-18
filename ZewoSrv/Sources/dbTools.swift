//
//  dbTools.swift
//  ZewoSrv
//
//  Created by Gorbenko Vladimir on 18/06/16.
//
//

import PostgreSQL

func getOpenConnection() throws -> Connection {

    let config = Connection.ConnectionInfo(
        host: "localhost",
        port: 5432,
        databaseName: "logger_development",
        username: "volodg",
        password: "H4d3yl8x",
        options: nil,
        tty: nil)

    let connection = Connection(config)
    try connection.open()

    return connection
}
