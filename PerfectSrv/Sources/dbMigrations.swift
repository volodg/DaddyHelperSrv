//
//  dbMigrations.swift
//  PerfectSrv
//
//  Created by Gorbenko Vladimir on 17/06/16.
//	Copyright (C) 2016 Volodymyr. All rights reserved.
//

import PerfectLib
import PostgreSQL

private func migrate0(connection: PGConnection) throws {

    let createTable = "CREATE TABLE IF NOT EXISTS ios_logs ("
    + "text text"
    + ", events text"
    + ", userId varchar(100)"
    + ", date timestamp with time zone"
    + ", osVersion varchar(100)"
    + ", appVersion varchar(100)"
    + ", idfa varchar(100)"
    + ", context text"
    + ", bundle varchar(100)"
    + ", apiKey varchar(100)"
    + ", apiVersion varchar(100)"
    + ", appBuildVersion varchar(100)"
    + ", level varchar(100)"
    + ", modelName varchar(100)"
    + ")"

    _ = try connection.execStatement { return connection.exec(statement: createTable) }
}

func migrateAll() throws {

    let connection = try getConnection()

    try migrate0(connection: connection)
}
