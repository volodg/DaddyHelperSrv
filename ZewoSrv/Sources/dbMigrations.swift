//
//  dbMigrations.swift
//  ZewoSrv
//
//  Created by Gorbenko Vladimir on 18/06/16.
//
//

import PostgreSQL

let tableName = "ios_logs"

private func migrate0(connection: Connection) throws {

    let createTable = "CREATE TABLE IF NOT EXISTS \(tableName) ("
        + "id SERIAL PRIMARY KEY"
        + ", text text"
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
        + ", schema varchar(100)"//live dev beta
        + ")"

    let status = try connection.execute(createTable)

    assert(status.status == .CommandOK)
}

func migrateAll() throws {

    let connection = try getOpenConnection()

    try migrate0(connection: connection)
}
