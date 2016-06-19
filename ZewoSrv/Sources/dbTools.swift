//
//  dbTools.swift
//  ZewoSrv
//
//  Created by Gorbenko Vladimir on 18/06/16.
//
//

import PostgreSQL

func getOpenConnection() throws -> Connection {

    #if os(Linux)
        let host = "ec2-174-129-223-35.compute-1.amazonaws.com"
        let port = 5432
        let database = "db046pq77t4051"
        let username = "foxbaunewkojkx"
        let password = "MzH90RnReUbhnjqHmdOcbyCmuZ"
    #else
        let host = "localhost"
        let port = 5432
        let database = "logger_development"
        let username = "volodg"
        let password = "H4d3yl8x"
    #endif

    let config = Connection.ConnectionInfo(
        host: host,
        port: port,
        databaseName: database,
        username: username,
        password: password,
        options: nil,
        tty: nil)

    let connection = Connection(config)
    try connection.open()

    return connection
}
